<%@page import="board.BoardBean"%>
<%@page import="board.BoardDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// center/fwritePro.jsp
// WebContent    upload폴더 만들기

// cos.jar 프로그램 설치
// MultipartRequest 객체생성
String realPath=request.getRealPath("/upload");
int maxSize=10*1024*1024;
MultipartRequest multi=new MultipartRequest(request,realPath,maxSize,"utf-8",new DefaultFileRenamePolicy());

// BoardBean bb객체생성
BoardBean bb=new BoardBean();
// bb 멤버변수 <- 업로드 파라미터 값 저장
bb.setContent(multi.getParameter("content"));
bb.setName(multi.getParameter("name"));
bb.setPass(multi.getParameter("pass"));
bb.setSubject(multi.getParameter("subject"));
bb.setFile(multi.getFilesystemName("file"));
Timestamp date=new Timestamp(System.currentTimeMillis());
bb.setDate(date);
bb.setReadcount(0);

// BoardDAO bdao 객체생성
BoardDAO bdao=new BoardDAO();
// insertBoard(bb) 메서드호출
bdao.insertBoard(bb);

// fnotice.jsp 이동
response.sendRedirect("notice.jsp");
%>