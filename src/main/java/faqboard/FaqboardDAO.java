package faqboard;
// java 파일 수정 시 반드시 서버 재시작!
import java.sql.*;	// java sql package의 모든 것을 불러옴
import javax.sql.*;
import javax.naming.*;

import java.util.List;	// List 사용을 위해 import로 추가
import java.util.ArrayList;	// ArrayList 사용을 위해 import로 추가

public class FaqboardDAO {
	private static FaqboardDAO instance = new FaqboardDAO();
	
	public static FaqboardDAO getInstance() {
		return instance;
	}
	
	private FaqboardDAO() {	}
	
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
			
			String sql = "select id, passwd from member where id=?";	// 쿼리 구문
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
	public void insertfaqboard(FaqboardVO article) {
		Connection conn = null;			// 데이터베이스 연결할 객체
		PreparedStatement pstmt = null;	// query 실행 객체
		
		try{
			conn = getConnection(); //connection 객체를 할당 받음
			
			//insert into board(writer, email, subject, passwd, reg_date, content)
			// values('jhi', 'aaa@gmail.com','제목', 'bye', now(), '내용1');
			String sql = "insert into faqboard(writer, subject, passwd, reg_date, content)"
					+ " values(?, ?, ?, now(), ?)";	// 쿼리 구문 - 위치 홀더 이용
			pstmt  = conn.prepareStatement(sql);	// sql을 실행하기 위한 객체 생성하기
			pstmt.setString(1, article.getWriter());	// - 위치 홀더 지정
			pstmt.setString(2, article.getSubject());
			pstmt.setString(3, article.getPasswd());			
			pstmt.setString(4, article.getContent());
			pstmt.executeUpdate();	// sql query 실행
					
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("faqboard 테이블 삽입에 문제가 발생했습니다.");
		}finally{	// 5. 자원 해제
			if(pstmt != null) try{pstmt.close();} catch(SQLException se) {};
			if(conn != null) try{conn.close();} catch(SQLException se) {};	//연결 해제
		}
	}
	
	// 게시글 수 반환 메서드
	public int getArticleCount() {
		Connection conn = null;			// 데이터베이스 연결할 객체
		PreparedStatement pstmt = null;	// query 실행 객체
		ResultSet rs = null;			// select문 실행 결과를 저장하는 객체
		int result = 0;
		
		try {
			conn = getConnection();
			
			String sql = "select count(*) from faqboard";	// 쿼리 구문
			pstmt  = conn.prepareStatement(sql);	// 3. sql을 실행하기 위한 객체 생성하기
			rs = pstmt.executeQuery();	// 4. sql query 실행 -  개수 반환
			
			// ↓ result set의 next가 존재할 경우 값이 저장됨
			if(rs.next()){	// 없으면 0이 반환됨
				result = rs.getInt(1);
			}
			
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("faqboard 테이블의 자료 수 검색에 실패했습니다.");
		}finally{	// 5. 자원 해제
			if(rs != null) try{rs.close();}catch(SQLException se){}		// 예외 처리 해줘야함
			if(pstmt != null) try{pstmt.close();}catch(SQLException se){}
			if(conn != null) try{conn.close();}catch(SQLException se){}	// 연결 해제
		}
		
		return result;
	}
	
	//검색 기능 추가
	public int getArticleCount(String sword) {
		Connection conn = null;
		PreparedStatement pstmt = null; // query 실행
		ResultSet rs = null;
		int result = 0;
		
		try {			
			conn = getConnection();			
			
			//select count(*) from book where btitle like '%자료%';
			String sql = "select count(*) from faqboard where subject like ?";
			pstmt = conn.prepareStatement(sql); //3. sql query를 실행하기 위한 객체 생성하기
			pstmt.setString(1, sword);
			rs = pstmt.executeQuery(); //4. sql query 실행
			
			if(rs.next()) {
				result = rs.getInt(1);				
			} 			
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("faqboard 테이블의 특정 subject의 레코드 전체 수 검색을 실패했습니다.");
		} finally {
			//5. 자원 해제
			if(rs != null) try {rs.close();} catch(SQLException se) { }
			if(pstmt != null) try {pstmt.close();} catch(SQLException se) { }
			if(conn != null) try {conn.close();} catch(SQLException se) { }
		}
		
		return result;
	}
	
	public int getMemberArticleCount(String id) {
		Connection conn = null;			// 데이터베이스 연결할 객체
		PreparedStatement pstmt = null;	// query 실행 객체
		ResultSet rs = null;			// select문 실행 결과를 저장하는 객체
		int result = 0;
		
		try {
			conn = getConnection();
			
			String sql = "select count(*) from faqboard where writer=?";	// 쿼리 구문
			pstmt  = conn.prepareStatement(sql);	// 3. sql을 실행하기 위한 객체 생성하기
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();	// 4. sql query 실행 -  개수 반환
			
			// ↓ result set의 next가 존재할 경우 값이 저장됨
			if(rs.next()){	// 없으면 0이 반환됨
				result = rs.getInt(1);
			}
			
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("faqboard 테이블에서 특정 사용자가 작성한 게시글 수 검색에 실패했습니다.");
		}finally{	// 5. 자원 해제
			if(rs != null) try{rs.close();}catch(SQLException se){}		// 예외 처리 해줘야함
			if(pstmt != null) try{pstmt.close();}catch(SQLException se){}
			if(conn != null) try{conn.close();}catch(SQLException se){}	// 연결 해제
		}
		
		return result;
	}
	
	// 상세 글 보기
	public List<FaqboardVO> getArticles(int start, int end){
		Connection conn = null;			// 데이터베이스 연결할 객체
		PreparedStatement pstmt = null;	// query 실행 객체
		ResultSet rs = null;			// select문 실행 결과를 저장하는 객체
		List<FaqboardVO> alist = null;		// return 값
		
		try {
			conn = getConnection();
			                                                    // 게시글 개수 제한
			String sql = "select * from faqboard order by num desc limit ?, ?;";	// 쿼리 구문
			pstmt  = conn.prepareStatement(sql);	// 3. sql을 실행하기 위한 객체 생성하기
			pstmt.setInt(1, start-1);	// mysql은 0번이 1번이므로 -1을 해야함
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();	// 4. sql query 실행 -  개수 반환
			
			// ↓ result set의 next가 존재할 경우 값이 저장됨
			if(rs.next()){	// 없으면 0이 반환됨
				alist = new ArrayList<FaqboardVO>(end);	// 배열의 개수지정 = 한 페이지에 표시할 게시물의 개수 지정
				do {
					FaqboardVO article = new FaqboardVO();	// 같은 board 패키지 내에 있기 때문에 import를 하지 않아도 객체 생성이 가능
					article.setNum(rs.getInt("num"));
					article.setWriter(rs.getString("writer"));
					article.setSubject(rs.getString("subject"));
					article.setReg_date(rs.getTimestamp("reg_date"));
					article.setReadcount(rs.getInt("readcount"));
					article.setContent(rs.getString("content"));
					
					alist.add(article);
				}while(rs.next());
			}
			
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("faqboard 테이블의 자료 검색에 실패했습니다.");
		}finally{	// 5. 자원 해제
			if(rs != null) try{rs.close();}catch(SQLException se){}		// 예외 처리 해줘야함
			if(pstmt != null) try{pstmt.close();}catch(SQLException se){}
			if(conn != null) try{conn.close();}catch(SQLException se){}	// 연결 해제
		}
		
		return alist;
	}
	
	public List<FaqboardVO> getArticles(int start, int end, String sword) {
		Connection conn = null;
		PreparedStatement pstmt = null; // query 실행
		ResultSet rs = null;
		List<FaqboardVO> articleList = null;
		//System.out.println(start + " - " + end);
		try {			
			conn = getConnection();			
			
			String sql = "select * from faqboard where subject like ? order by num desc limit ?, ?";
			pstmt = conn.prepareStatement(sql); //3. sql query를 실행하기 위한 객체 생성하기
			pstmt.setString(1, sword);
			pstmt.setInt(2, start-1);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery(); //4. sql query 실행
			
			if(rs.next()) {
				articleList = new ArrayList<FaqboardVO>();
				do {
					FaqboardVO article = new FaqboardVO();	// 같은 board 패키지 내에 있기 때문에 import를 하지 않아도 객체 생성이 가능
					article.setNum(rs.getInt("num"));
					article.setWriter(rs.getString("writer"));
					article.setSubject(rs.getString("subject"));
					article.setReg_date(rs.getTimestamp("reg_date"));
					article.setReadcount(rs.getInt("readcount"));
					article.setContent(rs.getString("content"));
					
					articleList.add(article);
				} while(rs.next());				
			}
			
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("faqboard 테이블에 새로운 레코드 추가를 실패했습니다.");
		} finally {
			//5. 자원 해제
			if(rs != null) try {rs.close();} catch(SQLException se) { }
			if(pstmt != null) try {pstmt.close();} catch(SQLException se) { }
			if(conn != null) try {conn.close();} catch(SQLException se) { }
		}
		
		return articleList;
	}
	
	public List<FaqboardVO> getMemberArticles(String id, int start, int end){
		Connection conn = null;			// 데이터베이스 연결할 객체
		PreparedStatement pstmt = null;	// query 실행 객체
		ResultSet rs = null;			// select문 실행 결과를 저장하는 객체
		List<FaqboardVO> alist = null;		// return 값
		
		try {
			conn = getConnection();
			                                                    // 게시글 개수 제한
			String sql = "select * from faqboard where writer=? order by num desc limit ?, ?;";	// 쿼리 구문
			pstmt  = conn.prepareStatement(sql);	// 3. sql을 실행하기 위한 객체 생성하기
			pstmt.setString(1, id);
			pstmt.setInt(2, start-1);	// mysql은 0번이 1번이므로 -1을 해야함
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();	// 4. sql query 실행 -  개수 반환
			
			// ↓ result set의 next가 존재할 경우 값이 저장됨
			if(rs.next()){	// 없으면 0이 반환됨
				alist = new ArrayList<FaqboardVO>(end);	// 배열의 개수지정 = 한 페이지에 표시할 게시물의 개수 지정
				do {
					FaqboardVO article = new FaqboardVO();	// 같은 board 패키지 내에 있기 때문에 import를 하지 않아도 객체 생성이 가능
					article.setNum(rs.getInt("num"));
					article.setWriter(rs.getString("writer"));
					article.setSubject(rs.getString("subject"));
					article.setReg_date(rs.getTimestamp("reg_date"));
					article.setReadcount(rs.getInt("readcount"));
					article.setContent(rs.getString("content"));
					
					alist.add(article);
				}while(rs.next());
			}
			
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("faqboard 테이블의 자료 검색에 실패했습니다.");
		}finally{	// 5. 자원 해제
			if(rs != null) try{rs.close();}catch(SQLException se){}		// 예외 처리 해줘야함
			if(pstmt != null) try{pstmt.close();}catch(SQLException se){}
			if(conn != null) try{conn.close();}catch(SQLException se){}	// 연결 해제
		}
		
		return alist;
	}
	
	public List<FaqboardVO> getArticles(){
		Connection conn = null;			// 데이터베이스 연결할 객체
		PreparedStatement pstmt = null;	// query 실행 객체
		ResultSet rs = null;			// select문 실행 결과를 저장하는 객체
		List<FaqboardVO> alist = null;		// return 값
		
		try {
			conn = getConnection();
			                                                    // 게시글 개수 제한
			String sql = "select * from faqboard order by num;";	// 쿼리 구문
			pstmt  = conn.prepareStatement(sql);	// 3. sql을 실행하기 위한 객체 생성하기
			rs = pstmt.executeQuery();	// 4. sql query 실행 -  개수 반환
			
			// ↓ result set의 next가 존재할 경우 값이 저장됨
			if(rs.next()){	// 없으면 0이 반환됨
				alist = new ArrayList<FaqboardVO>();	// 배열의 개수지정 = 한 페이지에 표시할 게시물의 개수 지정
				do {
					FaqboardVO article = new FaqboardVO();	// 같은 board 패키지 내에 있기 때문에 import를 하지 않아도 객체 생성이 가능
					article.setNum(rs.getInt("num"));
					article.setWriter(rs.getString("writer"));
					article.setSubject(rs.getString("subject"));
					article.setReg_date(rs.getTimestamp("reg_date"));
					article.setReadcount(rs.getInt("readcount"));
					article.setContent(rs.getString("content"));
					
					alist.add(article);
				}while(rs.next());
			}
			
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("faqboard 테이블의 자료 검색에 실패했습니다.");
		}finally{	// 5. 자원 해제
			if(rs != null) try{rs.close();}catch(SQLException se){}		// 예외 처리 해줘야함
			if(pstmt != null) try{pstmt.close();}catch(SQLException se){}
			if(conn != null) try{conn.close();}catch(SQLException se){}	// 연결 해제
		}
		
		return alist;
	}
	
	// 수정을 위한 상세글
	public FaqboardVO getArticleUpdate(int num){
		Connection conn = null;			// 데이터베이스 연결할 객체
		PreparedStatement pstmt = null;	// query 실행 객체
		ResultSet rs = null;			// select문 실행 결과를 저장하는 객체
		FaqboardVO article = null;		// return 값
		
		try {
			conn = getConnection();
			
			String sql = "select * from faqboard where num=?;";	// 쿼리 구문
			pstmt  = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();	// 4. sql query 실행 -  개수 반환
			
			// ↓ result set의 next가 존재할 경우 값이 저장됨
			if(rs.next()){
				article = new FaqboardVO();
				article.setNum(rs.getInt("num"));
				article.setWriter(rs.getString("writer"));
				article.setSubject(rs.getString("subject"));
				article.setReg_date(rs.getTimestamp("reg_date"));
				article.setReadcount(rs.getInt("readcount"));
				article.setContent(rs.getString("content"));
			}
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("faqboard 테이블의 상세보기 레코드 검색에 실패했습니다.");
		}finally{	// 5. 자원 해제
			if(rs != null) try{rs.close();}catch(SQLException se){}		// 예외 처리 해줘야함
			if(pstmt != null) try{pstmt.close();}catch(SQLException se){}
			if(conn != null) try{conn.close();}catch(SQLException se){}	// 연결 해제
		}
		
		return article;
	}

	public FaqboardVO getArticle(int num){
		Connection conn = null;			// 데이터베이스 연결할 객체
		PreparedStatement pstmt = null;	// query 실행 객체
		ResultSet rs = null;			// select문 실행 결과를 저장하는 객체
		FaqboardVO article = null;		// return 값
		
		try {
			conn = getConnection();
			
			String sql = "update faqboard set readcount=readcount+1 where num=?;";	// 쿼리 구문
			pstmt  = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate(); // 4. sql query 실행 -  개수 반환
			
			sql = "select * from faqboard where num=?;";	// 쿼리 구문
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();	// 4. sql query 실행 -  개수 반환
			
			// ↓ result set의 next가 존재할 경우 값이 저장됨
			if(rs.next()){
				article = new FaqboardVO();
				article.setNum(rs.getInt("num"));
				article.setWriter(rs.getString("writer"));
				article.setSubject(rs.getString("subject"));
				article.setReg_date(rs.getTimestamp("reg_date"));
				article.setReadcount(rs.getInt("readcount"));
				article.setContent(rs.getString("content"));
			}
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("faqboard 테이블의 상세보기 레코드 검색에 실패했습니다.");
		}finally{	// 5. 자원 해제
			if(rs != null) try{rs.close();}catch(SQLException se){}		// 예외 처리 해줘야함
			if(pstmt != null) try{pstmt.close();}catch(SQLException se){}
			if(conn != null) try{conn.close();}catch(SQLException se){}	// 연결 해제
		}
		
		return article;
	}
	
	// 게시물을 수정하는 메서드
	public int updatefaqboard(FaqboardVO article) {	
		Connection conn = null;			// 데이터베이스 연결할 객체
		PreparedStatement pstmt = null;	// query 실행 객체
		ResultSet rs = null;			// select문 실행 결과를 저장하는 객체
		
		int result = 0;
		
		try {
			conn = getConnection();
			
			String sql = "select passwd from faqboard where num=?";	// 쿼리 구문
			pstmt  = conn.prepareStatement(sql);	// 3. sql을 실행하기 위한 객체 생성하기
			pstmt.setInt(1, article.getNum());	// 함수를 호출할 때 전달받은 해당 게시물의 num 값
			rs = pstmt.executeQuery();	// 4. sql query 실행
			
			System.out.println("----select 실행:" + article.getNum());
			
			// ↓ result set의 next가 존재할 경우 값이 저장됨
			if(rs.next()){
				String rpasswd = rs.getString("passwd");	//	실제 db에 저장된 passwd 값
				if(rpasswd.equals(article.getPasswd())){
					result = 1;	// 1 : 인증 성공.
					
					sql = "update faqboard set writer=?, subject=?, content=? where num=?;";	// 쿼리 구문
					pstmt  = conn.prepareStatement(sql);
					pstmt.setString(1, article.getWriter());
					pstmt.setString(2, article.getSubject());
					pstmt.setString(3, article.getContent());
					pstmt.setInt(4, article.getNum());
					pstmt.executeUpdate(); // 4. sql query 실행 -  개수 반환
					
				} else{	//패스워드가 틀린경우
					result = 0;	// 0 : 패스워드 틀림.
				}
			}
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("faqboard 테이블의 글 수정에 문제가 발생했습니다.");
		}finally{	// 5. 자원 해제
			if(rs != null) try{rs.close();}catch(SQLException se){}		// 예외 처리 해줘야함
			if(pstmt != null) try{pstmt.close();}catch(SQLException se){}
			if(conn != null) try{conn.close();}catch(SQLException se){}	//연결 해제
		}
		
		return result;
	}

	// 게시물을 삭제하는 메서드
	public int deletefaqboard(int num) {	
		Connection conn = null;			// 데이터베이스 연결할 객체
		PreparedStatement pstmt = null;	// query 실행 객체
		ResultSet rs = null;			// select문 실행 결과를 저장하는 객체
		
		int result = 0;
		
		try {
			conn = getConnection();
				
			String sql = "delete from faqboard where num=?;";	// 쿼리 구문
			pstmt  = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate(); // 4. sql query 실행 -  개수 반환
					
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("faqboard 테이블의 글 삭제에 문제가 발생했습니다.");
		}finally{	// 5. 자원 해제
			if(rs != null) try{rs.close();}catch(SQLException se){}		// 예외 처리 해줘야함
			if(pstmt != null) try{pstmt.close();}catch(SQLException se){}
			if(conn != null) try{conn.close();}catch(SQLException se){}	//연결 해제
		}
		
		return result;
	}
	

}
