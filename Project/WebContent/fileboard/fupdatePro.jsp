<%@page import="fboard.FBoardDAO"%>
<%@page import="fboard.FBoardBean"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// center/fupdatePro.jsp
String realPath=request.getRealPath("/upload");
int maxSize=10*1024*1024;
MultipartRequest multi=new MultipartRequest(request,realPath,maxSize,"utf-8",new DefaultFileRenamePolicy());


// 파라미터 가져오기
int num=Integer.parseInt(multi.getParameter("num"));
String name=multi.getParameter("name");
String pass=multi.getParameter("pass");
String subject=multi.getParameter("subject");
String content=multi.getParameter("content");
String file=multi.getFilesystemName("file");
String old_file=multi.getParameter("old_file");
// BoardBean bb 객체생성
FBoardBean bb=new FBoardBean();
// bb 멤버변수 <= 파라미터값 저장
bb.setNum(num);
bb.setName(name);
bb.setPass(pass);
bb.setSubject(subject);
bb.setContent(content);
if(file!=null){
	System.out.println("비어있지 않으면");
	bb.setFile(file);
}else{
	System.out.println("비어있음");
	bb.setFile(old_file);
}

// BoardDAO bdao 객체생성
FBoardDAO bdao=new FBoardDAO();
// int check = updateBoard(bb)
int check=bdao.updateBoard(bb);
// check==1  수정성공     notice.jsp 이동
// check==0  비밀번호틀림  뒤로이동
if(check==1){
	// check== 0이면 
		%>
		<script type="text/javascript">
		 	alert("수정되었습니다.");
		 	location.href="fnotice.jsp";
		</script> 
		<%
}else{
	// check== 0이면 
		%>
		<script type="text/javascript">
		 	alert("비밀번호가 일치하지 않습니다.");
		 	history.back();
		</script> 
		<%
}
%>