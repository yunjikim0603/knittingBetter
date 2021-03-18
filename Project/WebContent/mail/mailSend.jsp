<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="mailtest.GoogleAuthentication"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="javax.activation.*"%>
<%@ page import="java.util.*"%>
<%@ page import="javax.mail.*"%>
<%@ page import="javax.mail.internet.*"%>
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
<!-- 헤더가 들어가는 곳 -->
<jsp:include page="../inc/top.jsp" />
<!-- 헤더가 들어가는 곳 -->

<!-- 본문 들어가는 곳 -->
<!-- 서브페이지 메인이미지 -->
<div id="sub_img"></div>
<!-- 서브페이지 메인이미지 -->
<!-- 왼쪽메뉴 -->
<!-- <nav id="sub_menu"> -->
<!-- <ul> -->
<!-- <li><a href="#">Welcome</a></li> -->
<!-- <li><a href="#">History</a></li> -->
<!-- <li><a href="#">Newsroom</a></li> -->
<!-- <li><a href="#">Public Policy</a></li> -->
<!-- </ul> -->
<!-- </nav> -->
<!-- 왼쪽메뉴 -->
<!-- 내용 -->
<article>
<!-- <h1>문의사항</h1> -->


</article>
<!-- 내용 -->


<html>
<head>
<title>문의사항</title>
<style>
	table{
		width : 450px;
		margin : auto;
	}
	h1{
		text-align: center;
	}
	td{
		border : 1px dotted gray;
	}
</style>
</head>
<body>
<form action="mailSend.jsp" method="post">
<!-- <h1>문의사항</h1> -->

<%
	request.setCharacterEncoding("UTF-8");
	String sender = request.getParameter("sender");
	String receiver = request.getParameter("receiver");
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");

	try {
		Properties properties = System.getProperties();
		properties.put("mail.smtp.starttls.enable", "true"); // gmail은 무조건 true 고정
		properties.put("mail.smtp.host", "smtp.gmail.com"); // smtp 서버 주소
		properties.put("mail.smtp.auth", "true"); // gmail은 무조건 true 고정
		properties.put("mail.smtp.port", "587"); // gmail 포트
		Authenticator auth = new GoogleAuthentication();
		Session s = Session.getDefaultInstance(properties, auth);
		//Session s = Session.getdefultInstance(properties, auth);
		Message message = new MimeMessage(s);
		Address sender_address = new InternetAddress(sender);
		Address receiver_address = new InternetAddress(receiver);
		message.setHeader("content-type", "text/html;charset=UTF-8");
		message.setFrom(sender_address);
		message.addRecipient(Message.RecipientType.TO, receiver_address);
		message.setSubject(subject);
		message.setContent(content, "text/html;charset=UTF-8");
		message.setSentDate(new java.util.Date());
		Transport.send(message);
		%>
		<script type="text/javascript">
		alert("메일이 정상적으로 전송되었습니다.");
		history.back();
		</script>
		<%
		
	} catch (Exception e) {
		%>
		<script type="text/javascript">
		alert("로그인을 해주세요.");
		history.back();
		</script>
		<%
		e.printStackTrace();
	}
%>

</form>
</body>
</html>



<div class="clear"></div>
<!-- 푸터 들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"/>
<!-- 푸터 들어가는 곳 -->
</div>
</body>
</html>



    