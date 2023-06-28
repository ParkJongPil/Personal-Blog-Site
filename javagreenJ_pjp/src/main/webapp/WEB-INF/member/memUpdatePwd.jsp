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
	'use strict';
	function fCheck() {
		let pwd = myForm.pwd.value;
		let newPwd = myForm.newPwd.value;
		let reNewPwd = myForm.reNewPwd.value;
		
		if(pwd=="") {
			alert="비밀번호를 다시 입력하세요.";
			myForm.pwd.focus();
		}
		else if(newPwd=="") {
			alert="비밀번호를 다시 입력하세요.";
			myForm.newPwd.focus();
		}
		else if(reNewPwd=="") {
			alert="비밀번호를 다시 입력하세요";
			myForm.reNewPwd.focus();
		}
		else {
			myForm.submit();
		}
		
	}
	
	</script>
	<style>
		.mainBody{
		width: 600px;
		height: 450px;
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
	<h3>비밀번호 변경</h3>
	<form name="myForm" method="post" action="{ctp}/memUpdatePwdOk.mem">
		<p>
		<label for="pwd">현재 비밀번호:</label><br/>
		<input type="password" name="pwd" id="pwd" class="form-control" placeholder="현재 비밀번호">
		</p>
		<p>
		<label for="newPwd">신규 비밀번호:</label><br/>
		<input type="password" name="newPwd" id="newPwd" class="form-control" placeholder="신규 비밀번호">
		</p>
		<p>
		<label for="reNewPwd">신규 비밀번호 재입력:</label>
		<input type="password" name="reNewPwd" id="reNewPwd" class="form-control" placeholder="신규 비밀번호 재입력"><br/>
		<button type="button" name="search" id="search" class="btn btn-primary" onclick="fCheck()">완료</button>
		<button type="button" name="return" id="return" class="btn btn-danger" onclick="location.href='${ctp}/memMyPage.mem';">돌아가기</button>
		</p>
	</form>
 </div>
</div>
<hr>
<%@ include file ="/include/footer.jsp"%>
</body>
</html>