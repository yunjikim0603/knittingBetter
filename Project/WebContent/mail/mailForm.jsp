<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">

<script src="../script/chat.js"></script>
 
</head>
<body>
<div id="wrap">
<!-- 헤더가 들어가는 곳 -->
<jsp:include page="../inc/top.jsp" />
<!-- 헤더가 들어가는 곳 -->

<!-- 본문 들어가는 곳 -->
<!-- 서브페이지 메인이미지 -->
<div id="sub_img_2"></div>
<!-- 서브페이지 메인이미지 -->
<!-- 왼쪽메뉴 -->
<!-- <nav id="sub_menu"> -->
<!-- <ul> -->
<!-- <li><a href="#">Welcome</a></li> -->
<!-- <li><a href="#">History</a></li> -->
<!-- <li><a href="#">Newsroom</a></li> -->
<!-- <li><a href="#">Public Policy</a></li> -->
<!-- </ul> -->
<!-- </nav> -->
<!-- 왼쪽메뉴 -->
<!-- 내용 -->
<!-- <article> -->
<h2 style="text-align: center; font-weight: bold;">CONTACT US</h2>


<!-- </article> -->
<!-- 내용 -->
<%
//String id = 세션값 가져오기
String id = (String)session.getAttribute("id");
//MemberDAO mdao 객체생성 
MemberDAO mdao = new MemberDAO();
//MemberBean mb  = getMember(id) 메서드 호출
MemberBean mb = mdao.getMember(id);
%>

<html>
<head>
<title>contact us</title>
<style>
	table{
		width : 450px;
		margin : auto;
	}
	h1{
		text-align: center;
	}
	td{
		border : 1px dotted gray;
	}
</style>
</head>
<body>
<form action="mailSend.jsp" method="post">
<table>
<%

if(id!=null){
	%>
		<tr><td>아이디 : </td><td><input type="text" name="sender" value="<%=mb.getId()%>" readonly></td></tr>
		
		<%
}else{
%>
	<tr><td>아이디 : </td><td><input type="text" name="sender" value="비회원" readonly></td></tr>
	<%
	}
%>

	<tr><td>관리자 : </td><td><input type="text" name="receiver" value="yunji.kim0603@gmail.com" readonly></td></tr>
	<tr><td>제목 : </td><td><input type="text" name="subject"></td></tr>
	<tr>
		<td>내용 : </td>
		<td><textarea name="content" cols=40 rows=20></textarea></td>
	</tr>
	<tr><td align=center colspan=2><input type="submit" value="보내기"></td></tr>
	
</table>
</form>
</body>
</html>



<div class="clear"></div>
<!-- 푸터 들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"/>
<!-- 푸터 들어가는 곳 -->
</div>
</body>
</html>



    