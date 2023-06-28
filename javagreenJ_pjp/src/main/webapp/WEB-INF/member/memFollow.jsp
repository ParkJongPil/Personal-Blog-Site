<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>memFollow.jsp</title>
	<%@ include file = "/include/bs4.jsp"%>
<style>
.mainBody{
		width: 800px;
		height: 800px;
		border: 10px;
		border-color: gray;
		border-radius: 10px;
		border-style: solid;	
		margin-left: 250px;
		padding: 50px;
	}
	btn{
		text-align:center
	}
</style>
</head>
<body>
<%@ include file ="/include/nav.jsp"%>
<%@ include file ="/include/header_home.jsp"%>

<div class="w3-main w3-content w3-padding" style="max-width:1400px;margin-top:100px">
 <div class="mainBody">
	<h2 class="text-center">내가 팔로우 하는 사람들</h2>
		<br/>
		<table class="table table-hover text-center">
			<tr class="table-dark">
				<th>번호</th>
				<th>팔로잉</th>
			</tr>
		<c:forEach var="vo" items="${vos}" varStatus="st">
			<tr>
				<td>${curScrStartNo}</td>
				<td>${vo.follower}</td>
			</tr>
			<c:set var="curScrStartNo" value="${curScrStartNo-1}"></c:set>
		</c:forEach>
		 <tr><td colspan="2"></td></tr>
		</table>
		<input type="reset" value="돌아가기" onclick=history.back() class="btn btn-primary" style="text-align:center"/>
 </div>
</div>
<hr>
<%@ include file ="/include/footer.jsp"%>
</body>
</html>