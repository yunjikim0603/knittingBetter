<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//한글처리
request.setCharacterEncoding("utf-8");
//파라미터 가져오기
int num=Integer.parseInt(request.getParameter("num"));
String pass=request.getParameter("pass");

//BoardBean bb 객체생성
BoardBean bb=new BoardBean();

//파라미터 bb에 저장
bb.setNum(num);
bb.setPass(pass);

// BoardDao bdao 객체생성
BoardDAO bdao=new BoardDAO();

//int check = deleteBoard(bb)
int check = bdao.deleteBoard(bb);
//check==1  수정성공     notice.jsp 이동
//check==0  비밀번호틀림  뒤로이동
if(check==1){
	%>
	<script type="text/javascript">
		alert("정상적으로 삭제 되었습니다.");
		location.href="notice.jsp";
	</script>
	<%
}else{
	%>
	<script type="text/javascript">
		alert("비밀번호가 일치하지 않습니다.");
		history.back();
	</script>
	<%
}
%>
