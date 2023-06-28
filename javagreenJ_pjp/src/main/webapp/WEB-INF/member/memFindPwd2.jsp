<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>title</title>
	<%@ include file = "/include/bs4.jsp"%>
	<script>
		function pwdCheck() {
			let pwd1 = myForm.pwd1.value;
			let pwd2 = myForm.pwd2.value;
			
			if(pwd1 == pwd2) {
				myForm.submit();
			}
			else {
				alert("비밀번호가 일치하지 않습니다. 다시 입력해 주세요.");
					myForm.pwd2.value="";
					myForm.pwd2.focus();
			}
			
		}
	</script>
	<style>
	.mainBody{
		width: 600px;
		height: 350px;
		border: 10px;
		border-color: gray;
		border-radius: 10px;
		border-style: solid;	
		margin-left: 400px;
		padding: 50px;
	}
	</style>
</head>
<body>
<%@ include file ="/include/nav.jsp"%>
<%@ include file ="/include/header_home.jsp"%>

<div class="w3-main w3-content w3-padding" style="max-width:1400px;margin-top:100px">
<div class="mainBody">
	<h3>비밀번호 찾기</h3>
	<p>비밀번호는 가입한 아이디, 이메일을 통해 찾을 수 있습니다.</p>
	<div class="form-group">
	<form name="myForm" method="post" action="{ctp}/memUpdateOk.mem">
		<input type="password" name="pwd1" id="pwd1" class ="form-control" placeholder="신규 비밀번호" required/><br/>
		<input type="password" name="pwd2" id="pwd2" class="form-control" placeholder="신규 비밀번호 재입력" required/><br/>
		<input type="hidden" name="mid" value="${param.mid}">
		<button type="button" name="password" id="password" class="btn btn-primary" onclick="pwdCheck()">완료</button>
	</form>
	</div>
</div>
</div>
<hr>
</body>
</html>