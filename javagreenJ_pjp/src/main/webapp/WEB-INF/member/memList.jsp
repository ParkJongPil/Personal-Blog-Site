<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>memList.jsp</title>
	<%@ include file = "/include/bs4.jsp"%>
	<style>
	th {
		background-color:#EAEAEA;
		color:black;		
	}
	.text {
	text-align:center;
	}
	.mainBody{
		width: 800px;
		height: 900px;
		border: 10px;
		border-color: gray;
		border-radius: 10px;
		border-style: solid;	
		margin-left: 250px;
		padding: 50px;
	}
	</style>
</head>
<body>
<%@ include file ="/include/nav.jsp"%>
<%@ include file ="/include/header_home.jsp"%>

<div class="w3-main w3-content w3-padding" style="max-width:1400px;margin-top:100px">
<div class="mainBody">
	<h2 class="text">전체 회원 목록</h2>
		<br/>
		<table class="table table-hover text-center">
			<tr>
				<th>번호</th>
				<th>아이디</th>
				<th>닉네임</th>
				<th>성명</th>
				<th>성별</th>
			</tr>
		<c:forEach var="vo" items="${vos}" varStatus="st">
		<c:choose>
			<c:when test="${sMid != vo.mid}">
			<tr>
				<td>${curScrStartNo-1}</td>
				<td>
				<a href="${ctp}/memInforHomePage.mem?mid=${vo.mid}&gender=${vo.gender}"><font color='blue'>${vo.mid}</font></a>
				</td>
				<td>${vo.nickName}</td>
				<td>${vo.name}</td>
				<td>${vo.gender}</td>
			</tr>
			<c:set var="curScrStartNo" value="${curScrStartNo-1}"></c:set>
			</c:when>
		</c:choose>
		</c:forEach>
		 <tr><td colspan="5"></td></tr>
		</table>
		<input type="reset" value="돌아가기" onclick=history.back() class="btn btn-primary" style=text-align:right />
	</div>
</div>
<hr>
<%@ include file ="/include/footer.jsp"%>
</body>
</html>