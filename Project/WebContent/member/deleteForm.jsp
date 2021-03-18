<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
 <script type="text/JavaScript" src="http://code.jquery.com/jquery-1.7.min.js"></script>

	<script type="text/JavaScript" src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

	<script type="text/javascript">

		function openDaumZipAddress() {

			new daum.Postcode({

				oncomplete:function(data) {

					jQuery("#postcode1").val(data.postcode1);

					jQuery("#postcode2").val(data.postcode2);

					jQuery("#zonecode").val(data.zonecode);

					jQuery("#address").val(data.address);

					jQuery("#address_etc").focus();

					console.log(data);

				}

			}).open();

		}

	</script>
	
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<script src="../script/chat.js"></script>
 
 <style>
@import url('https://fonts.googleapis.com/css?family=Nanum+Gothic|Noto+Sans+KR&display=swap');
</style>

</head>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
 <jsp:include page="../inc/top.jsp"/> 
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 본문메인이미지 -->
<div id="sub_img_member"></div>
<!-- 본문메인이미지 -->
<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="#">Join us</a></li>
<li><a href="#">Privacy policy</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 본문내용 -->

<%
//수정할 회원정보 조회
//String id = 세션값 가져오기
String id = (String)session.getAttribute("id");

//mdao에 getMember 메서드 생성 리턴형 MemberBean

//MemberDAO mdao 객체생성 
MemberDAO mdao = new MemberDAO();
//MemberBean mb  = getMember(id) 메서드 호출
MemberBean mb = mdao.getMember(id);
%>

<script type="text/javascript">

function fun1() {
	if(!(document.join.pass.value.length>=4 && document.join.pass.value.length<=16)){
		alert("비밀번호를 4~16자로 입력해주세요.");
		document.join.pass.focus();
		return false;
	}
	
	if(document.join.pass.value!=document.join.pass2.value){
		alert("비밀번호가 일치하지 않습니다.")
		document.join.pass2.focus();
		return false;
	}
	




</script>

<article style="font-family: 'Noto Sans KR', sans-serif;">
<h2 style="font-size: 30px; color: black;">회원탈퇴</h2>
<form action="deletePro.jsp" method="post" class="delete">
<fieldset>
<legend style="font-family: 'Noto Sans KR', sans-serif;"></legend>
<label>아이디</label>
<input type="text" name="id" value="<%=id %>" readonly><br>
<label>비밀번호</label>
<input type="password" name="pass"><br>
<br>
<input type="submit" value="회원탈퇴" style="background-color: #000000; color: white; width: 160px;height: 30px;">
</fieldset>
</form>
</article>
<!-- 본문내용 -->
<!-- 본문들어가는 곳 -->

<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"/>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>