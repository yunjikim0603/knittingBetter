package comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
//import javax.naming.NamingException;//삭제
import javax.sql.DataSource;

import board.BoardBean;

public class CommentDAO {
	public Connection getConnection() throws Exception {
		Connection con = null;
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
		con=ds.getConnection();
		return con;
	}

	//content에 댓글 작성
	public int insertComment(CommentBean cb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int comm_num = 0;
		try {
			con = getConnection();
			//comm_num 최대값 구하기
			String sql = "select max(comm_num) from comment";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				comm_num = rs.getInt("max(comm_num)") + 1;
			}
			//댓글 추가
			sql = "insert into comment values (?,?,?,?,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, comm_num);
			pstmt.setInt(2, cb.getBoard_num());//board 번호
			pstmt.setString(3, cb.getComm_id());
			pstmt.setString(4, cb.getComm_content());
			pstmt.executeUpdate();
			//board DB에 댓글수 증가
			sql = "update board set cmtCount = cmtCount + 1 where num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, cb.getBoard_num());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try{rs.close();} catch (SQLException e) {}
			if(pstmt != null) try{pstmt.close();} catch (SQLException e) {}
			if(con != null) try{con.close();} catch (SQLException e) {}
		}
		
		//board 번호 전달
		return cb.getBoard_num();
	}
	
	//총 댓글 갯수
	public int getCommentCount(int num) {
		int count = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			String sql = "select count(*) from comment where board_num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num); //확인
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt("count(*)");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try{rs.close();} catch (SQLException e) {}
			if(pstmt != null) try{pstmt.close();} catch (SQLException e) {}
			if(con != null) try{con.close();} catch (SQLException e) {}
		}
		
		return count;
	}
	
	//board 번호로 댓글리스트 가져오기
	public List getCommentList(int board_num, int startRow, int size) {
		List list = new ArrayList();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			String sql = "select * from comment where board_num = ? order by comm_date desc limit ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, board_num);
			pstmt.setInt(2, startRow-1);
			pstmt.setInt(3, size);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				CommentBean cb = new CommentBean();
				cb.setComm_num(rs.getInt("comm_num"));
				cb.setBoard_num(rs.getInt("board_num"));
				cb.setComm_id(rs.getString("comm_id"));
				cb.setComm_content(rs.getString("comm_content"));
				cb.setComm_date(rs.getTimestamp("comm_date"));
				list.add(cb);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try{rs.close();} catch (SQLException e) {}
			if(pstmt != null) try{pstmt.close();} catch (SQLException e) {}
			if(con != null) try{con.close();} catch (SQLException e) {}
		}
		
		return list;
	}
	
	//댓글 가져오기
	public CommentBean getComment(int comm_num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		CommentBean cb = null;
		try {
			con = getConnection();
			String sql = "select * from comment where comm_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, comm_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				cb = new CommentBean();
				cb.setComm_num(rs.getInt("comm_num"));
				cb.setComm_content(rs.getString("comm_content"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try{rs.close();} catch (SQLException e) {}
			if(pstmt != null) try{pstmt.close();} catch (SQLException e) {}
			if(con != null) try{con.close();} catch (SQLException e) {}
		}
		return cb;
	}
	
	//댓글 수정
	public void updateComment(CommentBean cb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = getConnection();
			String sql = "update comment set comm_content=? where comm_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, cb.getComm_content());
			pstmt.setInt(2, cb.getComm_num());
			pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try{pstmt.close();} catch (SQLException e) {}
			if(con != null) try{con.close();} catch (SQLException e) {}
		}
	}
	
	//댓글 삭제
	public int deleteComment(int comm_num, int board_num) {
		int count = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			String sql = "delete from comment where comm_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, comm_num);
			pstmt.executeUpdate();
			//cmtCount 1 줄이기
			sql = "update board set cmtCount = cmtCount - 1 where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, board_num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try{rs.close();} catch (SQLException e) {}
			if(pstmt != null) try{pstmt.close();} catch (SQLException e) {}
			if(con != null) try{con.close();} catch (SQLException e) {}
		}
		return count;
	}
	

	

	
	
}
