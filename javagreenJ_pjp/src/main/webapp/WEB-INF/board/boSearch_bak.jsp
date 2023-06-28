<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>boSearch.jsp</title>
	<%@ include file = "/include/bs4.jsp"%>
</head>
<body>
<%@ include file ="/include/nav.jsp"%>
<%@ include file ="/include/header_home.jsp"%>

<div class="w3-main w3-content w3-padding" style="max-width:1400px;margin-top:100px">
	<h2 class="text-center">게시판 검색 목록</h2>
		<div class = "text-center">(<font color='blue'>${searchTitle}</font>)(으)로 <font color='blue'>${searchString}</font>(을)를 검색한 결과 <font color='red'>${searchCount}</font>건이 검색 되었습니다.</div>
		<br/>
		<table class="table table-hover text-center">
			<tr class="table-dark text-dark">
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성날짜</th>
				<th>조회</th>
				<th>좋아요</th>
			</tr>
			<c:forEach var="vo" items="${vos}" varStatus="st">
				<tr>
					<td>${st.count}</td>
					<td class="text-left"><a href="boContent.bo?idx=$(vo.idx)&pag=${pag}&pageSize=${pageSize}&flag=s&search=${search}&searchString=${searchString}">${vo.title}</a>
						<c:if test ="${vo.wNdate <= 24}"><img src="images/new.gif"/></c:if>
					</td>
					<td>${vo.nickName}</td>
					<td>
						<c:if test="${vo.wNdate <= 24}">${fn:substring(vo.wDate,11,19)}</c:if>
						<c:if test="${vo.wNdate > 24}">${fn:substring(vo.wDate,0,10)}</c:if>
					</td>
					<td>${vo.readNum}</td>
					<td>${vo.good}</td>
				</tr>
			</c:forEach>
		<tr><td colspan="6" class="p-0"></td></tr>
	</table>
</div>
<hr>
<div class="text-center"><input type="button" value="이전으로"onclick="location.href='boList.bo?pag=${pag}&pageSize=${pageSize}';" class="btn btn-danger"/></div>
<%@ include file ="/include/footer.jsp"%>
</body>
</html>