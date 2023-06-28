<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>memList.jsp</title>
	<%@ include file = "/include/bs4.jsp"%>
	<script>
	'use strict';
		function userDelCheck(idx) {
			let ans=confirm("정말 회원에서 삭제처리하시겠습니까?");
			if(ans) location.href="${ctp}/memUserDelete.mem?idx="+idx;
		}
		function infor() {
			let mid=document.getElementById('mid').value;
 			let url="${ctp}/memInfor.mem?mid="+mid;
 			window.open(url,"nWin","width=580px,height=250px");
		}
	</script>
	<style>
	th {
		background-color:#EAEAEA;
		color:black;
		}
		th:hover{
		opacity: 0.8;
		cursor: pointer;
		color:white;
		}
		
	</style>
</head>
<body>
<p><br/></p>
<div class="container">
	<h2 class="text-center">전체 회원 목록</h2>
	<br/>
	<table class="table table-hover text-center">
		<tr>
			<th>번호</th>
			<th>아이디</th>
			<th>닉네임</th>
			<th>성명</th>
			<th>공개유무</th>
			<th>회원상태</th>
		</tr>
		<c:forEach var ="vo" items ="${vos}" varStatus="st">
		<c:choose>
		<c:when test="${sMid != vo.mid}">
		<tr>
				<td>${curScrStartNo-1}</td>
				<td><a href="${ctp}/memInforHomePage.mem?mid=${vo.mid}" target="_blank"><font color='blue'>${vo.mid}</font></a></td>
				<td>${vo.nickName}</td>
				<td>${vo.name}</td>
				<td>${vo.userInfor}</td>
				
				<td>
					<c:if test="${vo.userDel=='OK'}"><font color="red">탈퇴신청 </font>
					<c:if test="${vo.applyDiff >= 30}"><font color="blue"><a href="javascript:userDelCheck(${vo.idx})">*</a></font></c:if>
					</c:if>
					<c:if test="${vo.userDel!='OK'}">활동중</c:if>
				</td>
			</tr>
			<c:set var="curScrStartNo" value="${curScrStartNo-1}"></c:set>
		</c:when>
		</c:choose>		
		</c:forEach>
		<tr><td colspan="5"></td></tr>
	</table>
	<input type="reset" value="돌아가기" onclick=history.back() class="btn btn-primary" />
	
</div>
</body>
</html>