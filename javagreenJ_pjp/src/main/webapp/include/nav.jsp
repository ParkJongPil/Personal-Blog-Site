<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
  String mid = session.getAttribute("sMid")==null? "" : (String) session.getAttribute("sMid"); 
%>

 
 
<!-- Navbar (sit on top) -->
<div class="w3-top">
 	<div class="w3-bar w3-white w3-wide w3-padding w3-card">
    <a href="<%=request.getContextPath()%>" class="w3-bar-item w3-button" ><b>Home</b></a>
    <c:if test="${sMid == null}">
    <a href="<%=request.getContextPath()%>/boListNoS.bo" class="w3-bar-item w3-button"><b>TimeLine</b></a>
    </c:if>
    <c:if test="${sMid != null}">
    <a href="<%=request.getContextPath()%>/boList.bo" class="w3-bar-item w3-button"><b>TimeLine</b></a>
    </c:if>
 
    <!-- Float links to the right. Hide them on small screens -->
    <div class="w3-right w3-hide-small">
    <c:if test="${empty sMid}">
      <a href="<%=request.getContextPath()%>/memLogin.mem" class="w3-bar-item w3-button"><b>Login</b></a>
    </c:if>
      <c:if test="${not empty sMid}">
      <div class="w3-dropdown-click">
		    <a href="javascript:myFunction()"  class="w3-bar- w3-button"><b>${sMid}</b>님 환영합니다.</a>
		    <div id="Demo" class="w3-dropdown-content w3-bar-block w3-border">
		      <a href="<%=request.getContextPath()%>/memMyPage.mem" class="w3-bar-item w3-button">My Page</a>
		      <c:if test="${sMid == 'admin'}">
		      <a href="<%=request.getContextPath()%>/adMenu.ad" class="w3-bar-item w3-button">Admin Page</a>
		      </c:if>
		      <a href="<%=request.getContextPath()%>/memList.mem" class="w3-bar-item w3-button">Member List</a>
		      <a href="<%=request.getContextPath()%>/memLogOut.mem" class="w3-bar-item w3-button"><font color="red">LogOut</font></a>
		    </div>
		  </div>
      </c:if>
    </div>
  </div>
</div>

<script>
	'use strict';
	function myFunction() {
	  var x = document.getElementById("Demo");
	  if (x.className.indexOf("w3-show") == -1) {
	    x.className += " w3-show";
	  } else { 
	    x.className = x.className.replace(" w3-show", "");
	  }
	}
	function memberDelCheck() {
		let ans = confirm("정말 탈퇴하시겠습니까?");
		if(ans) {
			ans = confirm("탈퇴 후 1개월간 같은 아이디로 재가입 하실 수 없습니다. \n 탈퇴 하시겠습니까?");
			if(ans) location.href="<%=request.getContextPath()%>/memDelete.mem";
		}
	}
</script>