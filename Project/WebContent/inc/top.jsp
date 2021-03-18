<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<header>

<style>
@import url('https://fonts.googleapis.com/css?family=Nanum+Gothic|Noto+Sans+KR&display=swap');
a { text-decoration:none ; color:#000000}

</style>
<%
//세션값 가져와서  String id변수에 저장
String id = (String)session.getAttribute("id");

//세션값이 없으면 로그인,조인
//세션값이 있으면 ...님,정보수정, 로그아웃
if(id==null){
	%>
	<div id="toplogin" style="font-family: 'Noto Sans KR', sans-serif; font-size: 15px; color: black;"><a href="../member/login.jsp">로그인</a> | <a href="../member/join.jsp">회원가입</a></div>
	<%
	
	
}else{
	%>
	<br>
	<div id="toplogin" style=" font-family: 'Noto Sans KR', sans-serif; font-size: 15px; color: black;">
	안녕하세요 <%=id %>님   |   <a href="../member/updateForm.jsp">MYPAGE</a>
	|    <a href="../member/logout.jsp">LOGOUT</a></div>
	<%
}

%>


<div class="clear"></div>
<!-- 로고들어가는 곳 -->
<div id="logo"><a href="../main/main.jsp"><img src="../images/mylogo.png" width="220" height="53" alt="KNITTING BETTER"></a></div>
<!-- 로고들어가는 곳 -->
<nav id="top_menu">
<ul>
	<li><a href="../main/main.jsp">HOME</a></li>
	<li><a href="../company/welcome.jsp">ABOUT</a></li>
	<li><a href="../board/notice.jsp">BOARD</a></li>
	<li><a href="../photoboard/pnotice.jsp">PHOTO</a></li>
	<li><a href="../mail/mailForm.jsp">CONTACT US</a></li>
</ul>
</nav>
</header>