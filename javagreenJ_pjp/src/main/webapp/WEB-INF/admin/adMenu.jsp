<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	
	<title>adMenu.jsp</title>
	<%@ include file = "/include/bs4.jsp"%>
	<frameset cols ="220px, *">
		<frame src="${ctp}/adLeft.ad" name="adLeft" />
		<frame src="${ctp}/adContent.ad" name="adContent" />
	</frameset>
	
</head>
<body>
<%@ include file ="/include/nav.jsp"%>
<%@ include file ="/include/header_home.jsp"%>

<div class="w3-main w3-content w3-padding" style="max-width:1400px;margin-top:100px">


</div>
<hr>
<%@ include file ="/include/footer.jsp"%>
</body>
</html>