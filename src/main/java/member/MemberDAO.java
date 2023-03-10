package member;
// java 파일 수정 시 반드시 서버 재시작!
import java.sql.*;	// java sql package의 모든 것을 불러옴
import javax.sql.*;

import notice.NoticeVO;

import javax.naming.*;


import java.util.List;	// List 사용을 위해 import로 추가
import java.util.ArrayList;	// ArrayList 사용을 위해 import로 추가

public class MemberDAO {
	private static MemberDAO instance = new MemberDAO();
	
	public static MemberDAO getInstance() {
		return instance;
	}
	
	private MemberDAO() {	}
	
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
	
	// 아이디 확인 메서드
	public int idCheck(String id) {	
		Connection conn = null;			// 데이터베이스 연결할 객체
		PreparedStatement pstmt = null;	// query 실행 객체
		ResultSet rs = null;			// select문 실행 결과를 저장하는 객체
		
		int result = -1;
		
		try {
			conn = getConnection();
			
			String sql = "select * from member where id=?";	// 쿼리 구문
			pstmt  = conn.prepareStatement(sql);	// 3. sql을 실행하기 위한 객체 생성하기
			pstmt.setString(1, id);	// 함수를 호출할 때 전달받은 id
			rs = pstmt.executeQuery();	// 4. sql query 실행
			
			// ↓ result set의 next가 존재할 경우 값이 저장됨
			if(rs.next()){
				result = 1;	// 1 : 아이디가 이미 존재
			}else{
				result = -1;	// -1 : 해당 아이디 없음.
			}
			
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("member 테이블의 아이디 확인에 문제가 발생했습니다.");
		}finally{	// 5. 자원 해제
			if(rs != null) try{rs.close();}catch(SQLException se){}		// 예외 처리 해줘야함
			if(pstmt != null) try{pstmt.close();}catch(SQLException se){}
			if(conn != null) try{conn.close();}catch(SQLException se){}	//연결 해제
		}
		
		return result;
	}

	
	// 게시판 글 삽입 메서드
	public void insertMember(MemberVO article) {
		Connection conn = null;			// 데이터베이스 연결할 객체
		PreparedStatement pstmt = null;	// query 실행 객체
		
		try{
			conn = getConnection(); //connection 객체를 할당 받음
			
			//insert into Member(writer, email, subject, passwd, reg_date, content)
			// values('jhi', 'aaa@gmail.com','제목', 'bye', now(), '내용1');
			String sql = "insert into member(id, passwd, name, email, reg_date)"
					+ " values(?, ?, ?, ?, now())";	// 쿼리 구문 - 위치 홀더 이용
			pstmt  = conn.prepareStatement(sql);	// sql을 실행하기 위한 객체 생성하기
			pstmt.setString(1, article.getId());	// - 위치 홀더 지정
			pstmt.setString(2, article.getPasswd());
			pstmt.setString(3, article.getName());
			pstmt.setString(4, article.getEmail());
			pstmt.executeUpdate();	// sql query 실행
					
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("테이블 삽입에 문제가 발생했습니다.");
		}finally{	// 5. 자원 해제
			if(pstmt != null) try{pstmt.close();} catch(SQLException se) {};
			if(conn != null) try{conn.close();} catch(SQLException se) {};	//연결 해제
		}
	}
	
	// 회원 수 반환 메서드
	public int getMemberCount() {
		Connection conn = null;			// 데이터베이스 연결할 객체
		PreparedStatement pstmt = null;	// query 실행 객체
		ResultSet rs = null;			// select문 실행 결과를 저장하는 객체
		int result = 0;
		
		try {
			conn = getConnection();
			
			String sql = "select count(*) from member";	// 쿼리 구문
			pstmt  = conn.prepareStatement(sql);	// 3. sql을 실행하기 위한 객체 생성하기
			rs = pstmt.executeQuery();	// 4. sql query 실행 -  개수 반환
			
			// ↓ result set의 next가 존재할 경우 값이 저장됨
			if(rs.next()){	// 없으면 0이 반환됨
				result = rs.getInt(1);
			}
			
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("member 테이블의 자료 수 검색에 실패했습니다.");
		}finally{	// 5. 자원 해제
			if(rs != null) try{rs.close();}catch(SQLException se){}		// 예외 처리 해줘야함
			if(pstmt != null) try{pstmt.close();}catch(SQLException se){}
			if(conn != null) try{conn.close();}catch(SQLException se){}	// 연결 해제
		}
		
		return result;
	}

	public int getMemberCount(String sword) {
		Connection conn = null;
		PreparedStatement pstmt = null; // query 실행
		ResultSet rs = null;
		int result = 0;
		
		try {			
			conn = getConnection();			
			
			//select count(*) from book where btitle like '%자료%';
			String sql = "select count(*) from member where id like ?";
			pstmt = conn.prepareStatement(sql); //3. sql query를 실행하기 위한 객체 생성하기
			pstmt.setString(1, sword);
			rs = pstmt.executeQuery(); //4. sql query 실행
			
			if(rs.next()) {
				result = rs.getInt(1);				
			} 			
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("member 테이블의 특정 id의 레코드 전체 수 검색을 실패했습니다.");
		} finally {
			//5. 자원 해제
			if(rs != null) try {rs.close();} catch(SQLException se) { }
			if(pstmt != null) try {pstmt.close();} catch(SQLException se) { }
			if(conn != null) try {conn.close();} catch(SQLException se) { }
		}
		
		return result;
	}

	
	// 상세 글 보기
	public List<MemberVO> getMembers(int start, int end){
		Connection conn = null;			// 데이터베이스 연결할 객체
		PreparedStatement pstmt = null;	// query 실행 객체
		ResultSet rs = null;			// select문 실행 결과를 저장하는 객체
		List<MemberVO> alist = null;		// return 값
		
		try {
			conn = getConnection();
			
			String sql = "select * from member order by reg_date desc limit ?, ?;";
			pstmt = conn.prepareStatement(sql); // 3. sql을 실행할기 위한 객체 생성하기
			pstmt.setInt(1, start-1);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery(); // 4. sql query 실행됨
			
			// ↓ result set의 next가 존재할 경우 값이 저장됨
			if(rs.next()){	// 없으면 0이 반환됨
				alist = new ArrayList<MemberVO>(end);	// 배열의 개수지정 = 한 페이지에 표시할 게시물의 개수 지정
				do {
					MemberVO member = new MemberVO();	// 같은 Member 패키지 내에 있기 때문에 import를 하지 않아도 객체 생성이 가능
					member.setId(rs.getString("id"));
					member.setPasswd(rs.getString("passwd"));
					member.setName(rs.getString("name"));
					member.setEmail(rs.getString("email"));
					member.setReg_date(rs.getTimestamp("reg_date"));
					
					alist.add(member);
				}while(rs.next());
			}
			
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("member 테이블의 자료 검색에 실패했습니다.");
		}finally{	// 5. 자원 해제
			if(rs != null) try{rs.close();}catch(SQLException se){}		// 예외 처리 해줘야함
			if(pstmt != null) try{pstmt.close();}catch(SQLException se){}
			if(conn != null) try{conn.close();}catch(SQLException se){}	// 연결 해제
		}
		
		return alist;
	}
	public List<MemberVO> getMembers(int start, int end, String sword) {
		Connection conn = null;
		PreparedStatement pstmt = null; // query 실행
		ResultSet rs = null;
		List<MemberVO> alist = null;
		//System.out.println(start + " - " + end);
		try {			
			conn = getConnection();			
			
			String sql = "select * from member where id like ? order by reg_date desc limit ?, ?";
			pstmt = conn.prepareStatement(sql); //3. sql query를 실행하기 위한 객체 생성하기
			pstmt.setString(1, sword);
			pstmt.setInt(2, start-1);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery(); //4. sql query 실행
			
			if(rs.next()) {
				alist = new ArrayList<MemberVO>(end);	// 배열의 개수지정 = 한 페이지에 표시할 게시물의 개수 지정
				do {
					MemberVO member = new MemberVO();	// 같은 Member 패키지 내에 있기 때문에 import를 하지 않아도 객체 생성이 가능
					member.setId(rs.getString("id"));
					member.setPasswd(rs.getString("passwd"));
					member.setName(rs.getString("name"));
					member.setEmail(rs.getString("email"));
					member.setReg_date(rs.getTimestamp("reg_date"));
					
					alist.add(member);
				} while(rs.next());				
			}
			
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("member 테이블의 자료 검색에 실패했습니다.");
		} finally {
			//5. 자원 해제
			if(rs != null) try {rs.close();} catch(SQLException se) { }
			if(pstmt != null) try {pstmt.close();} catch(SQLException se) { }
			if(conn != null) try {conn.close();} catch(SQLException se) { }
		}
		
		return alist;
	}
	
	// 수정을 위한 상세글
	public MemberVO getMemberUpdate(String id){
		Connection conn = null;			// 데이터베이스 연결할 객체
		PreparedStatement pstmt = null;	// query 실행 객체
		ResultSet rs = null;			// select문 실행 결과를 저장하는 객체
		MemberVO member = null;		// return 값
		
		try {
			conn = getConnection();
			
			String sql = "select * from member where id=?;";	// 쿼리 구문
			pstmt  = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();	// 4. sql query 실행 -  개수 반환
			
			// ↓ result set의 next가 존재할 경우 값이 저장됨
			if(rs.next()){
				member = new MemberVO();
				member.setId(rs.getString("id"));
				member.setPasswd(rs.getString("passwd"));
				member.setName(rs.getString("name"));
				member.setEmail(rs.getString("email"));
				member.setReg_date(rs.getTimestamp("reg_date"));
			}
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("member 테이블의 상세보기 레코드 검색에 실패했습니다.");
		}finally{	// 5. 자원 해제
			if(rs != null) try{rs.close();}catch(SQLException se){}		// 예외 처리 해줘야함
			if(pstmt != null) try{pstmt.close();}catch(SQLException se){}
			if(conn != null) try{conn.close();}catch(SQLException se){}	// 연결 해제
		}
		
		return member;
	}

	public MemberVO getMember(String id){
		Connection conn = null;			// 데이터베이스 연결할 객체
		PreparedStatement pstmt = null;	// query 실행 객체
		ResultSet rs = null;			// select문 실행 결과를 저장하는 객체
		MemberVO member = null;		// return 값
		
		try {
			conn = getConnection();
			
			String sql = "select * from member where id=?;";	// 쿼리 구문
			pstmt  = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();	// 4. sql query 실행 -  개수 반환
			
			// ↓ result set의 next가 존재할 경우 값이 저장됨
			if(rs.next()){
				member = new MemberVO();
				member.setId(rs.getString("id"));
				member.setPasswd(rs.getString("passwd"));
				member.setName(rs.getString("name"));
				member.setEmail(rs.getString("email"));
				member.setReg_date(rs.getTimestamp("reg_date"));
			}
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("Member 테이블의 상세보기 레코드 검색에 실패했습니다.");
		}finally{	// 5. 자원 해제
			if(rs != null) try{rs.close();}catch(SQLException se){}		// 예외 처리 해줘야함
			if(pstmt != null) try{pstmt.close();}catch(SQLException se){}
			if(conn != null) try{conn.close();}catch(SQLException se){}	// 연결 해제
		}
		
		return member;
	}
	
	// 게시물을 수정하는 메서드
	public int updateMember(MemberVO article) {	
		Connection conn = null;			// 데이터베이스 연결할 객체
		PreparedStatement pstmt = null;	// query 실행 객체
		ResultSet rs = null;			// select문 실행 결과를 저장하는 객체
		
		int result = 0;
		
		try {
			conn = getConnection();
			
			String sql = "select passwd from member where id=?";	// 쿼리 구문
			pstmt  = conn.prepareStatement(sql);	// 3. sql을 실행하기 위한 객체 생성하기
			pstmt.setString(1, article.getId());	// 함수를 호출할 때 전달받은 해당 게시물의 num 값
			rs = pstmt.executeQuery();	// 4. sql query 실행
			
			System.out.println("----select 실행:" + article.getId());
			
			// ↓ result set의 next가 존재할 경우 값이 저장됨
			if(rs.next()){
				String rpasswd = rs.getString("passwd");	//	실제 db에 저장된 passwd 값
				if(rpasswd.equals(article.getPasswd())){
					result = 1;	// 1 : 인증 성공.
					
					sql = "update Member set passwd=?, name=?, email=? where id=?;";	// 쿼리 구문
					pstmt  = conn.prepareStatement(sql);
					pstmt.setString(1, article.getPasswd());
					pstmt.setString(2, article.getName());
					pstmt.setString(3, article.getEmail());
					pstmt.setString(4, article.getId());
					pstmt.executeUpdate(); // 4. sql query 실행 -  개수 반환
					
				} else{	//패스워드가 틀린경우
					result = 0;	// 0 : 패스워드 틀림.
				}
			}
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("member 테이블의 글 수정에 문제가 발생했습니다.");
		}finally{	// 5. 자원 해제
			if(rs != null) try{rs.close();}catch(SQLException se){}		// 예외 처리 해줘야함
			if(pstmt != null) try{pstmt.close();}catch(SQLException se){}
			if(conn != null) try{conn.close();}catch(SQLException se){}	//연결 해제
		}
		
		return result;
	}

	// 게시물을 삭제하는 메서드
	public int deleteMember(String id, String passwd) {	
		Connection conn = null;			// 데이터베이스 연결할 객체
		PreparedStatement pstmt = null;	// query 실행 객체
		ResultSet rs = null;			// select문 실행 결과를 저장하는 객체
		int result = 0;
		
		try {
			conn = getConnection();
			
			String sql = "select passwd from member where id=?;";	// 쿼리 구문
			pstmt  = conn.prepareStatement(sql);	// 3. sql을 실행하기 위한 객체 생성하기
			pstmt.setString(1, id);	// 함수를 호출할 때 전달받은 해당 게시물의 num 값
			rs = pstmt.executeQuery();	// 4. sql query 실행
				
			// ↓ result set의 next가 존재할 경우 값이 저장됨
			if(rs.next()){
				String rpasswd = rs.getString("passwd");	//	실제 db에 저장된 passwd 값
								
				if(rpasswd.equals(passwd)){
					result = 1;	// 1 : 인증 성공.
					
					sql = "delete from member where id=?;";	// 쿼리 구문
					pstmt  = conn.prepareStatement(sql);
					pstmt.setString(1, id);
					pstmt.executeUpdate(); // 4. sql query 실행 -  개수 반환
					
				} else{	//패스워드가 틀린경우
					result = 0;	// 0 : 패스워드 틀림.
				}
			}
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("member 테이블의 글 삭제에 문제가 발생했습니다.");
		}finally{	// 5. 자원 해제
			if(rs != null) try{rs.close();}catch(SQLException se){}		// 예외 처리 해줘야함
			if(pstmt != null) try{pstmt.close();}catch(SQLException se){}
			if(conn != null) try{conn.close();}catch(SQLException se){}	//연결 해제
		}
		
		return result;
	}
	
	// 회원을 삭제하는 메서드 - 오버로딩, 관리자 사용
	public int deleteMember(String id) {	
		Connection conn = null;			// 데이터베이스 연결할 객체
		PreparedStatement pstmt = null;	// query 실행 객체
		int result = 0;
		
		try {
			conn = getConnection();
			
			String sql = "delete from member where id=?";	// 쿼리 구문
			pstmt  = conn.prepareStatement(sql);	// 3. sql을 실행하기 위한 객체 생성하기
			pstmt.setString(1, id);	// 함수를 호출할 때 전달받은 해당 게시물의 num 값
			pstmt.executeUpdate();	// 4. sql query 실행
			
			result = 1;
			System.out.println("----delete 실행:" + id);
			
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("member 테이블의 글 삭제에 문제가 발생했습니다!");
		}finally{	// 5. 자원 해제
			if(pstmt != null) try{pstmt.close();}catch(SQLException se){}
			if(conn != null) try{conn.close();}catch(SQLException se){}	//연결 해제
		}
		
		return result;
	}

}
