<%@page import="fboard.FBoardBean"%>
<%@page import="fboard.FBoardDAO"%>
<%@page import="board.BoardBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/front.css" rel="stylesheet" type="text/css">

<script src="../script/chat.js"></script>
</head>
<body>

<div id="wrap">
<!-- 헤더파일들어가는 곳 -->
<jsp:include page="../inc/top.jsp" />
<!-- 헤더파일들어가는 곳 -->
<!-- 메인이미지 들어가는곳 -->
<div class="clear"></div>


<article>
<div id="main_img"><img src="../images/head2.jpg"
 width="971" height="310"></div>
 
 
 
 </article>
<!-- 메인이미지 들어가는곳 -->
<!-- 메인 콘텐츠 들어가는 곳 -->
<article id="front" style="margin: 15px 0 0 45px;">
<div id="news_notice">
<h3 class="brown">자유게시판</h3>
<table>
<%
//BoardDAO bdao 객체생성
BoardDAO bdao = new BoardDAO();

int pageSize=5;

//게시판 전체 글 개수 가져오기 getBoardCount()호출
int count = bdao.getBoardCount();
int startRow = 1;

//게시판 글 있으면
//리턴할 형 List getBoardList(시작하는행번호, 글개수)
List boardList = null;
if(count!=0){
	boardList = bdao.getBoardList(startRow,pageSize);
}

//날짜모양설정
SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");

for(int i = 0; i<boardList.size(); i++){
	BoardBean bb =(BoardBean)boardList.get(i);
	
%><tr><td class="contxt"><a href="../board/content.jsp?num=<%=bb.getNum()%>"><%=bb.getSubject() %></a></td>
    <td><%=sdf.format(bb.getDate()) %></td></tr><%
}
%>
</table>
</div>

<div id="news_notice">
<h3 class="brown">자료실</h3>
<table>
<%
//BoardDAO bdao 객체생성
FBoardDAO fbdao = new FBoardDAO();

int fpageSize=5;

//게시판 전체 글 개수 가져오기 getBoardCount()호출
int fcount = fbdao.getBoardCount();
int fstartRow = 1;

//게시판 글 있으면
//리턴할 형 List getBoardList(시작하는행번호, 글개수)
List fboardList = null;
if(fcount!=0){
	fboardList = fbdao.getBoardList(fstartRow,fpageSize);
}

//날짜모양설정
sdf = new SimpleDateFormat("yyyy.MM.dd");

for(int i = 0; i<fboardList.size(); i++){
	FBoardBean fbb =(FBoardBean)fboardList.get(i);
	
%><tr><td class="contxt"><a href="../fileboard/fcontent.jsp?num=<%=fbb.getNum()%>"><%=fbb.getSubject() %></a></td>
    <td><%=sdf.format(fbb.getDate()) %></td></tr><%
}
%>

    
</table>
</div>


</article>
<!-- 메인 콘텐츠 들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터 들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"/>
<!-- 푸터 들어가는 곳 -->
</div>
</body>
</html>