<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<script src="../script/chat.js"></script>
 
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
	
	<style>
@import url('https://fonts.googleapis.com/css?family=Do+Hyeon|Nanum+Gothic|Noto+Sans+KR&display=swap');

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
<!-- <nav id="sub_menu"> -->
<!-- <ul> -->
<!-- <li><a href="#">Join us</a></li> -->
<!-- <li><a href="#">Privacy policy</a></li> -->
<!-- </ul> -->
<!-- </nav> -->
<!-- 왼쪽메뉴 -->
<!-- 본문내용 -->

<script type="text/javascript">
function fun1() {
	if(document.join.id.value.length==0){
		alert("아이디를 입력하세요.");
		document.join.id.focus();
		return false;
	}
	
/* 	if(!(document.join.id.value.length>=3 && document.join.id.value.length<=15)){
		alert("아이디를 3~15자로 입력해주세요.");
		document.join.id.focus();
		return false;
	} */
	
	if(document.join.pass.value.length==0){
		alert("비밀번호를 입력하세요.");
		document.join.pass.focus();
		return false;
	}
	
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
	

}

function winopen() {
	//id상자 비어있으면 제어 "아이디를 입력하세요" 포커스주기
	if(document.join.id.value.length==0){s
		alert("아이디를 입력하세요.");
	document.join.id.focus();
	return;
}
	//창열기 idcheck.jsp 만들기 "" width=300, height=200
// 	window.open("idcheck.jsp?wid="+id,"","width=300,height=200");
	
	  var id=document.join.id.value;
	  
	  var screenW = screen.availWidth;  // 스크린 가로사이즈
	  var screenH = screen.availHeight; // 스크린 세로사이즈
	  var popW = 350; // 띄울창의 가로사이즈
	  var popH = 200; // 띄울창의 세로사이즈
	  var posL=( screenW-popW ) / 2;   
	  var posT=( screenH-popH ) / 2; 

	 window.open("idcheck.jsp?wid="+id,"",'width='+ popW +',height='+ popH +',top='+ posT +',left='+ posL +',resizable=no,scrollbars=no');
	}
	




</script>

<article id="article_join" style="font-family: 'Noto Sans KR', sans-serif;">
<h2 style="font-size: 30px; color: black;">JOIN</h2>
<form action="joinPro.jsp" id="join" name="join" method="post" onsubmit="return fun1()">
<fieldset>
<legend style="font-family: 'Noto Sans KR', sans-serif;"><small>필수입력사항</small></legend>
<label>아이디</label>
<input type=text name="id" class="id">
<input type="button" value="중복확인" class="dup" onclick="winopen()" ><br>
<label>비밀번호</label>
<input type="password" name="pass"><br>
<label>비밀번호 재확인</label>
<input type="password" name="pass2"><br>
<label>이름</label>
<input type="text" name="name"><br>
<label>이메일</label>
<input type="email" name="email"><br>
<label>이메일 재확인</label>
<input type="email" name="email2"><br>
</fieldset>

<fieldset>
<legend style="font-family: 'Noto Sans KR', sans-serif;"><small>선택입력사항</small></legend>
<label>주소</label>

	<input id="zonecode" type="text" name="postcode" value="" style="width:50px;" readonly/>

	&nbsp;

	<input type="button" onClick="openDaumZipAddress();" value = "주소 찾기" />

	<br/>

	<input type="text" id="address" name="address" value="" style="width:240px;" readonly/>

	<input type="text" id="address_etc" name="address2" value="" style="width:200px;"/><br>
	
<label>전화번호</label>
<input type="text" name="phone"><br>
<label>휴대전화</label>
<input type="text" name="mobile"><br>
</fieldset>
<br><br>
<div class="clear"></div>
<div id="buttons">
<input type="submit" value="회원가입" class="submit" style="margin-left: 50px; background-color: #000000; color: white; width: 160px;height: 30px;">
<input type="reset" value="초기화" class="cancel" style="background-color: white; color: black; width: 160px; height: 30px;" onclick="javascript:document.join.value==0">


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