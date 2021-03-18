<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
//request 요청 정보 저장  "id" "pass" 파라미터
String id=request.getParameter("id");
String pass=request.getParameter("pass");

//MemberBean mb 객체생성
MemberBean mb=new MemberBean();
//id, pass 멤버변수 에 파라미터 값 저장
mb.setId(id);
mb.setPass(pass);
//MemberDAO mdao 객체생성
MemberDAO mdao=new MemberDAO();
//int check =  userCheck(id,pass) 호출
int check=mdao.userCheck(id, pass);
if(check==1){
	// check==1
			//비밀번호 맞음  수정 3단계 sql update  4단계 실행 main.jsp 이동 
			// deleteMember(mb)
			mdao.deleteMember(mb);
			//세션초기화,  로그아웃
			session.invalidate();
			%>
			<script type="text/javascript">
			alert("회원탈퇴가 완료되었습니다.");
			location.href="../main/main.jsp";
		</script>
			<% 
}else if(check==0){
	//비밀번호틀림
			%>
			<script type="text/javascript">
				alert("비밀번호가 일치하지 않습니다.");
				history.back();
			</script>
			<%
}else{
	//아이디없음
		%>
		<script type="text/javascript">
			alert("아이디가 존재하지 않습니다.");
			history.back();
		</script>
		<%
}
%>
</body>
</html>