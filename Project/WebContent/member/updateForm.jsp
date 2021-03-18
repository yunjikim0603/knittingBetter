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
	
	if(document.join.name.value.length==0){
		alert("이름을 입력하세요.");
		document.join.name.focus();
		return false;
	}
	
	if(document.join.email.value.length==0){
		alert("이메일을 입력하세요.");
		document.join.email.focus();
		return false;
	}
	
	if(document.join.email.value!=document.join.email2.value){
		alert("이메일이 일치하지 않습니다.")
		document.join.email2.focus();
		return false;

	}
	
// 	if(!(document.join.pass.value.length>=4 && document.join.pass.value.length<=16)){
// 		alert("비밀번호를 4~16자로 입력해주세요.");
// 		document.join.pass.focus();
// 		return false;
// 	}
	
	if(document.join.pass.value!=document.join.pass2.value){
		alert("비밀번호가 일치하지 않습니다.")
		document.join.pass2.focus();
		return false;
	}
	


	

</script>

<article style="font-family: 'Noto Sans KR', sans-serif; margin-left: 280px;">
<h2 style="font-size: 30px; color: black; ">MY PAGE</h2>
<form action="updatePro.jsp" class="update" id="update" name="update" method="post" onsubmit="return fun1()">
<fieldset>
<legend style="font-family: 'Noto Sans KR', sans-serif;"><small>필수입력사항</small></legend>
<label>아이디</label>
<input type="text" name="id" class="id" value="<%=id%>" readonly><br>
<label>이름</label>
<input type="text" name="name" value="<%=mb.getName()%>"><br>
<label>이메일</label>
<input type="email" name="email" value="<%=mb.getEmail()%>"><br>
<label>이메일 재확인</label>
<input type="email" name="email2" value="<%=mb.getEmail()%>"><br>
</fieldset>

<fieldset>
<legend style="font-family: 'Noto Sans KR', sans-serif;"><small>선택입력사항</small></legend>
<label>주소</label>
<%-- <input type="text" name="address" value="<%=mb.getAddress()%>"><br> --%>



	<input id="zonecode" type="text" name="postcode" value="<%=mb.getPostcode() %>" style="width:50px;" readonly/>

	&nbsp;

	<input type="button" onClick="openDaumZipAddress();" value = "주소 찾기" />

	<br/>

	<input type="text" id="address" name="address" value="<%=mb.getAddress() %>" style="width:240px;" readonly/>

	<input type="text" id="address_etc"  name="address2" value="<%=mb.getAddress2() %>" style="width:200px;"/><br>
	
<label>전화번호</label>
<input type="text" name="phone" value="<%=mb.getPhone()%>"><br>
<label>휴대전화</label>
<input type="text" name="mobile" value="<%=mb.getMobile()%>"><br>
</fieldset>
<br>



비밀번호 확인 <input type="password" name="pass"><br>
<br>

<div class="clear"></div>
<div id="buttons">
<input type="submit" value="회원정보수정" class="submit" style=" background-color: #000000; color: white; width: 110px; height: 30px;">
<input type="button" value="취소" style="background-color: white; color: black; width: 110px; height: 30px;" onclick="location.href='../main/main.jsp'">
<input type="button" value="회원탈퇴" style=" float: right; margin-right: 28px; background-color: #d3d3d3; color: black; width: 110px; height: 30px;" onclick="location.href='deleteForm.jsp'">
</div>
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