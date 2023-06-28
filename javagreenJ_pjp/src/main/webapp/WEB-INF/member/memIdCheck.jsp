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
		//팝업창 만들기
		function sendCheck() {
			opener.window.document.myForm.mid.value= '${mid}';
			opener.window.document.myForm.pwd.focus();
			window.close();
		}
		
		// 중복 아이디 다시 체크하기
		function idCheck() {
			let mid = childForm.mid.value;
			
			if(mid == "") {
					alert("아이디를 입력하세요.");
					childForm.mid.focus();
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
		border-radius :30px;
		border: 5px solid gray;
		background-size :cover;
		text-align:center;
	}
	</style>
</head>
<body>
<div class="w3-main w3-content w3-padding" style="max-width:1000px; margin-top:15px">
	<h2>아이디 중복 체크</h2>
	<c:if test="${res == 1}">
		<h4><font color="blue">${mid}</font> 사용 가능한 아이디입니다.</h4>
		<p><input type="button" class="btn btn-primary" value="창닫기" onclick="sendCheck()"/></p>
	</c:if>
	<c:if test="${res != 1}">
		<h4><font color="blue">${mid}</font> 이미 사용중인 아이디입니다. </h4>
		<form name="childForm" method="post" action="${ctp}/memIdCheck.mem">
			<p>
				<input type="text" name="mid"/>
				<input type="button" value="아이디 검색" onclick ="idCheck()"/>
			</p>
		</form>
	</c:if>
	</div>
</body>
</html>