<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>adLeft.jsp</title>
	<%@ include file = "/include/bs4.jsp"%>
	<script>
		function logoutCheck() {
			parent.location.href = "${ctp}/memLogOut.mem";
		}
	</script>
	<style>                                                                                           
		body {
		text-align:center;
		background-color:#D9E5FF;
		}
	</style>
</head>
<body>
<p><br/></p>
<div class="w3-bar-item w3-button">
	<h4>Admin Menu</h4>
	<hr/>
	<p><a href="${ctp}/" class="w3-bar-item w3-button" target="_top">Home</a></p>
	<p><a href="${ctp}/adMemList.ad"class="w3-bar-item w3-button" target="adContent">MemList</a></p>
	<p><a href="${ctp}/boList.bo" class="w3-bar-item w3-button" target="boList">TimeLine</a></p>
	<p><a href="${ctp}/adNotice.ad" class="w3-bar-item w3-button" target="boList">Notice Write</a></p>
	<p><a href="javascript:logoutCheck()" class="w3-bar-item w3-button">LogOut</a></p>
</div>
</body>
</html>