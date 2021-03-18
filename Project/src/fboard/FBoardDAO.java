package fboard;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class FBoardDAO {
	
	public Connection getConnection() throws Exception {
		
		Connection con = null;
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
		con=ds.getConnection();
		return con;
	}
	
	
	
	
	
	public List getBoardList(int startRow,int pageSize) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List boardList=new ArrayList();
		
		String sql="";
		
		
		try {
		con=getConnection();
		
		sql="select * from fboard order by num desc limit ?,?";
		
		pstmt=con.prepareStatement(sql);
		pstmt.setInt(1, startRow-1);
		pstmt.setInt(2, pageSize);
		
		rs=pstmt.executeQuery();
		
		while(rs.next()) {
			FBoardBean bb=new FBoardBean();
			bb.setContent(rs.getString("content"));
			bb.setDate(rs.getTimestamp("date"));
			bb.setName(rs.getString("name"));
			bb.setNum(rs.getInt("num"));
			bb.setPass(rs.getString("pass"));
			bb.setReadcount(rs.getInt("readcount"));
			bb.setSubject(rs.getString("subject"));
			//배열 한칸 한개의 글 저장
			boardList.add(bb);
		}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) try { rs.close();} catch(SQLException ex) {}
			if(pstmt!=null) try { pstmt.close();} catch(SQLException ex) {}
			if(con!=null) try {con.close();}catch(SQLException ex) {}
		}
		return boardList;
	}
	
	
	public List getBoardList(int startRow,int pageSize, String search) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List boardList=new ArrayList();
		
		String sql="";
		
		
		try {
		con=getConnection();
		
		sql="select * from fboard where subject like ? order by num desc limit ?,?";
		
		pstmt=con.prepareStatement(sql);
		pstmt.setString(1, "%"+search+"%");
		pstmt.setInt(2, startRow-1);
		pstmt.setInt(3, pageSize);
		
		rs=pstmt.executeQuery();
		
		while(rs.next()) {
			FBoardBean bb=new FBoardBean();
			bb.setContent(rs.getString("content"));
			bb.setDate(rs.getTimestamp("date"));
			bb.setName(rs.getString("name"));
			bb.setNum(rs.getInt("num"));
			bb.setPass(rs.getString("pass"));
			bb.setReadcount(rs.getInt("readcount"));
			bb.setSubject(rs.getString("subject"));
			//배열 한칸 한개의 글 저장
			boardList.add(bb);
		}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) try { rs.close();} catch(SQLException ex) {}
			if(pstmt!=null) try { pstmt.close();} catch(SQLException ex) {}
			if(con!=null) try {con.close();}catch(SQLException ex) {}
		}
		return boardList;
	}
	
	
	
	
	public int getBoardCount() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count=0;
		
		String sql="";
		
		try {
			con= getConnection();
			
			sql="select count(*) from fboard";
			pstmt = con.prepareStatement(sql);
			
			rs= pstmt.executeQuery();
			
			if(rs.next()) {
				count= rs.getInt("count(*)");
			
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) try { rs.close();} catch(SQLException ex) {}
			if(pstmt!=null) try { pstmt.close();} catch(SQLException ex) {}
			if(con!=null) try {con.close();}catch(SQLException ex) {}
		}
		return count;
		}
		
	
	public int getBoardCount(String search) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count=0;
		
		String sql="";
		
		try {
			con= getConnection();
			
//			sql="select count(*) from fboard where subject like '%제목%'";
			sql="select count(*) from fboard where subject like ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%"+search+"%");
			
			rs= pstmt.executeQuery();
			
			if(rs.next()) {
				count= rs.getInt("count(*)");
			
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) try { rs.close();} catch(SQLException ex) {}
			if(pstmt!=null) try { pstmt.close();} catch(SQLException ex) {}
			if(con!=null) try {con.close();}catch(SQLException ex) {}
		}
		return count;
		}


	public void updateReadcount(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count=0;
		
		String sql="";
		
		try {
			con= getConnection();
			
			sql="update fboard set readcount= readcount+1 where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			pstmt.executeUpdate();
		
		
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) try { rs.close();} catch(SQLException ex) {}
			if(pstmt!=null) try { pstmt.close();} catch(SQLException ex) {}
			if(con!=null) try {con.close();}catch(SQLException ex) {}
		}
		
	}
	
	public FBoardBean getBoard(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		FBoardBean bb =new FBoardBean();
		
		String sql="";
		
		try {
			con= getConnection();
			
			sql="select * from fboard where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs= pstmt.executeQuery();
			
			if(rs.next()) {
				bb.setContent(rs.getString("content"));
				bb.setDate(rs.getTimestamp("date"));
				bb.setName(rs.getString("name"));
				bb.setNum(rs.getInt("num"));
				bb.setPass(rs.getString("pass"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setSubject(rs.getString("subject"));
				bb.setFile(rs.getString("file"));
			
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) try { rs.close();} catch(SQLException ex) {}
			if(pstmt!=null) try { pstmt.close();} catch(SQLException ex) {}
			if(con!=null) try {con.close();}catch(SQLException ex) {}
		}
		return bb;
		
	}
	
	
	public void  insertBoard(FBoardBean bb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql="";
		int num=0;
		
		try {
			con= getConnection();
			
			sql="select max(num) as mnum from fboard";
			pstmt=con.prepareStatement(sql);
			// 4단계 실행 => 결과 저장
			rs=pstmt.executeQuery();
			// 5단계 다음행 이동 => 결과 가져와서 +1 => num변수
			if(rs.next()){
				num=rs.getInt("mnum")+1;
			}			
			
			//3단계 : 연결정보를 이용해서 sql구문을 만들고 실행할 객체생성
			//sql="insert into board(num,name,pass,subject,content,readcount,date) values(?,?,?,?,?,?,?)";
			sql="insert into fboard(num,name,pass,subject,content,readcount,date,file) values(?,?,?,?,?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num); //첫번재 물음표
			pstmt.setString(2, bb.getName()); //setString() ''자동붙음  //두번째물음표
			pstmt.setString(3, bb.getPass());
			pstmt.setString(4, bb.getSubject());
			pstmt.setString(5, bb.getContent());
			pstmt.setInt(6, bb.getReadcount());
			pstmt.setTimestamp(7, bb.getDate());
			pstmt.setString(8, bb.getFile());
			
			
			//4단계 : 객체를 실행 insert
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) try { rs.close();} catch(SQLException ex) {}
			if(pstmt!=null) try { pstmt.close();} catch(SQLException ex) {}
			if(con!=null) try {con.close();}catch(SQLException ex) {}
		}
	}
	
	public int updateBoard(FBoardBean bb) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="";
		int check=0;
		try {
			//1,2 디비연결
			con=getConnection();
			//3 sql num에 해당하는 게시판 글 정보 가져오기
			sql="select * from fboard where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, bb.getNum());
			//4 rs <= 실행결과
			rs=pstmt.executeQuery();
			//5 rs 첫행이동 데이터 있으면 bb 에 멤버변수
			if(rs.next()) {
				if(bb.getPass().equals(rs.getString("pass"))) {
					//3 sql update
					sql="update fboard set name=?,subject=?,content=?, file=? where num=?";
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1, bb.getName());
					pstmt.setString(2, bb.getSubject());
					pstmt.setString(3, bb.getContent());
					pstmt.setString(4, bb.getFile());
					pstmt.setInt(5, bb.getNum());
					
					//4 실행
					pstmt.executeUpdate();
					check=1;
				}else {
					check=0;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) try { rs.close();} catch(SQLException ex) {}
			if(pstmt!=null) try { pstmt.close();} catch(SQLException ex) {}
			if(con!=null) try {con.close();}catch(SQLException ex) {}
		}
		return check;
	}
	
	public int deleteBoard(FBoardBean bb) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="";
		int check=0;
		try {
			//1,2 디비연결
			con=getConnection();
			//3 sql num에 해당하는 게시판 글 정보 가져오기
			sql="select * from fboard where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, bb.getNum());
			//4 rs <= 실행결과
			rs=pstmt.executeQuery();
			//5 rs 첫행이동 데이터 있으면 bb 에 멤버변수
			if(rs.next()) {
				if(bb.getPass().equals(rs.getString("pass"))) {
					//3 sql delete
					sql="delete from fboard where num=?";
					pstmt=con.prepareStatement(sql);
					pstmt.setInt(1, bb.getNum());
					//4 실행
					pstmt.executeUpdate();
					check=1;
				}else {
					check=0;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) try { rs.close();} catch(SQLException ex) {}
			if(pstmt!=null) try { pstmt.close();} catch(SQLException ex) {}
			if(con!=null) try {con.close();}catch(SQLException ex) {}
		}
		return check;
	}
	
}
