<%@page import="comment.CommentDAO"%>
<%@page import="comment.CommentBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
int board_num = Integer.parseInt(request.getParameter("board_num"));
int comm_num = Integer.parseInt(request.getParameter("comm_num"));
String comm_content = request.getParameter("comm_content");

CommentBean cb = new CommentBean();
CommentDAO cdao = new CommentDAO();
cb.setComm_num(comm_num);
cb.setComm_content(comm_content);
cdao.updateComment(cb);

response.sendRedirect("../board/content.jsp?num="+board_num+"#cmtForm");
%>