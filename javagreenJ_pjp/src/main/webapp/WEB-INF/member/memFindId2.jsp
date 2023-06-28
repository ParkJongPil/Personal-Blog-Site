<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<%
	String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>memFindId2.jsp</title>
	<%@ include file = "/include/bs4.jsp"%>
	<style>
	.mainBody{
		width: 600px;
		height: 250px;
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
<%-- <%@ include file ="/include/nav.jsp"%> --%>
<%@ include file ="/include/header_home.jsp"%>

<div class="w3-main w3-content w3-padding" style="max-width:1400px;margin-top:100px">
<div class="mainBody">
	<h3>아이디 찾기</h3>
	<div class="input-group">
	<form name = "myForm" method ="post" action = "{ctp}/memFindPwd.mem?mid=<%=mid%>">
		<p>가입하신 아이디는 <font color="blue"><%=mid%></font>입니다.</p>
		<button type="submit" name="password" class="btn btn-primary btn sm" id="searchBtn">비밀번호 찾기</button>
		<button type="button" name="return" class="btn btn-danger btn sm" id="searchBtn"onclick="location.href='${ctp}/memLogin.mem';"
		>돌아가기</button> &nbsp;</form>
	</div>
</div>
</div>
<hr>
</body>
</html>