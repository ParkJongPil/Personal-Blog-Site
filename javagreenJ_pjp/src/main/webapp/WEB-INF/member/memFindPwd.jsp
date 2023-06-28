<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>memFindePwd</title>
	<%@ include file = "/include/bs4.jsp"%>
	<script>
		'use strict';
		function pwdCheck(){
			let mid = document.getElementById("mid").value;										// 아이디값
			let email1 = document.getElementById("email1").value;						// 이메일 아이디부분
			let email2 = document.getElementById("email2").value;								// 이메일 주소부분
			let email3 = document.getElementById("email").value;								
			
			
			
			if(mid.trim() == ""){														
				alert("아이디를 입력해주세요.");
				myForm.mid.focus();
			}
			else if(email1.trim() == ""){
				alert("아이디를 입력해주세요.");
				myForm.email1.focus();
			}
			else{
				document.getElementById("email").value = email1 + "@" + email2;
				myForm.submit();
			}
			
		}
		
		
	</script>
	<style>
	.mainBody{
		width: 600px;
		height: 500px;
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
	<form name="myForm" method="post" action="${ctp}/memFindPwdOk.mem">
	<div class="mainBody">
	<h3 class=" text-center"> 비밀번호 찾기</h3>
	<div class="container p-5">
	<div class="form-group">
	<label for="mid">아이디 : </label>
	<input class="form-control" type="text" name="mid" id="mid" value="${param.mid}" style="width:340px" placeholder="아이디를 입력해주세요" />
	</div>
	<div class="form-group">
	      <label for="email1">이메일 주소 : </label>
					<div class="input-group mb-3">
					  <div class="input-control">
					  <input type="text" class="form-control mr-2" style="width:200px" placeholder="이메일을 입력하세요." id="email1" name="email1" required />
					  </div>
					  <div class="input-control">
					    <select name="email2" id="email2" class="custom-select">
						    <option value="naver.com" selected>naver.com</option>
						    <option value="hanmail.net">hanmail.net</option>
						    <option value="hotmail.com">hotmail.com</option>
						    <option value="gmail.com">gmail.com</option>
						    <option value="nate.com">nate.com</option>
						    <option value="yahoo.com">yahoo.com</option>
						  </select>
					  </div>
					  <input type="hidden" name="email" id="email" value=""/>
					</div>
		 </div>
		 </div>	  
		 <div class="form-group text-center">
		  <input type="button" class="btn btn-primary" onclick="pwdCheck()" value="찾기"/>
			<input type="reset" value="돌아가기" onclick=history.back() class="btn btn-danger"/>
		 </div>
</div>
	</form>
	</div>
<hr>
</body>
</html>