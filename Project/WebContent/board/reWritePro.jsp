<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>board/reWritePro.jsp</h1>
<%
// 한글처리
request.setCharacterEncoding("utf-8");
// 파라미터 가져오기  num re_ref re_lev re_seq name pass subject content
String name=request.getParameter("name");
String pass=request.getParameter("pass");
String subject=request.getParameter("subject");
String content=request.getParameter("content");
Timestamp date=new Timestamp(System.currentTimeMillis());
//답글 관련 파라미터 가져오기
int num = Integer.parseInt(request.getParameter("num"));
int re_ref = Integer.parseInt(request.getParameter("re_ref"));
int re_lev = Integer.parseInt(request.getParameter("re_lev"));
int re_seq = Integer.parseInt(request.getParameter("re_seq"));

// board패키지 BoardBean 파일 만들기
// BoardBean bb 객체 
BoardBean bb=new BoardBean();
// set메서드 호출 값 저장
bb.setName(name);
bb.setPass(pass);
bb.setSubject(subject);
bb.setContent(content);
bb.setDate(date);
bb.setReadcount(0);
//답글 관련 정보 자바빈 저장
bb.setRe_ref(re_ref);
bb.setRe_lev(re_lev);
bb.setRe_seq(re_seq);

// board패키지 BoardDAO 파일 만들기
// 리턴값없음 insertBoard(BoardBean bb) 메서드 만들기
// BoardDAO bdao 객체 
BoardDAO bdao=new BoardDAO();
// insertBoard(bb)메서드 호출
bdao.reInsertBoard(bb);

// list.jsp 글목록 이동
response.sendRedirect("notice.jsp");
%>
</body>
</html>