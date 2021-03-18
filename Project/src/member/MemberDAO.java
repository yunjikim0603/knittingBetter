package member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {

	public Connection getConnection() throws Exception{

		 Connection con = null;
			Context init = new InitialContext();
			DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
			con=ds.getConnection();
			return con;
		
	}
	
	public void insertMember(MemberBean mb) {
		Connection con=null;
		PreparedStatement pstmt=null;
		try {
			con=getConnection();
			
			String sql = "insert into member(id,pass,name,email,address,address2,postcode,phone,mobile,reg_date) values(?,?,?,?,?,?,?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, mb.getId());
			pstmt.setString(2, mb.getPass());
			pstmt.setString(3, mb.getName());
			pstmt.setString(4, mb.getEmail());
			pstmt.setString(5, mb.getAddress());
			pstmt.setString(6, mb.getAddress2());
			pstmt.setString(7, mb.getPostcode());
			pstmt.setString(8, mb.getPhone());
			pstmt.setString(9, mb.getMobile());
			pstmt.setTimestamp(10, mb.getReg_date());
			
			pstmt.executeUpdate();
		
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt!=null) try { pstmt.close();} catch(SQLException ex) {}
			if(con!=null) try {con.close();}catch(SQLException ex) {}
		}
	}
	
	public int userCheck(String id, String pass) {
		int check = -1;
		Connection con = null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		try {
			// 1단계 드라이버로더
			// 2단계 디비연결
			con=getConnection();
			
			// id 존재하는지 조회, id 비교   디비id 폼의 id 비교
			String sql="select * from member where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			// sql 실행  => 결과 저장
			rs=pstmt.executeQuery();
			
			// 다음행으로 이동했을때 정보가 있으면
			 if(rs.next()) {
			// 비밀번호 비교 맞으면   세션값 생성 "id",id , main.jsp	
				if(pass.equals(rs.getString("pass"))) {
					//1로 신호값 주기
					check=1;
					//아이디는 있지만 비밀번호 틀림
				}else {
				 check=0;
			 }
				//아이디 없음
			 }else {
				check=-1;
			 }
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt!=null) try { pstmt.close();} catch(SQLException ex) {}
			if(con!=null) try {con.close();}catch(SQLException ex) {}
		}
		return check;
	}
		
	
	public MemberBean getMember(String id) {
		MemberBean mb = new MemberBean();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con=getConnection();
		
		String sql="select * from member where id=?";
		pstmt=con.prepareStatement(sql);
		pstmt.setString(1, id);
		
		rs=pstmt.executeQuery();
		
		 if(rs.next()){
			 mb.setId(rs.getString("id"));
			 mb.setPass(rs.getString("pass"));
			 mb.setName(rs.getString("name"));
			 mb.setEmail(rs.getString("email"));
			 mb.setAddress(rs.getString("address"));
			 mb.setAddress2(rs.getString("address2"));
			 mb.setPostcode(rs.getString("postcode"));
			 mb.setPhone(rs.getString("phone"));
			 mb.setMobile(rs.getString("mobile"));
			 
		 }
		 
		 } catch (Exception e) {
			 e.printStackTrace();
		 }finally {
			if(rs!=null) try {rs.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			if(con!=null) try {con.close();} catch (SQLException ex) {}
				}
			return mb;
	
	}
	



public void updateMember(MemberBean mb) {
	Connection con=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	try {
		// 1단계 드라이버로더
		 // 2단계 디비연결
		con=getConnection();
		
		 //3단계 sql update
		 String sql="update member set name=?, email=?, address=?, address2=?, postcode=?, phone=?, mobile=? where id=?"; 
		 pstmt=con.prepareStatement(sql);
		 pstmt.setString(1, mb.getName());
		 pstmt.setString(2, mb.getEmail());
		 pstmt.setString(3, mb.getAddress());
		 pstmt.setString(4, mb.getAddress2());
		 pstmt.setString(5, mb.getPostcode());
		 pstmt.setString(6, mb.getPhone());
		 pstmt.setString(7, mb.getMobile());
		 pstmt.setString(8, mb.getId());
		 
		 
		 //4단계 실행
		 pstmt.executeUpdate();
	} catch (Exception e) {
		e.printStackTrace();
	}finally {
		//마무리
		if(rs!=null) try { rs.close();} catch(SQLException ex) {}
		if(pstmt!=null) try { pstmt.close();} catch(SQLException ex) {}
		if(con!=null) try {con.close();}catch(SQLException ex) {}
	}
}


public void deleteMember(MemberBean mb) {
	Connection con=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	try {
		// 1단계 드라이버로더
		 // 2단계 디비연결
		con=getConnection();
		
		 //3단계 sql update
		 String sql="delete from member where id=?"; 
		 pstmt=con.prepareStatement(sql);
		 pstmt.setString(1, mb.getId());
		 //4단계 실행
		 pstmt.executeUpdate();
	} catch (Exception e) {
		e.printStackTrace();
	}finally {
		//마무리
		if(rs!=null) try { rs.close();} catch(SQLException ex) {}
		if(pstmt!=null) try { pstmt.close();} catch(SQLException ex) {}
		if(con!=null) try {con.close();}catch(SQLException ex) {}
	}
}


public int idcheck(String id) {
	int check=-1;
	Connection con=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	try {
		// 1단계 드라이버로더
		 // 2단계 디비연결
		con=getConnection();
		// id 존재하는지 조회, id 비교   디비id 폼의 id 비교
		String sql="select * from member where id=?";
		pstmt=con.prepareStatement(sql);
		pstmt.setString(1, id);
					
		// sql 실행  => 결과 저장
		rs=pstmt.executeQuery();
					
		// 다음행으로 이동했을때 정보가 있으면
		if(rs.next()) {
		if(id.equals(rs.getString("id"))) {
			//아이디 중복
			check=1;
			
		}
		}else {
			//아이디 사용가능
		check=-1;
	
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			//마무리
			if(rs!=null) try { rs.close();} catch(SQLException ex) {}
			if(pstmt!=null) try { pstmt.close();} catch(SQLException ex) {}
			if(con!=null) try {con.close();}catch(SQLException ex) {}
		}
		return check;
	}
}





	
	

