<%@page import="fboard.FBoardBean"%>
<%@page import="fboard.FBoardDAO"%>
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
//num 글번호 파라미터 가져오기
int num=Integer.parseInt(request.getParameter("num"));
// BoardDAO bdao 객체생성
FBoardDAO bdao=new FBoardDAO();
//조회수 증가
bdao.updateReadcount(num);
// num에 해당하는 게시판 글 가져오기 getBoard(num)
FBoardBean bb=bdao.getBoard(num);

SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
%>
<article>
<h2>자료실</h2>
<table id="notice">


	<tr><td colspan="10" style="text-align:left;"> [<%=bb.getNum() %>]  <b><%=bb.getSubject() %></b></td></tr>
	
	<tr><td style="text-align:left;"><%=bb.getName() %> | <%=sdf.format(bb.getDate()) %></td>
	<td style="text-align: right;">조회수 : <%=bb.getReadcount() %></td></tr>
	   
	<tr><td colspan="10" style="text-align: left;"><%=bb.getContent() %> <br>
	
	<img src="../upload/<%=bb.getFile()%>" style="cursor:pointer" height="400"
	onclick="window.open('../upload/<%=bb.getFile()%>','asdfo8or',
	'scrollbars=yes,width=1000,height=900,top=50,left=500');"> <br>
	
<%-- 	<a href="../upload/<%=bb.getFile()%>"><%=bb.getFile()%></a><br> --%>
	다운로드 : <a href="file_down.jsp?file_name=<%=bb.getFile()%>"><%=bb.getFile()%> </a></td></tr>

</table>

<div id="table_search">
<%
// 세션값 가져오기
String id=(String)session.getAttribute("id");
// 세션값 있으면 
// 세션값과 글쓴이가 일치하면  글수정 글삭제 보이기
if(id!=null){
	if(id.equals(bb.getName())){
		%>
<input type="button" value="글수정" class="btn" 
onclick="location.href='fupdateForm.jsp?num=<%=bb.getNum()%>'">
<input type="button" value="글삭제" class="btn" 
onclick="location.href='fdeleteForm.jsp?num=<%=bb.getNum()%>'">		
		<%
	}
}
%>
<input type="button" value="글목록" class="btn" onclick="location.href='fnotice.jsp'">
</div>
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
