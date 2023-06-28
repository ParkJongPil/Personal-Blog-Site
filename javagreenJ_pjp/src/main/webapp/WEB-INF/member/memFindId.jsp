<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>memFindId.jsp</title>
	<%@ include file = "/include/bs4.jsp"%>
	<style>
	.mainBody{
		width: 600px;
		height: 300px;
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
	<h3><label for="email">아이디 찾기</label></h3>
	<p>가입하신 아이디는 이메일을 통해 찾을 수 있습니다.</p>
	<div class="input-group">
	<form name="myForm" method="post" action="{ctp}/memFindIdOk.mem">
		<input type="text" name="email" id="email" class="form-control" placeholder="이메일을 입력하세요." required/><br/>
		<button type="submit" name="search" id="search" class="btn btn-primary">찾기</button>
		<input type="reset" value="돌아가기" onclick=history.back() class="btn btn-danger"/>

	</form>
	</div>
	</div>


</div>
<hr>
</body>
</html>