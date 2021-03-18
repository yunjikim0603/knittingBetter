<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
//request 에 저장된 파라미터 가져와서 => 변수에 저장
String id=request.getParameter("id");
String pass=request.getParameter("pass");

//MemberDAO mdao 객체생성
MemberDAO mdao = new MemberDAO();

//userCheck 메서드 생성 리턴값 int
//int check =  userCheck(id,pass) 호출
int check = mdao.userCheck(id, pass);
//check==1 이면(아이디일치 비밀번호일치)
if(check==1){
	session.setAttribute("id", id);
	response.sendRedirect("../main/main.jsp");
	//check==0이면 (아이디일치 비밀번호틀림)
}else if(check==0){
	%>
	<script type="text/javascript">
	alert("비밀번호가 일치하지 않습니다.");
 	history.back();
 	</script> 
 	<%
 	//check=-1(아이디없음)
}else{
	%>
	<script type="text/javascript">
	 		alert("아이디가 존재하지 않습니다.");
	 		history.back();
	</script>
	<%
}

%>

