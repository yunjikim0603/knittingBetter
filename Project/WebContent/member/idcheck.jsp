<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript">
function idselect() {
// 	join.jsp id상자에 저장 <= idcheck.jsp 에서 찾은 아이디
// 	alert(document.wfr.wid.vaule);
	opener.document.join.id.value=document.wfr.wid.value
// 	idcheck.jsp 창 닫기
	window.close();
}
</script>



<style>
@import url('https://fonts.googleapis.com/css?family=Nanum+Gothic|Noto+Sans+KR&display=swap');
</style>

</head>
<body style="font-family: 'Noto Sans KR', sans-serif; ">
<h2 style="font-family: 'Noto Sans KR', sans-serif; ">아이디 중복확인</h2>
<br>
<%
//String id = wid 파라미터 가져오기
String id = request.getParameter("wid");
out.println(id); 

//MemberDAO mdao 객체생성
MemberDAO mdao = new MemberDAO();

//dmao 에 idcheck() 메서드 생성

//int check = idcheck(id)
int check = mdao.idcheck(id);

//check==1 "아이디중복"
//check==-1 "아이디 사용가능"

if(check==1){
	out.println("은(는) 중복되는 아이디 입니다.");
}else if(check==-1){
	out.println("은(는) 사용 가능한 아이디 입니다.");
	%>
	<input type="button" value="사용하기" onclick="idselect()">
	<br>
	<%
}


%>

<form action = "idcheck.jsp" method="get" name="wfr">
	아이디 <input type="text" name="wid" value="<%=id %>">
	<input type="submit" value="중복확인">

</form>

</body>
</html>