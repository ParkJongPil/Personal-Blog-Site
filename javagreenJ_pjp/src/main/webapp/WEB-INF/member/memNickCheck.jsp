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
		function sendCheck() {
			opener.window.document.myForm.nickName.value = '${nickName}';
			opener.window.document.myForm.name.focus();
			window.close();
		}
		
		// 중복 아이디 다시 체크하기
		function nickCheck() {
			let nickName = childForm.nickName.value;
			
			if(nickName == "") {
				alert("닉네임을 입력하세요.");
				childForm.nickName.focus();
			}
			else {
				childForm.submit();
			}
		}
	</script>
	<style>
	body {
		width : 400px;
		height : 200px;
		border-radius : 30px;
		border: 5px solid gray;
		text-align:center;
		}
	</style>
</head>
<body>

<div class="w3-main w3-content w3-padding" style="max-width:1000px;margin-top:10px">
	<h2>닉네임 중복 체크</h2>
	<c:if test = "${res == 1}">
		<h4><font color="blue">${nickName}</font> 사용 가능한 닉네임입니다.</h4>
		<p><input type="button" value="창닫기" class="btn btn-primary" onclick="sendCheck()"/></p>
	</c:if>
	<c:if test="${res != 1}">
		<h4><font color="blue">${nickName}</font> 이미 사용중인 닉네임입니다.</h4>
		<form name="childForm" method="post" action="${ctp}/memNickCheck.mem">
			<p>
				<input type="text" name = "nickName"/>
				<input type="button" value="닉네임 검색" onclick="nickCheck()"/>
			</p>
		</form>
	</c:if>
</div>
<hr>
</body>
</html>