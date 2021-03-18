<%@page import="pboard.PBoardBean"%>
<%@page import="pboard.PBoardDAO"%>
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
div.gallery {
  margin: 5px;
  border: 1px solid #ccc;
  float: left;
  width: 180px;
}

div.gallery:hover {
  border: 1px solid #777;
}

div.gallery img {
  width: 30%;
  height: auto;
}

div.desc {
  padding: 15px;
  text-align: center;
}
</style>
 
</head>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/top.jsp" />
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 메인이미지 -->
<div id="sub_img_center_2"></div>
<!-- 메인이미지 -->

<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="../photoboard/pnotice.jsp">회원작품</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->

<!-- 게시판 -->
<%
// BoardDAO 만들기 
// BoardDAO bdao 객체생성
PBoardDAO bdao=new PBoardDAO();

// 게시판 전체 글개수 가져오기   getBoardCount() 호출
int count=bdao.getBoardCount();

// 한화면에 보여줄 글 개수  15개 설정
int pageSize=9;
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
//  SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd"); 
%>
<article>
<h2>회원작품<%-- [전체글개수 : <%=count %>] --%></h2>
<table id="pnotice" >

<tr>

<%
  if(count!=0){
    	for(int i=0;i<boardList.size();i++){
    		PBoardBean bb=(PBoardBean)boardList.get(i);
    		 %>
<!--     		 <div class="gallery"> --><td onclick="location.href='pcontent.jsp?num=<%=bb.getNum()%>'">
    		<img src="../upload/<%=bb.getFile()%>" width="200" height="200"><br>
    		<b><%=bb.getSubject() %></b><br>
    		<%=bb.getName() %><br>
    		<%=bb.getDate() %></td>
<!-- 			</div> -->

<%if((i+1)%3==0){
%></tr><tr><%
	}
}
    	}%>


	 

  </tr>  
</table>
<div id="table_search">
<form action="pnoticeSearch.jsp" method="post">
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
<input type="button" value="글쓰기" class="btn" onclick="location.href='pwriteForm.jsp'">
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
	%><a href="pnotice.jsp?pageNum=<%=startPage-pageBlock%>">Prev</a><%
}
		
for(int i=startPage;i<=endPage;i++){
	%><a href="pnotice.jsp?pageNum=<%=i%>"><%=i%></a> <%
}

//[다음]
if(endPage < pageCount){
	%><a href="pnotice.jsp?pageNum=<%=startPage+pageBlock%>">Next</a><%
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
