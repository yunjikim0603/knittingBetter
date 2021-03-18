<%@page import="fboard.FBoardBean"%>
<%@page import="fboard.FBoardDAO"%>
<%@page import="javax.websocket.SendResult"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
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
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/top.jsp" />
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 메인이미지 -->
<div id="sub_img_center"></div>
<!-- 메인이미지 -->

<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="../board/notice.jsp">자유게시판</a></li>
<!-- <li><a href="../qnaboard/qnotice.jsp">질문게시판</a></li> -->
<li><a href="../fileboard/fnotice.jsp">자료실</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->

<!-- 게시판 -->
<%
//세션값 가져오기
String id = (String)session.getAttribute("id");

//세션값 없으면 login.jsp 이동
if(id==null){
	response.sendRedirect("../member/login.jsp");
}
//int num=파라미터 가져오기
int num=Integer.parseInt(request.getParameter("num"));

//BoardDAO bdao 객체생성
FBoardDAO bdao = new FBoardDAO();

//num에 해당하는 게시판 글 가져오기 getBoard(num)
FBoardBean bb = bdao.getBoard(num);


%>

<article>
<h2>작성글 수정</h2>

<form action="fupdatePro.jsp" method="post" enctype="multipart/form-data">
<input type="hidden" name="num" value="<%=num%>">
<table id="notice">
	<tr><td>글쓴이</td><td><input type="text" name="name" value="<%=bb.getName() %>" readonly></td></tr>
	<tr><td>비밀번호</td><td><input type="password" name="pass"></td></tr>
	<tr><td>제목</td><td><input type="text" name="subject" value="<%=bb.getSubject()%>"></td></tr>
	<tr><td>첨부파일</td><td><input type="file" name="file">
	<input type="hidden" name="old_file" value="<%=bb.getFile() %>"><%=bb.getFile() %></td></tr>
	<tr><td>내용</td>
	    <td><textarea name="content" cols="20" rows="10"><%=bb.getContent()%></textarea></td></tr>
</table>
<div id="table_search">
<input type="submit" value="수정" class="btn">
<input type="button" value="취소" class="btn" onclick="location.href='fnotice.jsp'">
</div>
</form>

<div class="clear"></div>
<div id="page_control">
</div>
</article>
<!-- 게시판 -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"/>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>    

