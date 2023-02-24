package galleryboard;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.naming.InitialContext;
import javax.sql.DataSource;

public class GalleryDAO {

	private static GalleryDAO instance = new GalleryDAO();
	
	public static GalleryDAO getInstance() {
		return instance;
	}
	
	private GalleryDAO() { }
	
	private Connection getConnection() {		
		try {
			InitialContext ic = new InitialContext(); // JNDI 서버 객체 생성 
			DataSource ds = (DataSource)ic.lookup("java:comp/env/jdbc/depart"); // connection 객체 찾기
			Connection conn = ds.getConnection(); // connection 객체를 할당 받음
			return conn;
		} catch(Exception e) {
			System.out.println("데이터베이스 연결에 문제가 발생했습니다.");
			return null;
		}				
	}
	
	public void insertBoard(GalleryVO article) {		
		Connection conn = null;
		PreparedStatement pstmt = null; // query 실행
		
		try {			
			conn = getConnection();
			
			String sql = "insert into gallery(gtitle, greg_date, gimage)";
			sql += "values (?, ?, ?)";
			pstmt = conn.prepareStatement(sql); //3. sql query를 실행하기 위한 객체 생성하기
			pstmt.setString(1, article.getGtitle());
			pstmt.setTimestamp(2, article.getGreg_date());
			pstmt.setString(3, article.getGimage());
			
			System.out.println("----사진파일명:" + article.getGimage());
			
			pstmt.executeUpdate(); //4. sql query 실행
			
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("gallery 테이블에 새로운 레코드 추가에 실패했습니다.");
		} finally {
			//5. 자원 해제
			if(pstmt != null) try {pstmt.close();} catch(SQLException se) { }
			if(conn != null) try {conn.close();} catch(SQLException se) { }
		}
	}
	
	public List<GalleryVO> getArticles(int start, int end) {
		Connection conn = null;
		PreparedStatement pstmt = null; // query 실행
		ResultSet rs = null;
		List<GalleryVO> articleList = null;
		//System.out.println(start + " - " + end);
		try {			
			conn = getConnection();			
			
			String sql = "select * from gallery order by gnum desc limit ?, ?";
			pstmt = conn.prepareStatement(sql); //3. sql query를 실행하기 위한 객체 생성하기
			pstmt.setInt(1, start-1);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery(); //4. sql query 실행
			
			if(rs.next()) {
				articleList = new ArrayList<GalleryVO>();
				do {
					GalleryVO article = new GalleryVO();
					article.setGnum(rs.getInt("gnum"));
					article.setGtitle(rs.getString("gtitle"));
					article.setGreg_date(rs.getTimestamp("greg_date"));
					article.setGimage(rs.getString("gimage"));
					
					articleList.add(article);
				} while(rs.next());				
			}
			
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("gallery 테이블에 새로운 레코드 추가를 실패했습니다.");
		} finally {
			//5. 자원 해제
			if(rs != null) try {rs.close();} catch(SQLException se) { }
			if(pstmt != null) try {pstmt.close();} catch(SQLException se) { }
			if(conn != null) try {conn.close();} catch(SQLException se) { }
		}
		
		return articleList;
	}
	
	public int getArticleCount() {
		Connection conn = null;
		PreparedStatement pstmt = null; // query 실행
		ResultSet rs = null;
		int result = 0;
		
		try {			
			conn = getConnection();			
			
			String sql = "select count(*) from gallery";
			pstmt = conn.prepareStatement(sql); //3. sql query를 실행하기 위한 객체 생성하기
			rs = pstmt.executeQuery(); //4. sql query 실행
			
			if(rs.next()) {
				result = rs.getInt(1);				
			} 			
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("gallery 테이블의 레코드 전체수 검색을 실패했습니다.");
		} finally {
			//5. 자원 해제
			if(rs != null) try {rs.close();} catch(SQLException se) { }
			if(pstmt != null) try {pstmt.close();} catch(SQLException se) { }
			if(conn != null) try {conn.close();} catch(SQLException se) { }
		}
		
		return result;
	}
	
	public GalleryVO getArticle(int num) {
		Connection conn = null;
		PreparedStatement pstmt = null; // query 실행
		ResultSet rs = null;
		GalleryVO article = null;
		
		try {			
			conn = getConnection();	
			
			String sql = "select * from gallery where gnum=?";
			pstmt = conn.prepareStatement(sql); //3. sql query를 실행하기 위한 객체 생성하기
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery(); //4. sql query 실행
			
			if(rs.next()) {
				article = new GalleryVO();
				article.setGnum(rs.getInt("gnum"));
				article.setGtitle(rs.getString("gtitle"));
				article.setGreg_date(rs.getTimestamp("greg_date"));
				article.setGimage(rs.getString("gimage"));		
			}
			
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("gallery 테이블에 상세보기의 레코드 검색을 실패했습니다.");
		} finally {
			//5. 자원 해제
			if(rs != null) try {rs.close();} catch(SQLException se) { }
			if(pstmt != null) try {pstmt.close();} catch(SQLException se) { }
			if(conn != null) try {conn.close();} catch(SQLException se) { }
		}
		
		return article;
	}	

	public void updateGallery(GalleryVO article) {		
		Connection conn = null;
		PreparedStatement pstmt = null; // query 실행
		ResultSet rs = null;
		
		try {			
			conn = getConnection();
			
			String sql = "update gallery set gtitle=?, greg_date=?, gimage=? where gnum=?";
			pstmt = conn.prepareStatement(sql); //3. sql query를 실행하기 위한 객체 생성하기
			pstmt.setString(1, article.getGtitle());
			pstmt.setTimestamp(2, article.getGreg_date());
			pstmt.setString(3, article.getGimage());
			pstmt.setInt(4, article.getGnum());
			
			pstmt.executeUpdate(); //4. sql query 실행

		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("gallery 테이블의 글 수정을 실패했습니다.");
		} finally {
			//5. 자원 해제
			if(rs != null) try {rs.close();} catch(SQLException se) { }
			if(pstmt != null) try {pstmt.close();} catch(SQLException se) { }
			if(conn != null) try {conn.close();} catch(SQLException se) { }
		}

	}
	
	public void deleteGallery(int num) {		
		Connection conn = null;
		PreparedStatement pstmt = null; // query 실행
		ResultSet rs = null;
		
		try {			
			conn = getConnection();

			String sql = "delete from gallery where gnum=?";
			pstmt = conn.prepareStatement(sql); //3. sql query를 실행하기 위한 객체 생성하기
			pstmt.setInt(1, num);
			
			pstmt.executeUpdate(); //4. sql query 실행

		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("gallery 테이블의 글 삭제를 실패했습니다.");
		} finally {
			//5. 자원 해제
			if(rs != null) try {rs.close();} catch(SQLException se) { }
			if(pstmt != null) try {pstmt.close();} catch(SQLException se) { }
			if(conn != null) try {conn.close();} catch(SQLException se) { }
		}

	}
}
