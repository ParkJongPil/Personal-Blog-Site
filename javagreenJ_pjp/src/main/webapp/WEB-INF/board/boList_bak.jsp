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
 /*    function pageCheck() {
    	let pageSize = $("#pageSize").val();
    	location.href = "boList.bo?pag=${pag}&pageSize="+pageSize;
    	
    } */
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
  #pageSize {
	  height : 36px;
	  width : 60px;
  }
  #search {
	  height :28px;
  }
  #searchString {
	  height : 28px;
  }
  #searchButton {
	  height : 33px;
  }
  .btn {
		background-color:#FFD700;
		color:black;
	}
	.btn:hover {
		opacity: 0.8;
		cursor: pointer;
		color:white;
	}
 </style>
</head>
<body>
<%@ include file="/include/header_home.jsp" %>
<%@ include file="/include/nav.jsp" %>
<div class="container">
  <h2>이미지 게시판</h2>
  <br>
  <!-- Nav tabs -->
  <ul class="nav nav-tabs" role="tablist">
    <li class="nav-item">
      <a class="nav-link active" data-toggle="tab" href="#home">전체</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" data-toggle="tab" href="#menu1">팔로워</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" data-toggle="tab" href="#menu2">내글보기</a>
    </li>
  </ul>

  <!-- Tab panes -->
  <div class="tab-content"><br/>
   <a href="{ctp}/boInput.bo" class="btn">글쓰기</a>
  <div id="home" class="container tab-pane active"><br>
  <!--전체 글보기  -->
	<c:if test="${not empty vos}">
  <table class="table table-borderless table-hover" style="text-align:left;">
  <c:set var="cnt" value="0"/>
  <tr>
		<c:forEach var="vo" items="${vos}" varStatus="st">
		<c:set var="cnt" value="${cnt+1}"/>
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
   <c:if test="${cnt == 4}"></c:if>
	</tr>
	<tr>
		</c:forEach>
	  <c:set var="cnt" value="0"/>
	</tr>
	  </table>
		</c:if>    
	</div>
	<div class="text-center">
  <ul class="pagination justify-content-center">
	  <c:if test="${pag > 1}">
	   <li class="page-item"><a href="boList.bo?pag=1&pageSize=${pageSize}" class="page-link text-secondary">◀◀</a></li>
	  </c:if>
	  <c:if test="${curBlock > 0}">
	  	<li class="page-item"><a href="boList.bo?pag=${(curBlock-1)*blockSize + 1}&pageSize=${pageSize}"class="page-link text-secondary">◀</a></li>
	  </c:if>
	  <c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}">
	  <c:if test="${i <= totPage && i == pag}">
	    <li class="page-item active"><a href="boList.bo?pag=${i}&pageSize=${pageSize}" class="page-link text-light bg-secondary border-secondary"><b>${i}</b></a></li>
	  </c:if>
	  <c:if test="${i <= totPage && i != pag}">
	    <li class="page-item"><a href='boList.bo?pag=${i}&pageSize=${pageSize}' class="page-link text-secondary">${i}</a></li>
	  </c:if>
	  </c:forEach>
	  <c:if test="${curBlock < lastBlock}">
	    <li class="page-item"><a href="boList.bo?pag=${(curBlock+1)*blockSize + 1}&pageSize=${pageSize}" class="page-link text-secondary">▶</a></li>
	  </c:if>
	  <c:if test="${pag != totPage}">
			<li class="page-item"><a href="boList.bo?pag=${totPage}&pageSize=${pageSize}" class="page-link text-secondary">▶▶</a></li>
	  </c:if>
  </ul>
 </div>
	<!--팔로워 글보기  -->
  <div id="menu1" class="container tab-pane fade"><br>
   <c:if test="${not empty vos}">
	 <table class="table table-borderless table-hover" style="text-align:left;">
	 <c:set var="cnt" value="0"/>
	 <tr>
		<c:forEach var="vo" items="${follvos}" varStatus="st">
		<c:set var="cnt" value="${cnt+1}"/>
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
	 	<c:if test="${cnt == 4}"></c:if>
	 </tr>
	 <tr>
		</c:forEach>
	  <c:set var="cnt" value="0"/>
   </tr>
   </table>
	 </c:if>
   </div>
    <!-- 내 글보기 -->
  <c:if test="${sMid!=aMid}">
  <div id="menu2" class="container tab-pane fade"><br>
   <c:if test="${not empty vos}">
   <table class="table table-borderless table-hover" style="text-align:left;">
   <c:set var="cnt" value="0"/>
	 <tr>
		<c:forEach var="vo" items="${myvos}" varStatus="st">
		<c:set var="cnt" value="${cnt+1}"/>
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
		 <c:if test="${cnt == 4}"></c:if>
	 </tr>
	 <tr>
		</c:forEach>
	  <c:set var="cnt" value="0"/>
   </tr>
   </table>
	 </c:if>    
   </div>
   </c:if>
  </div>
</div>
<%--   <table class="table table-borderless">
    <tr>
      <td class="text-left p-0">
        <c:if test="${sMid=='admin'}">
	      	<a href="{ctp}/adNotice.ad" class="btn btn-danger">공지 작성</a>
	      </c:if>
	       <select name="pageSize" id="pageSize" onchange="pageCheck()"> 게시글 건수 보여주기
          <option value="5"  ${pageSize== 5  ? 'selected' : ''}>5건</option>
          <option value="10" ${pageSize== 10 ? 'selected' : ''}>10건</option>
          <option value="15" ${pageSize== 15 ? 'selected' : ''}>15건</option>
          <option value="20" ${pageSize== 20 ? 'selected' : ''}>20건</option>
        </select>
	    </td>
    </tr>
  </table> --%>
  <!-- 게시글 목록-->
	<%-- <c:if test="${not empty vos}">
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
	</c:if> --%>
<!-- 블록 페이징 처리 시작 -->
<div class="text-center">
  <ul class="pagination justify-content-center">
	  <c:if test="${pag > 1}">
	    <li class="page-item"><a href="boList.bo?pag=1&pageSize=${pageSize}" class="page-link text-secondary">◀◀</a></li>
	  </c:if>
	  <c:if test="${curBlock > 0}">
	  	<li class="page-item"><a href="boList.bo?pag=${(curBlock-1)*blockSize + 1}&pageSize=${pageSize}"class="page-link text-secondary">◀</a></li>
	  </c:if>
	  <c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}">
	  <c:if test="${i <= totPage && i == pag}">
	    <li class="page-item active"><a href="boList.bo?pag=${i}&pageSize=${pageSize}" class="page-link text-light bg-secondary border-secondary"><b>${i}</b></a></li>
	  </c:if>
	  <c:if test="${i <= totPage && i != pag}">
	    <li class="page-item"><a href='boList.bo?pag=${i}&pageSize=${pageSize}' class="page-link text-secondary">${i}</a></li>
	  </c:if>
	  </c:forEach>
	  <c:if test="${curBlock < lastBlock}">
	    <li class="page-item"><a href="boList.bo?pag=${(curBlock+1)*blockSize + 1}&pageSize=${pageSize}" class="page-link text-secondary">▶</a></li>
	  </c:if>
	  <c:if test="${pag != totPage}">
		<li class="page-item"><a href="boList.bo?pag=${totPage}&pageSize=${pageSize}" class="page-link text-secondary">▶▶</a></li>
	  </c:if>
  </ul>
 </div>
<!-- 블록 페이징 처리 끝 -->
<br/>
<!-- 검색기 처리 시작 -->
<div class="container text-center">
	<form name="searchForm" method="post" action="boSearch.bo">
	  <select name="search" id="search" onchange= "searchChange()">
	    <option value="title">제목</option>
	    <option value="content">내용</option>
	    <option value="nickName">작성자</option>
	  </select>
	  <input type="text" name="searchString" id="searchString"/>
	  <input type="button" id="searchButton" value="검색" onclick="searchCheck()" class="btn"/>
	  <input type="hidden" name="pag" value="${pag}"/>
	  <input type="hidden" name="pageSize" value="${pageSize}"/>
	</form>
</div>
<!-- 검색기 처리 끝 -->

<p><br/></p>
<%@ include file="/include/footer.jsp" %>
</body>
</html>