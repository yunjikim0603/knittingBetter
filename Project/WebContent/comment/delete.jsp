<%@page import="comment.CommentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	int comm_num = Integer.parseInt(request.getParameter("comm_num"));
	CommentDAO cdao = new CommentDAO();
	cdao.deleteComment(comm_num,num);
	response.sendRedirect("../board/content.jsp?num=" + num + "#cmtForm");
%>