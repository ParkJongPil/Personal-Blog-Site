<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>boList.jsp</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
  <%@ include file="/include/bs4.jsp" %>
<script>
    'use strict';
    // 검색기 처리
    function searchCheck() {
    	let searchString = $("#searchString").val();
    	
    if(searchString.trim() == "") {
    	alert("검색어를 입력하세요!");
    	searchForm.searchString.focus();
    }
    else {
    	searchForm.submit();
    	}
    }
</script>
<style>
table,body,h1,h2,h3,h4,h5,h6 {font-family: "Karma", sans-serif}
 .nav-link active{
 	bgcolor:#B2CCFF;
 }
 </style>
</head>
<body>
<%@ include file="/include/header_home.jsp" %>
<%@ include file="/include/nav.jsp" %>
<div class="container"><br/>
  <h2><b>Board</b></h2>
  <br>
  <!-- Nav tabs -->
  <ul class="nav nav-tabs" role="tablist">
    <li class="nav-item">
      <a class="nav-link active" data-toggle="tab" href="#home"><b>All Board</b></a>
    </li>
    <li class="nav-item">
      <a class="nav-link" data-toggle="tab" href="#menu1"><b>Follow Board</b></a>
    </li>
    <li class="nav-item">
      <a class="nav-link" data-toggle="tab" href="#menu2"><b>My Board</b></a>
    </li>
  </ul>

  <!-- Tab panes -->
  <div class="tab-content"><br/>
  <div id="home" class="container tab-pane active"><br>
  <!--전체 글보기  -->
	<c:if test="${not empty vos}">
   <table class="table table-borderless table-hover" style="text-align:left;">
  		<tr><td><a href="{ctp}/boInput.bo" class="btn btn-primary">Write</a></td></tr>
			<c:forEach var="vo" items="${vos}" varStatus="st">
    <tr>
			<td style=width:300px height=450px>
			  <img src="${ctp}/data/board/${vo.fName}" width="1000px" height="450px"/><br/><br/>
			  <a href="boContent.bo?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}&sw=0"> <b>${vo.title} &nbsp;</b> 
			  <c:if test="${vo.wNdate <= 24}"><img src="images/new.gif"/></c:if></a><br/>
			  ${vo.nickName} <br/>
			  <c:if test="${vo.wNdate <= 24}">${fn:substring(vo.wDate,11,19)}</c:if>
			  <c:if test="${vo.wNdate > 24}">${fn:substring(vo.wDate,0,10)}</c:if><br/>
			 	👁️ : ${vo.readNum} &nbsp;<br/>	
			  ❤️ <c:if test="${vo.good != 0}"> [${vo.good}]</c:if>  &nbsp; 
			  📧 <c:if test="${vo.replyCount !=0}">  [${vo.replyCount}]</c:if><br/>
			  ${vo.content}
			</td>
	 </tr>
			</c:forEach>
	</table>
 </c:if> 
 </div> 
	
	<!--팔로워 글보기  -->
  <div id="menu1" class="container tab-pane fade"><br>
   <c:if test="${not empty vos}">
	  <table class="table table-borderless table-hover" style="text-align:left;">
			<c:forEach var="vo" items="${follvos}" varStatus="st">
	   <tr>
		 	<td style=width:300px height=450px>
			  <img src="${ctp}/data/board/${vo.fName}" width="1000px" height="450px"/><br/><br/>
			  <a href="boContent.bo?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}&sw=0"> <b>${vo.title} &nbsp;</b> 
			  <c:if test="${vo.wNdate <= 24}"><img src="images/new.gif"/></c:if></a><br/>
			  ${vo.nickName} <br/>
			  <c:if test="${vo.wNdate <= 24}">${fn:substring(vo.wDate,11,19)}</c:if>
			  <c:if test="${vo.wNdate > 24}">${fn:substring(vo.wDate,0,10)}</c:if>	<br/>
			 	👁️ : ${vo.readNum} &nbsp;<br/>
			  ❤️ <c:if test="${vo.good != 0}"> [${vo.good}]</c:if>  &nbsp; 
			  📧 <c:if test="${vo.replyCount !=0}">  [${vo.replyCount}]</c:if><br/>
		  	${vo.content}
	 		</td>
	 	</tr>
		</c:forEach>
   </table>
	 </c:if>
  </div>
    <!-- 내 글보기 -->
  <div id="menu2" class="container tab-pane fade"><br>
   <c:if test="${not empty vos}">
   <table class="table table-borderless table-hover" style="text-align:left;">
		<c:forEach var="vo" items="${myvos}" varStatus="st">
		 <tr>
			 <td style=width:300px height=450px>
				  <img src="${ctp}/data/board/${vo.fName}" width="1000px" height="450px"/><br/><br/>
				  <a href="boContent.bo?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}&sw=0"> <b>${vo.title} &nbsp;</b> 
				  <c:if test="${vo.wNdate <= 24}"><img src="images/new.gif"/></c:if></a><br/>
				  ${vo.nickName} <br/>
				  <c:if test="${vo.wNdate <= 24}">${fn:substring(vo.wDate,11,19)}</c:if>
				  <c:if test="${vo.wNdate > 24}">${fn:substring(vo.wDate,0,10)}</c:if>	<br/>
				 	👁️ : ${vo.readNum} &nbsp;<br/>
				  ❤️ <c:if test="${vo.good != 0}"> [${vo.good}]</c:if>  &nbsp; 📧 <c:if test="${vo.replyCount !=0}">  [${vo.replyCount}]</c:if><br/>
				  ${vo.content}
			 </td>
		 </tr>
		</c:forEach>
   </table>
	 </c:if>  
   </div>
  </div>
</div>
<!-- 검색기 처리 시작 -->
<div class="container text-center">
	<form name="searchForm" method="post" action="boSearch.bo">
	  <select name="search" id="search" onchange= "searchChange()">
	    <option value="title">title</option>
	    <option value="content">content</option>
	    <option value="nickName">nickName</option>
	  </select>
	  <input type="text" name="searchString" id="searchString"/>
	  <input type="button" id="searchButton" value="Search" onclick="searchCheck()" class="btn btn-primary"/>
	</form>
</div>
<!-- 검색기 처리 끝 -->

<p><br/></p>
<%@ include file="/include/footer.jsp" %>
</body>
</html>