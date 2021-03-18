<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//한글처리
request.setCharacterEncoding("utf-8");

//request 에 저장된 파라미터 가져와서 => 변수에 저장
String id = request.getParameter("id");
String pass = request.getParameter("pass");
String name = request.getParameter("name");
String email = request.getParameter("email");
String address = request.getParameter("address");
String address2 =request.getParameter("address2");
String postcode =request.getParameter("postcode");
String phone = request.getParameter("phone");
String mobile = request.getParameter("mobile");
Timestamp reg_date=new Timestamp(System.currentTimeMillis());

//데이터 저장해서 전달
//패키지 member 파일이름 MemberBean 파일 만들기
//멤버변수 정의 set get reg_date현재날짜 저장

//MemberBean mb 객체생성
MemberBean mb = new MemberBean();

//멤버변수에  set메서드호출 파라미터 값 저장
mb.setId(id);
mb.setPass(pass);
mb.setName(name);
mb.setEmail(email);
mb.setAddress(address);
mb.setAddress2(address2);
mb.setPostcode(postcode);
mb.setPhone(phone);
mb.setMobile(mobile);
mb.setReg_date(reg_date);

//디비 작업 
//패키지 member 파일이름 MemberDAO 파일 만들기
//디비연결 메서드 getConnection()

//리턴값 없음 insertMember(MemberBean mb) 메서드 만들기

//MemberDAO mdao 객체 생성
MemberDAO mdao = new MemberDAO();
//insertMember(mb) 메서드 호출
mdao.insertMember(mb);

%>


<script type = "text/javascript">
	alert("회원가입을 축하합니다!");
	location.href="login.jsp";
	
</script>