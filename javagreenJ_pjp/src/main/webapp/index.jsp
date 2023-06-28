<%@page import="board.BoardVO"%>
<%@page import="board.BoardDAO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<%
	//가장 최근순
	BoardDAO boardDao = new BoardDAO();
	BoardVO vo = new BoardVO();
	ArrayList<BoardVO> boardVos = boardDao.getBoList(0 , "");
	pageContext.setAttribute("boardVos", boardVos);
	
	//좋아요 높은순
	ArrayList<BoardVO> boardVos2 = boardDao.getBoList(1, "");
	pageContext.setAttribute("boardVos2", boardVos2);
	
	//댓글 높은순
	ArrayList<BoardVO> boardVos3 = boardDao.getBoList(2 ,"");
	pageContext.setAttribute("boardVos3", boardVos3);
	
	//조회 높은순
	ArrayList<BoardVO> boardVos4 = boardDao.getBoList(3 ,"");
	pageContext.setAttribute("boardVos4", boardVos4);
	
	//공지사항
	ArrayList<BoardVO> noticeVos = boardDao.getNoticeList(1);
	pageContext.setAttribute("noticeVos", noticeVos);
	
%>
<!DOCTYPE html>
<html>
<head>
<title>JSP 프로젝트(박종필)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Karma">
<style>
table,body,h1,h2,h3,h4,h5,h6 {font-family: "Karma", sans-serif}
.w3-bar-block .w3-bar-item {padding:20px}
	table{
		border-width:1px;
		border-top:1px soild #44444;
		border-collapse: separate;
		border-spacing: 0 30px;
		height:90%;
		
}
th,td {
	border-bottom :1px solid #4444;
	padding : 10px;
	text-align:left;
}
th:first-child, td:first-child {
	border-left:none;
}
.frame {
		width: 400px;
		height: 580px;
		float:left;
		margin-left:50px;
}
#frame1 {
	width:1400px;
	margin-bottom:30px;
	text-align:center;
	float:center;
}
.frame2 {
	text-align:center;
	float:left;
	width: 600px;
	height: 580px;
	margin-left:50px;
}
.txt {
	font-size:20px;
	font-weight:bold;
	text-align:center;
}
.txt1 {
	font-size:20px;
	font-weight:bold;
}
tr{
	bgcolor:"gray";
}
</style>

</head>
<body>
<%@ include file ="/include/nav.jsp"%>
<%@ include file ="/include/header_home.jsp"%>

<div class="w3-main w3-content w3-padding" style="max-width:1400px;margin-top:100px">
  <!-- 최근 작성된 게시글-->
  <div id="frame1">
  <div class="frame">
  <c:if test="${sMid == null}">
	<span class="txt"><a href="<%=request.getContextPath()%>/boListNoS.bo"><font color="blue">최근</font> 게시물 Top5 📋</a></span>
	</c:if>
	<c:if test="${sMid != null}">
	<span class="txt"><a href="<%=request.getContextPath()%>/boList.bo"><font color="blue">최근</font> 게시물 Top5 📋</a></span>
	</c:if>
  <table class="table table-borderd text-left" style="width:100%">
  	<tr class="text-white bg-primary" style="background-color:#EAEAEA;">
  		<th>제목</th>
  		<th>작성자</th>
  		<th style=text-align:center>작성일 🗓️</th>
  	</tr>
  		<c:if test="${sMid == null }">
	  		<c:forEach var="i" begin="0" end="4" >
	  		<tr>
		  		<td><a href="${ctp}/boListNoS.bo">${boardVos[i].title} <c:if test="${vo.wNdate <= 24}"><img src="images/new.gif"/></c:if></a>
		  		 </td>
		  		<td>${boardVos[i].nickName}</td>
		  		<td style=text-align:right>${fn:substring(boardVos[i].wDate,0,10)}</td>
	  		</tr>
	  		</c:forEach>
  		</c:if>
  		<c:if test="${sMid != null }">
	  		<c:forEach var="i" begin="0" end="4" >
	  		<tr>
		  		<td><a href="${ctp}/boContent.bo?idx=${boardVos[i].idx}">${boardVos[i].title} <c:if test="${vo.wNdate <= 24}"><img src="images/new.gif"/></c:if></a>
		  		 </td>
		  		<td>${boardVos[i].nickName}</td>
		  		<td style=text-align:right>${fn:substring(boardVos[i].wDate,0,10)}</td>
	  		</tr>
	  		</c:forEach>
  		</c:if>
  </table>
  </div>
  <!--좋아요가 높은순-->
  <div class="frame">
  <c:if test="${sMid == null}">
 <span class="txt"><a href="<%=request.getContextPath()%>/boListNoS.bo"><font color='blue'>좋아요</font> 높은 게시글 Top5 📋</a></span>
 </c:if>
 <c:if test="${sMid != null}">
 <span class="txt"><a href="<%=request.getContextPath()%>/boList.bo"><font color='blue'>좋아요</font> 높은 게시글 Top5 📋</a></span>
 </c:if>
  <table class="table table-borderd text-center " style="width:100%">
  	<tr class="text-white bg-primary" style="background-color:#EAEAEA;">
  		<th>제목</th>
  		<th>작성자</th>
  		<th style=text-align:right>좋아요 ❤️</th>
  	</tr>
  	<c:if test="${sMid == null}">
	  		<c:forEach var="i" begin="0" end="4">
	  		<tr>
		  		<td><a href="${ctp}/boListNoS.bo"> ${boardVos2[i].title}</a> </td>
		  		<td>${boardVos2[i].nickName}</td>
		  		<td style=text-align:center>${boardVos2[i].good}</td>
	  		</tr>
	  		</c:forEach>
  	</c:if>
  	<c:if test="${sMid != null}">
	  		<c:forEach var="i" begin="0" end="4">
	  		<tr>
		  		<td><a href="${ctp}/boContent.bo?idx=${boardVos2[i].idx}"> ${boardVos2[i].title}</a> </td>
		  		<td>${boardVos2[i].nickName}</td>
		  		<td style=text-align:center>${boardVos2[i].good}</td>
	  		</tr>
	  		</c:forEach>
  	</c:if>
  </table>
  </div>
  
  <!--댓글이 많은순  -->
  <div class="frame">
  <c:if test="${sMid == null}">
 <span class="txt"><a href="<%=request.getContextPath()%>/boListNoS.bo"><font color='blue'>댓글</font> 높은 게시글 Top5 📋</a></span>
 </c:if>
 <c:if test="${sMid != null}">
 <span class="txt"><a href="<%=request.getContextPath()%>/boList.bo"><font color='blue'>댓글</font> 높은 게시글 Top5 📋</a></span>
 </c:if>
  <table class="table table-borderd text-center" style="width:100%" >
  	<tr class="text-white bg-primary" style="background-color:#EAEAEA;">
  		<th>제목</th>
  		<th>작성자</th>
  		<th style=text-align:right>댓글 📧</th>
  	</tr>
  		<c:if test="${sMid == null}">
  		<c:forEach var="i" begin="0" end="4" >
  		<tr>
	  		<td> <a href="${ctp}/boListNoS.bo">${boardVos3[i].title}</a></td>
	  		<td>${boardVos3[i].nickName}</td>
	  		<td style=text-align:center>${boardVos3[i].replyCount}</td>
  		</tr>
  		</c:forEach>
  		</c:if>
  		<c:if test="${sMid!=null}">
  		<c:forEach var="i" begin="0" end="4" >
  		<tr>
	  		<td> <a href="${ctp}/boContent.bo?idx=${boardVos3[i].idx}">${boardVos3[i].title}</a></td>
	  		<td>${boardVos3[i].nickName}</td>
	  		<td style=text-align:center>${boardVos3[i].replyCount}</td>
  		</tr>
  		</c:forEach>
  		</c:if>
  </table><br/>
  </div>
 </div>
 
  <!--조회 많은순 -->
 <div class="frame2">
 <c:if test="${sMid==null}">
 <span class="txt1" style=text-align:center><a href="<%=request.getContextPath()%>/boListNoS.bo"><font color="blue">조회수</font> 높은 Top5 📋</a></span>
 </c:if>
 <c:if test="${sMid != null}">
 <span class="txt1" style=text-align:center><a href="<%=request.getContextPath()%>/boList.bo"><font color="blue">조회수</font> 높은 Top5 📋</a></span>
 </c:if>
  <table class="table table-borderd text-center" style="width:100%">
  	<tr class="text-white bg-primary" style="background-color:#EAEAEA;">
  		<th style=text-align:center>제목</th>
  		<th>작성자</th>
  		<th style=text-align:center>조회수 👁️</th>
  	</tr>
  		<c:if test="${sMid==null}">
	  		<c:forEach var="i" begin="0" end="4" >
	  		<tr>
		  		<td style=text-align:center> <a href="${ctp}/boListNoS.bo">${boardVos4[i].title}</a></td>
		  		<td>${boardVos4[i].nickName}</td>
		  		<td style=text-align:center>${boardVos4[i].readNum}</td>
	  		</tr>
	  		</c:forEach>
  		</c:if>
  		<c:if test="${sMid!=null}">
	  		<c:forEach var="i" begin="0" end="4" >
	  		<tr>
		  		<td style=text-align:center> <a href="${ctp}/boContent.bo?idx=${boardVos4[i].idx}">${boardVos4[i].title}</a></td>
		  		<td>${boardVos4[i].nickName}</td>
		  		<td style=text-align:center>${boardVos4[i].readNum}</td>
	  		</tr>
	  		</c:forEach>
  		</c:if>
  </table><br/>
  </div>
  
 <div class="frame2">
 <span class="txt1" style=text-align:center><font color="blue">공지사항</font> Top5 📋</span>
  <!--공지사항 -->
  <table class="table table-borderd text-center" style="width:100%">
  	<tr class="text-white bg-primary" style="background-color:#EAEAEA;">
  		<th style=text-align:center>제목</th>
  		<th>작성자</th>
  		<th style=text-align:center>작성일 🗓️</th>
  	</tr>
  		<c:if test="${sMid == null}">
	  		<c:forEach var="i" begin="0" end="4" >
	  		<tr>
		  		<td style=text-align:center> <a href="${ctp}/boListNoS.bo">${noticeVos[i].title}</a></td>
		  		<td>${noticeVos[i].nickName}</td>
		  		<td style=text-align:center>${fn:substring(noticeVos[i].wDate,0,10)}</td>
	  		</tr>
	  		</c:forEach>
  		</c:if>
  		<c:if test="${sMid!=null}">
	  		<c:forEach var="i" begin="0" end="4" >
	  		<tr>
		  		<td style=text-align:center> <a href="${ctp}/boContent.bo?idx=${noticeVos[i].idx}&sw=1">${noticeVos[i].title}</a></td>
		  		<td>${noticeVos[i].nickName}</td>
		  		<td style=text-align:center>${fn:substring(noticeVos[i].wDate,0,10)}</td>
	  		</tr>
	  		</c:forEach>
  		</c:if>
  </table><br/>
  </div>

  <!-- About Section -->
  <div class="w3-container w3-padding-32 w3-center">  
    <h3>About Me, The Food Man</h3><br>
    <img src="./images/chef.jpg" alt="Me" class="w3-image" style="display:block;margin:auto" width="800" height="533">
    <div class="w3-padding-32">
      <h4><b>I am Who I Am!</b></h4>
      <h6><i>With Passion For Real, Good Food</i></h6>
      <p>Just me, myself and I, exploring the universe of unknownment. I have a heart of love and an interest of lorem ipsum and mauris neque quam blog. I want to share my world with you. Praesent tincidunt sed tellus ut rutrum. Sed vitae justo condimentum, porta lectus vitae, ultricies congue gravida diam non fringilla. Praesent tincidunt sed tellus ut rutrum. Sed vitae justo condimentum, porta lectus vitae, ultricies congue gravida diam non fringilla.</p>
    </div>
  </div>
  <hr>
  
  <%@ include file ="/include/footer.jsp"%>
  
</div>

<script>
// Script to open and close sidebar
function w3_open() {
  document.getElementById("mySidebar").style.display = "block";
}
 
function w3_close() {
  document.getElementById("mySidebar").style.display = "none";
}
</script>
</body>
</html>
