S<%@page import="fboard.FBoardDAO"%>
<%@page import="fboard.FBoardBean"%>
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
 <style>
@import url('https://fonts.googleapis.com/css?family=Nanum+Gothic|Noto+Sans+KR&display=swap');
</style>
 
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
// BoardDAO 만들기 
// BoardDAO bdao 객체생성
FBoardDAO bdao=new FBoardDAO();

// 게시판 전체 글개수 가져오기   getBoardCount() 호출
int count=bdao.getBoardCount();

// 한화면에 보여줄 글 개수  15개 설정
int pageSize=15;
// 페이지 번호 가져와서 변수에 저장
String pageNum=request.getParameter("pageNum");
// 페이지 번호가 없으면 "1"설정
if(pageNum==null){
	pageNum="1";
}
// 페이지번호 => 정수형 변경
int currentPage=Integer.parseInt(pageNum);
// 한페이지에서 시작하는 행번호 구하기
int startRow=(currentPage-1)*pageSize+1;
List boardList=null;
// 게시판에 글 있으면 
// 리턴할형 List getBoardList(시작하는행번호,글개수)
if(count!=0){
	// 전체 글 가져오기
// 	boardList=bdao.getBoardList();
	// 1페이지에 10개 글 가져오기   // 1행부터 15개
	boardList=bdao.getBoardList(startRow,pageSize);
}
// 날짜 모양 설정=> 문자열 출력
SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd");
%>
<article style="font-family: 'Noto Sans KR', sans-serif;">
<h2>자료실 <%-- [전체글개수 : <%=count %>] --%></h2>
<table id="notice">
<tr><th class="tno">No.</th>
    <th class="ttitle">Title</th>
    <th class="twrite">Writer</th>
    <th class="tdate">Date</th>
    <th class="tread">Read</th></tr>
    <%
    if(count!=0){
    	for(int i=0;i<boardList.size();i++){
    		FBoardBean bb=(FBoardBean)boardList.get(i);
    		%>
    <tr onclick="location.href='fcontent.jsp?num=<%=bb.getNum()%>'" style="font-size:12px; font-family:'Noto Sans KR', sans-serif;">
    	<td><%=bb.getNum() %></td>
    	<td class="left"><%=bb.getSubject() %></td>
    	<td><%=bb.getName() %></td><td><%=sdf.format(bb.getDate()) %></td>
    	<td><%=bb.getReadcount() %></td></tr>
    		<%
	    }
    }
    %>
</table>
<div id="table_search">
<form action="fnoticeSearch.jsp" method="post">
<input type="text" name="search" class="input_box">
<input type="submit" value="search" class="btn">
</form>
</div>
<%
// 로그인 해야지만 글쓰기 버튼이 보이게 함
// 세션값 가져오기
String id=(String)session.getAttribute("id");
// if 세션값이 있으면 글쓰기 버튼 보이기
if(id!=null){
	%>
<div id="table_search">
<input type="button" value="글쓰기" class="btn" onclick="location.href='fwriteForm.jsp'">
</div>	
	<%
}
%>
<div class="clear"></div>
<div id="page_control">
<%
// 전체 페이지개수
int pageCount=count/pageSize+(count%pageSize==0?0:1);

//한화면에 보여줄 페이지 개수 설정
int pageBlock=10;

//한화면에 보여줄 시작페이지 구하기   1 11 21 31 ~
int startPage=((currentPage-1)/pageBlock)*pageBlock+1;

//한화면에 보줄 끝페이지 구하기 10 20 30 40 ~
int endPage=startPage+pageBlock-1;
if(endPage > pageCount){
	endPage=pageCount;
}

//[이전]
if(startPage > pageBlock){
	%><a href="fnotice.jsp?pageNum=<%=startPage-pageBlock%>">Prev</a><%
}
		
for(int i=startPage;i<=endPage;i++){
	%><a href="fnotice.jsp?pageNum=<%=i%>"><%=i%></a> <%
}

//[다음]
if(endPage < pageCount){
	%><a href="fnotice.jsp?pageNum=<%=startPage+pageBlock%>">Next</a><%
}
%>
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
