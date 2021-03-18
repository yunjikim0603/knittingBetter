
<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


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

<%
//한글처리
request.setCharacterEncoding("utf-8");

//request 요청 정보 저장
String id=request.getParameter("id");
String pass=request.getParameter("pass");
String name=request.getParameter("name");
String email=request.getParameter("email");
String address=request.getParameter("address");
String address2=request.getParameter("address2");
String postcode=request.getParameter("postcode");
String phone=request.getParameter("phone");
String mobile=request.getParameter("mobile");


//MemberBean mb 객체생성
MemberBean mb=new MemberBean();

//멤버변수 에 파라미터 값 저장
mb.setId(id);
mb.setPass(pass);
mb.setName(name);
mb.setEmail(email);
mb.setAddress(address);
mb.setAddress2(address2);
mb.setPostcode(postcode);
mb.setPhone(phone);
mb.setMobile(mobile);

//MemberDAO mdao 객체생성
MemberDAO mdao=new MemberDAO();

//int check =  userCheck(id,pass) 호출
int check = mdao.userCheck(id,pass);

//mdao 에 updateMember() 메서드 만들기
if(check==1){
	//check==1 비밀번호 맞음  수정 3단계 sql update  4단계 실행 main.jsp 이동
		// updateMember(mb) 호출
		mdao.updateMember(mb);
		// main.jsp 이동
		%>
		<script type="text/javascript">
			alert("회원정보 수정이 완료되었습니다.");
			location.href="../member/updateForm.jsp";
		</script>
		<% 
	}else if(check==0){
		//check==0 비밀번호틀림
		%>
		<script type="text/javascript">
			alert("비밀번호가 일치하지 않습니다.");
			history.back();
		</script>
		<%
	}else{
		//check==-1아이디없음
		%>
		<script type="text/javascript">
			alert("아이디가 존재하지 않습니다.");
			history.back();
		</script>
		<%
	}



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









