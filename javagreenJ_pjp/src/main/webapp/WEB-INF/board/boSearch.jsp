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
		<c:if test="${not empty vos}">
	  <table class="table table-borderless table-hover" style="text-align:left;">
	  	  <c:set var="cnt" value="0"/>
		 <tr>
	    	<c:forEach var="vo" items="${vos}" varStatus="st">
	    	<c:set var="cnt" value="${cnt+1}"/>
		 <td style=width:300px height=450px>
		    <img src="${ctp}/data/board/${vo.fName}" width="1000px" height="450px"/><br/><br/>
		    <a href="boContent.bo?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}&sw=0"> <b>${vo.title} &nbsp;</b> <c:if test="${vo.wNdate <= 24}"><img src="images/new.gif"/></c:if></a><br/>
		    ${vo.nickName} <br/>
		    <c:if test="${vo.wNdate <= 24}">${fn:substring(vo.wDate,11,19)}</c:if>
	      <c:if test="${vo.wNdate > 24}">${fn:substring(vo.wDate,0,10)}</c:if>	<br/>
	     	👁️ : ${vo.readNum} &nbsp;<br/>
		    ❤️ <c:if test="${vo.good != 0}"> [${vo.good}]</c:if>  &nbsp; 📧 <c:if test="${vo.replyCount !=0}">  [${vo.replyCount}]</c:if><br/>
		    ${vo.content}
		 </td>
			<c:if test="${cnt == 4}">
			  </c:if>
		 </tr><tr>
	    	</c:forEach>
		    <c:set var="cnt" value="0"/>
	   </tr>
	  </table>
	</c:if>
</div>
<hr>
<div class="text-center"><input type="button" value="이전으로"onclick="location.href='boList.bo?pag=${pag}&pageSize=${pageSize}';" class="btn btn-danger"/></div>
<%@ include file ="/include/footer.jsp"%>
</body>
</html>