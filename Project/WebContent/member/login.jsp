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

<!-- 본문내용 -->
<article id="article_login">

<script type="text/javascript">
	
	function fun1() {
		if(document.join.id.value==0){
			alert("아이디를 입력하세요");
			document.join.id.focus();
			return false;
		}
		
// 		if(!(document.join.id.value.length>=3 && document.join.id.value.length<=15)){
// 			alert("아이디를 3~15자로 입력해주세요.");
// 			document.join.id.focus();
// 			return false;
// 		}
		
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
	}
	

</script>



<form action="loginPro.jsp" id="login" name="login" method="post" onsubmit="return fun1()">
<div class="clear"></div>
<fieldset style="width: 310px; border: none;" >
<br><br>
<legend style="text-align:center; font-size: 30px; font-family: 'Noto Sans KR', sans-serif; color: black; font-weight: 900; border: none;">Login</legend>
<table>
<tr>
<td><input type="text" name="id" placeholder=" ID" style="WIDTH: 390px; HEIGHT: 40px; font-size: 18px; " required></td>
</tr>
<tr>
<td><input type="password" name="pass" placeholder=" PASSWORD" style="WIDTH: 390px; HEIGHT: 40px; font-size: 18px;" required></td>
</tr>
<!--       <div id="buttons"> -->
<tr>
<td colspan=2><input type="submit" value="Login" class="submit" style="WIDTH: 390px; HEIGHT: 40px; background-color: black; color: white;" > </td>
</tr>
<tr>
<td><a href="join.jsp"><input type="button" value="Join us" class="submit" style="WIDTH: 390px; HEIGHT: 40px; background-color: white; color: black;"  ></a></td>
</tr>
</table>
</fieldset>

<!-- </div> -->
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