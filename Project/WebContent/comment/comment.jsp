<%@page import="comment.CommentDAO"%>
<%@page import="comment.CommentBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

CommentBean cb = new CommentBean();

//board 번호
cb.setBoard_num(Integer.parseInt(request.getParameter("num")));
cb.setComm_id((String)session.getAttribute("id"));
cb.setComm_content(request.getParameter("content"));

CommentDAO cdao = new CommentDAO();
int num = cdao.insertComment(cb);

response.sendRedirect("../board/content.jsp?num=" + num + "#cmtForm");
%>
