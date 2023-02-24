package reply;
// java 파일 수정 시 반드시 서버 재시작!
import java.sql.*;	// java sql package의 모든 것을 불러옴
import javax.sql.*;
import javax.naming.*;


import java.util.List;	// List 사용을 위해 import로 추가
import java.util.ArrayList;	// ArrayList 사용을 위해 import로 추가

public class ReplyDAO {
	private static ReplyDAO instance = new ReplyDAO();
	
	public static ReplyDAO getInstance() {
		return instance;
	}
	
	private ReplyDAO() {	}
	
	// 이 데이터베이스에 접근하는 메서드
	private Connection getConnection() {
		try {
			// 커넥션 풀(connection pools) 설정
			InitialContext  ic = new InitialContext();		// JNDI 서버 객체 생성자 메서드
			DataSource ds = (DataSource)ic.lookup("java:comp/env/jdbc/depart");	//connection 객체 찾기, ~/env/까지는 고정값이고 그 다음부터 설정가능
			Connection conn = ds.getConnection(); //connection 객체를 할당 받음
			
			return conn;
		}catch(Exception e){
			System.out.println("데이터베이스 연결에 문제가 발생했습니다.");
			return null;
		}
	}
	
	public int userCheck(String id, String passwd) {	
		Connection conn = null;			// 데이터베이스 연결할 객체
		PreparedStatement pstmt = null;	// query 실행 객체
		ResultSet rs = null;			// select문 실행 결과를 저장하는 객체
		
		int result = -1;
		
		try {
			conn = getConnection();
			
			String sql = "select id, passwd from reply where id=?;";	// 쿼리 구문
			pstmt  = conn.prepareStatement(sql);	// 3. sql을 실행하기 위한 객체 생성하기
			pstmt.setString(1, id);	// 함수를 호출할 때 전달받은 id
			rs = pstmt.executeQuery();	// 4. sql query 실행
			
			// ↓ result set의 next가 존재할 경우 값이 저장됨
			if(rs.next()){
				String rid = rs.getString("id");	//	테이블의 컬럼명으로 값을 가져옴
				String rpasswd = rs.getString("passwd");	//	resultset으로 가져온 값을 다시 변수로 저장
				if(id.equals(rid) && passwd.equals(rpasswd)){
					result = 1;	// 1 : 인증 성공.
					
				}else{	//아이디는 맞지만 패스워드가 틀린경우
					result = 0;	// 0 : 패스워드 틀림.
				}
			}else{
				result = -1;	// -1 : 해당 아이디 없음.
			}
			
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("아이디, 패스워드 확인에 문제가 발생했습니다.");
		}finally{	// 5. 자원 해제
			if(rs != null) try{rs.close();}catch(SQLException se){}		// 예외 처리 해줘야함
			if(pstmt != null) try{pstmt.close();}catch(SQLException se){}
			if(conn != null) try{conn.close();}catch(SQLException se){}	//연결 해제
		}
		
		return result;
	}
	
	// 게시판 글 삽입 메서드
	public void insertReply(ReplyVO article) {
		Connection conn = null;			// 데이터베이스 연결할 객체
		PreparedStatement pstmt = null;	// query 실행 객체
		
		try{
			conn = getConnection(); //connection 객체를 할당 받음
			
			//insert into board(writer, email, subject, passwd, reg_date, content)
			// values('jhi', 'aaa@gmail.com','제목', 'bye', now(), '내용1');
			String sql = "insert into reply(rwriter, reply, rreg_date, ref)"
					+ " values(?, ?, now(), ?);";	// 쿼리 구문 - 위치 홀더 이용
			pstmt  = conn.prepareStatement(sql);	// sql을 실행하기 위한 객체 생성하기
			pstmt.setString(1, article.getRwriter());	// - 위치 홀더 지정
			pstmt.setString(2, article.getReply());
			pstmt.setInt(3, article.getRef());
			pstmt.executeUpdate();	// sql query 실행
					
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("reply 테이블 삽입에 문제가 발생했습니다.");
		}finally{	// 5. 자원 해제
			if(pstmt != null) try{pstmt.close();} catch(SQLException se) {};
			if(conn != null) try{conn.close();} catch(SQLException se) {};	//연결 해제
		}
	}
	
	// 게시글 수 반환 메서드
	public int getArticleCount(int ref) {
		Connection conn = null;			// 데이터베이스 연결할 객체
		PreparedStatement pstmt = null;	// query 실행 객체
		ResultSet rs = null;			// select문 실행 결과를 저장하는 객체
		int result = 0;
		
		try {
			conn = getConnection();
			
			String sql = "select count(*) from reply where ref=?;";	// 쿼리 구문
			pstmt  = conn.prepareStatement(sql);	// 3. sql을 실행하기 위한 객체 생성하기
			pstmt.setInt(1, ref);
			rs = pstmt.executeQuery();	// 4. sql query 실행 -  개수 반환
			
			// ↓ result set의 next가 존재할 경우 값이 저장됨
			if(rs.next()){	// 없으면 0이 반환됨
				result = rs.getInt(1);
			}
			
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("reply 테이블의 자료 수 검색에 실패했습니다.");
		}finally{	// 5. 자원 해제
			if(rs != null) try{rs.close();}catch(SQLException se){}		// 예외 처리 해줘야함
			if(pstmt != null) try{pstmt.close();}catch(SQLException se){}
			if(conn != null) try{conn.close();}catch(SQLException se){}	// 연결 해제
		}
		
		return result;
	}
	
	// 전체 댓글 수 반환 메서드
	public int getArticleCount() {
		Connection conn = null;			// 데이터베이스 연결할 객체
		PreparedStatement pstmt = null;	// query 실행 객체
		ResultSet rs = null;			// select문 실행 결과를 저장하는 객체
		int result = 0;
		
		try {
			conn = getConnection();
			
			String sql = "select count(*) from reply;";	// 쿼리 구문
			pstmt  = conn.prepareStatement(sql);	// 3. sql을 실행하기 위한 객체 생성하기
			rs = pstmt.executeQuery();	// 4. sql query 실행 -  개수 반환
			
			// ↓ result set의 next가 존재할 경우 값이 저장됨
			if(rs.next()){	// 없으면 0이 반환됨
				result = rs.getInt(1);
			}
			
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("reply 테이블의 자료 수 검색에 실패했습니다.");
		}finally{	// 5. 자원 해제
			if(rs != null) try{rs.close();}catch(SQLException se){}		// 예외 처리 해줘야함
			if(pstmt != null) try{pstmt.close();}catch(SQLException se){}
			if(conn != null) try{conn.close();}catch(SQLException se){}	// 연결 해제
		}
		
		return result;
	}
	
	// 전체 댓글 수 반환 메서드
	public int getMemberArticleCount(String id) {
		Connection conn = null;			// 데이터베이스 연결할 객체
		PreparedStatement pstmt = null;	// query 실행 객체
		ResultSet rs = null;			// select문 실행 결과를 저장하는 객체
		int result = 0;
		
		try {
			conn = getConnection();
			
			String sql = "select count(*) from reply where rwriter=?";	// 쿼리 구문
			pstmt  = conn.prepareStatement(sql);	// 3. sql을 실행하기 위한 객체 생성하기
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();	// 4. sql query 실행 -  개수 반환
			
			// ↓ result set의 next가 존재할 경우 값이 저장됨
			if(rs.next()){	// 없으면 0이 반환됨
				result = rs.getInt(1);
			}
			
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("reply 테이블에서 특정 사용자가 작성한 댓글 수 검색에 실패했습니다.");
		}finally{	// 5. 자원 해제
			if(rs != null) try{rs.close();}catch(SQLException se){}		// 예외 처리 해줘야함
			if(pstmt != null) try{pstmt.close();}catch(SQLException se){}
			if(conn != null) try{conn.close();}catch(SQLException se){}	// 연결 해제
		}
		
		return result;
	}
	
	// 상세 글 보기
	public List<ReplyVO> getArticles(int ref){
		Connection conn = null;			// 데이터베이스 연결할 객체
		PreparedStatement pstmt = null;	// query 실행 객체
		ResultSet rs = null;			// select문 실행 결과를 저장하는 객체
		List<ReplyVO> alist = null;		// return 값
		
		try {
			conn = getConnection();
			                                                    // 게시글 개수 제한
			String sql = "select * from reply where ref=? order by rnum;";	// 쿼리 구문
			pstmt  = conn.prepareStatement(sql);	// 3. sql을 실행하기 위한 객체 생성하기
			pstmt.setInt(1, ref);	// mysql은 0번이 1번이므로 -1을 해야함
			rs = pstmt.executeQuery();	// 4. sql query 실행 -  개수 반환
			
			// ↓ result set의 next가 존재할 경우 값이 저장됨
			if(rs.next()){	// 없으면 0이 반환됨
				alist = new ArrayList<ReplyVO>(ref);	// 배열의 개수지정 = 한 페이지에 표시할 게시물의 개수 지정
				do {
					ReplyVO article = new ReplyVO();	// 같은 board 패키지 내에 있기 때문에 import를 하지 않아도 객체 생성이 가능
					article.setRnum(rs.getInt("rnum"));
					article.setRwriter(rs.getString("rwriter"));
					article.setReply(rs.getString("reply"));
					article.setReg_date(rs.getTimestamp("rreg_date"));
					article.setRef(rs.getInt("ref"));
					
					alist.add(article);
				}while(rs.next());
			}
			
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("reply 테이블의 자료 검색에 실패했습니다.");
		}finally{	// 5. 자원 해제
			if(rs != null) try{rs.close();}catch(SQLException se){}		// 예외 처리 해줘야함
			if(pstmt != null) try{pstmt.close();}catch(SQLException se){}
			if(conn != null) try{conn.close();}catch(SQLException se){}	// 연결 해제
		}
		
		return alist;
	}
	
	// 상세 글 보기
	public List<ReplyVO> getArticles(int start, int end){
		Connection conn = null;			// 데이터베이스 연결할 객체
		PreparedStatement pstmt = null;	// query 실행 객체
		ResultSet rs = null;			// select문 실행 결과를 저장하는 객체
		List<ReplyVO> alist = null;		// return 값
		
		try {
			conn = getConnection();
			                                                    // 게시글 개수 제한
			String sql = "select * from reply order by rnum desc limit ?, ?;";	// 쿼리 구문
			pstmt  = conn.prepareStatement(sql);	// 3. sql을 실행하기 위한 객체 생성하기
			pstmt.setInt(1, start-1);	// mysql은 0번이 1번이므로 -1을 해야함
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();	// 4. sql query 실행 -  개수 반환
			
			// ↓ result set의 next가 존재할 경우 값이 저장됨
			if(rs.next()){	// 없으면 0이 반환됨
				alist = new ArrayList<ReplyVO>();	// 배열의 개수지정 = 한 페이지에 표시할 게시물의 개수 지정
				do {
					ReplyVO article = new ReplyVO();	// 같은 board 패키지 내에 있기 때문에 import를 하지 않아도 객체 생성이 가능
					article.setRnum(rs.getInt("rnum"));
					article.setRwriter(rs.getString("rwriter"));
					article.setReply(rs.getString("reply"));
					article.setReg_date(rs.getTimestamp("rreg_date"));
					article.setRef(rs.getInt("ref"));
					
					alist.add(article);
				}while(rs.next());
			}
			
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("reply 테이블의 자료 검색에 실패했습니다.");
		}finally{	// 5. 자원 해제
			if(rs != null) try{rs.close();}catch(SQLException se){}		// 예외 처리 해줘야함
			if(pstmt != null) try{pstmt.close();}catch(SQLException se){}
			if(conn != null) try{conn.close();}catch(SQLException se){}	// 연결 해제
		}
		
		return alist;
	}
	
	public List<ReplyVO> getMemberArticles(String id, int start, int end){
		Connection conn = null;			// 데이터베이스 연결할 객체
		PreparedStatement pstmt = null;	// query 실행 객체
		ResultSet rs = null;			// select문 실행 결과를 저장하는 객체
		List<ReplyVO> alist = null;		// return 값
		
		try {
			conn = getConnection();
			                                                    // 게시글 개수 제한
			String sql = "select * from reply where rwriter=? order by rnum desc limit ?, ?;";	// 쿼리 구문
			pstmt  = conn.prepareStatement(sql);	// 3. sql을 실행하기 위한 객체 생성하기
			pstmt.setString(1, id);
			pstmt.setInt(2, start-1);	// mysql은 0번이 1번이므로 -1을 해야함
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();	// 4. sql query 실행 -  개수 반환
			
			// ↓ result set의 next가 존재할 경우 값이 저장됨
			if(rs.next()){	// 없으면 0이 반환됨
				alist = new ArrayList<ReplyVO>();	// 배열의 개수지정 = 한 페이지에 표시할 게시물의 개수 지정
				do {
					ReplyVO article = new ReplyVO();	// 같은 board 패키지 내에 있기 때문에 import를 하지 않아도 객체 생성이 가능
					article.setRnum(rs.getInt("rnum"));
					article.setRwriter(rs.getString("rwriter"));
					article.setReply(rs.getString("reply"));
					article.setReg_date(rs.getTimestamp("rreg_date"));
					article.setRef(rs.getInt("ref"));
					
					alist.add(article);
				}while(rs.next());
			}
			
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("reply 테이블의 자료 검색에 실패했습니다.");
		}finally{	// 5. 자원 해제
			if(rs != null) try{rs.close();}catch(SQLException se){}		// 예외 처리 해줘야함
			if(pstmt != null) try{pstmt.close();}catch(SQLException se){}
			if(conn != null) try{conn.close();}catch(SQLException se){}	// 연결 해제
		}
		
		return alist;
	}
	
	// 게시물을 삭제하는 메서드
	public int deletereply(int rnum) {	
		Connection conn = null;			// 데이터베이스 연결할 객체
		PreparedStatement pstmt = null;	// query 실행 객체
		ResultSet rs = null;			// select문 실행 결과를 저장하는 객체
		
		int result = 0;
		
		try {
			conn = getConnection();
			
			String sql = "delete from reply where rnum=?;";	// 쿼리 구문
			pstmt  = conn.prepareStatement(sql);
			pstmt.setInt(1, rnum);
			pstmt.executeUpdate(); // 4. sql query 실행 -  개수 반환
					
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("reply 테이블의 글 삭제에 문제가 발생했습니다.");
		}finally{	// 5. 자원 해제
			if(rs != null) try{rs.close();}catch(SQLException se){}		// 예외 처리 해줘야함
			if(pstmt != null) try{pstmt.close();}catch(SQLException se){}
			if(conn != null) try{conn.close();}catch(SQLException se){}	//연결 해제
		}
		
		return result;
	}

	// 게시물을 삭제하는 메서드
	public int deleteMemberreply(String id) {	
		Connection conn = null;			// 데이터베이스 연결할 객체
		PreparedStatement pstmt = null;	// query 실행 객체
		ResultSet rs = null;			// select문 실행 결과를 저장하는 객체
		
		int result = 0;
		
		try {
			conn = getConnection();
			
			String sql = "delete from reply where writer=?;";	// 쿼리 구문
			pstmt  = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.executeUpdate(); // 4. sql query 실행 -  개수 반환
					
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("reply 테이블의 글 삭제에 문제가 발생했습니다.");
		}finally{	// 5. 자원 해제
			if(rs != null) try{rs.close();}catch(SQLException se){}		// 예외 처리 해줘야함
			if(pstmt != null) try{pstmt.close();}catch(SQLException se){}
			if(conn != null) try{conn.close();}catch(SQLException se){}	//연결 해제
		}
		
		return result;
	}
	
}
