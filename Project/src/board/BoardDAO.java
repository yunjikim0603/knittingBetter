package board;

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

public class BoardDAO {
	
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
		
		sql="select * from board order by re_ref desc, re_seq asc limit ?,?";
		
		pstmt=con.prepareStatement(sql);
		pstmt.setInt(1, startRow-1);
		pstmt.setInt(2, pageSize);
		
		rs=pstmt.executeQuery();
		
		while(rs.next()) {
			BoardBean bb=new BoardBean();
			bb.setContent(rs.getString("content"));
			bb.setDate(rs.getTimestamp("date"));
			bb.setName(rs.getString("name"));
			bb.setNum(rs.getInt("num"));
			bb.setPass(rs.getString("pass"));
			bb.setReadcount(rs.getInt("readcount"));
			bb.setSubject(rs.getString("subject"));
			
			bb.setRe_ref(rs.getInt("re_ref"));
			bb.setRe_lev(rs.getInt("re_lev"));
			bb.setRe_seq(rs.getInt("re_seq"));
			
			
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
		
		sql="select * from board where subject like ? order by num desc limit ?,?";
		
		pstmt=con.prepareStatement(sql);
		pstmt.setString(1, "%"+search+"%");
		pstmt.setInt(2, startRow-1);
		pstmt.setInt(3, pageSize);
		
		rs=pstmt.executeQuery();
		
		while(rs.next()) {
			BoardBean bb=new BoardBean();
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
			
			sql="select count(*) from board";
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
			
//			sql="select count(*) from board where subject like '%제목%'";
			sql="select count(*) from board where subject like ?";
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
			
			sql="update board set readcount= readcount+1 where num=?";
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
	
	public BoardBean getBoard(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		BoardBean bb =new BoardBean();
		
		String sql="";
		
		try {
			con= getConnection();
			
			sql="select * from board where num=?";
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
				//답글정보 가져오기
				bb.setRe_ref(rs.getInt("re_ref"));
				bb.setRe_lev(rs.getInt("re_lev"));
				bb.setRe_seq(rs.getInt("re_seq"));
			
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
	
	
	public void  insertBoard(BoardBean bb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql="";
		int num=0;
		
		try {
			con= getConnection();
			
			sql="select max(num) as mnum from board";
			pstmt=con.prepareStatement(sql);
			// 4단계 실행 => 결과 저장
			rs=pstmt.executeQuery();
			// 5단계 다음행 이동 => 결과 가져와서 +1 => num변수
			if(rs.next()){
				num=rs.getInt("mnum")+1;
			}			
			
			//3단계 : 연결정보를 이용해서 sql구문을 만들고 실행할 객체생성
			//sql="insert into board(num,name,pass,subject,content,readcount,date) values(?,?,?,?,?,?,?)";
			sql="insert into board(num,name,pass,subject,content,readcount,date,file,re_ref,re_lev,re_seq) values(?,?,?,?,?,?,?,?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num); //첫번재 물음표
			pstmt.setString(2, bb.getName()); //setString() ''자동붙음  //두번째물음표
			pstmt.setString(3, bb.getPass());
			pstmt.setString(4, bb.getSubject());
			pstmt.setString(5, bb.getContent());
			pstmt.setInt(6, bb.getReadcount());
			pstmt.setTimestamp(7, bb.getDate());
			pstmt.setString(8, bb.getFile());
			//답글 관련 일반글 등록
			pstmt.setInt(9, num);//re_ref
			pstmt.setInt(10, 0);//re_lev
			pstmt.setInt(11, 0);//re_seq
			
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
	
	public void reInsertBoard(BoardBean bb) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="";
		int num=0;
		try {
			//1,2 메서드 호출
			con=getConnection();
			
			// num열에서 가장 큰값 구해서 +1  => num열 구하기 
			// 3단계 num열에서 가장 큰값 구해서 sql
			sql="select max(num) as mnum from board";
			pstmt=con.prepareStatement(sql);
			// 4단계 실행 => 결과 저장
			rs=pstmt.executeQuery();
			// 5단계 다음행 이동 => 결과 가져와서 +1 => num변수
			if(rs.next()){
				num=rs.getInt("mnum")+1;
			}			
			//그룹중에 답글을 달고자하는 글 아래에 답글이 있으면 답글 순서 아래로 재배치(+1);
			sql="update board set re_seq=re_seq+1 where re_ref=? and re_seq>?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, bb.getRe_ref());
			pstmt.setInt(2, bb.getRe_seq());
			pstmt.executeUpdate();
			
			//3단계 : 연결정보를 이용해서 sql구문을 만들고 실행할 객체생성
			//sql="insert into board(num,name,pass,subject,content,readcount,date) values(?,?,?,?,?,?,?)";
			sql="insert into board(num,name,pass,subject,content,readcount,date,file,re_ref,re_lev,re_seq) values(?,?,?,?,?,?,?,?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num); //첫번재 물음표
			pstmt.setString(2, bb.getName()); //setString() ''자동붙음  //두번째물음표
			pstmt.setString(3, bb.getPass());
			pstmt.setString(4, bb.getSubject());
			pstmt.setString(5, bb.getContent());
			pstmt.setInt(6, bb.getReadcount());
			pstmt.setTimestamp(7, bb.getDate());
			pstmt.setString(8, bb.getFile());
			//답글관련 답글 등록
			pstmt.setInt(9, bb.getRe_ref());
			pstmt.setInt(10, bb.getRe_lev()+1);
			pstmt.setInt(11, bb.getRe_seq()+1);
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
	
	public int updateBoard(BoardBean bb) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="";
		int check=0;
		try {
			//1,2 디비연결
			con=getConnection();
			//3 sql num에 해당하는 게시판 글 정보 가져오기
			sql="select * from board where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, bb.getNum());
			//4 rs <= 실행결과
			rs=pstmt.executeQuery();
			//5 rs 첫행이동 데이터 있으면 bb 에 멤버변수
			if(rs.next()) {
				if(bb.getPass().equals(rs.getString("pass"))) {
					//3 sql update
					sql="update board set name=?,subject=?,content=?, file=? where num=?";
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
	
	public int deleteBoard(BoardBean bb) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="";
		int check=0;
		try {
			//1,2 디비연결
			con=getConnection();
			//3 sql num에 해당하는 게시판 글 정보 가져오기
			sql="select * from board where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, bb.getNum());
			//4 rs <= 실행결과
			rs=pstmt.executeQuery();
			//5 rs 첫행이동 데이터 있으면 bb 에 멤버변수
			if(rs.next()) {
				if(bb.getPass().equals(rs.getString("pass"))) {
					//3 sql delete
					sql="delete from board where num=?";
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
