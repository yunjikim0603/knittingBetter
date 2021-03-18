<%@page import="comment.CommentBean"%>
<%@page import="comment.CommentDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardBean"%>
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


String id = (String)session.getAttribute("id");

//num 글번호 파라미터 가져오기
int num=Integer.parseInt(request.getParameter("num"));

//Board bdao 객체생성
BoardDAO bdao = new BoardDAO();

//조회수 증가
bdao.updateReadcount(num);

//num에 해당하는 게시판 글개수 가져오기 getBoard(num) 
BoardBean bb = bdao.getBoard(num);

SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");

%>

<script>
function commentDelete(comm_num) {
	var msg = confirm("댓글을 삭제 하시겠습니까?");
	if(msg==true){
		location.href='../comment/delete.jsp?comm_num=' + comm_num + '&num=<%=num%>';
	}
}

</script>

<article>
<h2>자유게시판</h2>

<table id="notice">


	<tr><td colspan="10" style="text-align:left;"> [<%=bb.getNum() %>]  <b><%=bb.getSubject() %></b></td></tr>
	
	<tr><td style="text-align:left;"><%=bb.getName() %> | <%=sdf.format(bb.getDate()) %></td>
	<td style="text-align: right;">조회수 : <%=bb.getReadcount() %></td></tr>
	   
	<tr><td colspan="10" style="text-align: left;"><%=bb.getContent() %> <br>
	
	<img src="../upload/<%=bb.getFile()%>" style="cursor:pointer" height="400"
	onclick="window.open('../upload/<%=bb.getFile()%>','asdfo8or',
	'scrollbars=yes,width=1000,height=900,top=50,left=500');"> <br>
	
<%-- 	<a href="../upload/<%=bb.getFile()%>"><%=bb.getFile()%></a><br> --%>
<%-- 	다운로드 : <a href="file_down.jsp?file_name=<%=bb.getFile()%>"><%=bb.getFile()%> </a></td></tr> --%>

</table>

<div id="table_search">

<%

if(id!=null){
		%>
<input type="button" value="답글작성" class="btn" onclick="location.href='reWriteForm.jsp?num=<%=bb.getNum()%>&re_ref=<%=bb.getRe_ref()%>&re_lev=<%=bb.getRe_lev()%>&re_seq=<%=bb.getRe_seq()%>'">

<%
if(id.equals(bb.getName())){
%>
<input type="button" value="글수정" class="btn" onclick="location.href='updateForm.jsp?num=<%=bb.getNum()%>'">
<input type="button" value="글삭제" class="btn" onclick="location.href='deleteForm.jsp?num=<%=bb.getNum()%>'">
		<%
	}
}

%>
<input type="button" value="글목록" class="btn" onclick="location.href='notice.jsp'">
</div>
<div class="clear"></div>
<div id="page_control">
</div>


<form id="cmtForm" action="../comment/comment.jsp">
	<h4>댓글</h4>
	<input type="hidden" name="num" value="<%=num%>"> 
	 <%if(id == null) { //로그아웃 상태이면 로그인 페이지로 이동
		 %>
		 <a href="../member/login.jsp?num=<%=num%>" style="cursor:pointer">
		 	<textarea name="content" rows="4" cols="80" readonly="readonly">댓글을 작성하려면 로그인을 해주세요. 클릭시 로그인 페이지로 이동합니다.</textarea>
		 </a>
		 <%
	 }else {%>
		<textarea name="content" rows="4" cols="80" style="resize: none;"></textarea>
	<%}%>
	
	<%if(id != null) {%>
	<input type="submit" value="등록" style="float: right">
	<% }%>
</form>

<br><br>
<%
//한 화면에 보여줄 댓글 개수 5개 설정
int pageSize = 5;
//페이지 번호 가져와서 변수에 저장
String pageNum = request.getParameter("pageNum");
//페이지 번호가 없으면 1로 설정
if(pageNum == null){
 pageNum = "1";
}
//페이지 번호 => 정수형으로 변경
int currentPage = Integer.parseInt(pageNum);
//한페이지에서 시작하는 행 번호 구하기
//1페이지면 1-10 / 2페이지면 11-20
int startRow = 1;
CommentDAO cdao = new CommentDAO();
// 댓글 수 가져오기
List list = null;
int count = cdao.getCommentCount(num);//총 댓글 갯수
int size = currentPage * pageSize;//페이지번호 * 한화면에 보여줄 댓글 갯수
if(count != 0){
	list = cdao.getCommentList(num, startRow, size);
}

if(list != null){
 	for(int i = 0; i < list.size(); i++){
 		CommentBean cb = (CommentBean)list.get(i);
	
	
%>

<table id="comment"> 
	<tr><th><%=cb.getComm_id() %></th>
	<%if(id != null){ //로그인 상태이면
 		if(id.equals(cb.getComm_id())){ %>
	    <td><a style="color:#333; text-decoration: none;"
	     href="../comment/updateForm.jsp?comm_num=<%=cb.getComm_num()%>&num=<%=num%>#cmtForm">수정</a>&nbsp;
	    <a style="color:#333; text-decoration: none; cursor:pointer;"  onclick="commentDelete(<%=cb.getComm_num()%>)">삭제</a></td></tr>
	<%}
 	} %> 
 	<tr><td style="font-size: 12px;"><%=cb.getComm_content() %></td>
	<td><small><%=sdf.format(cb.getComm_date()) %></small></td></tr>
	
	
</table>

<br>

<%
	}
}

if(size < count){
%>
<div><a href="content.jsp?num=<%=num %>&pageNum=<%=currentPage+1%>#cmtForm">더보기</a></div>
<% } %> 

<%-- <div><a class="top" href="content.jsp?num=<%=num %>&pageNum=<%=currentPage%>#">top</a></div> --%>

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
