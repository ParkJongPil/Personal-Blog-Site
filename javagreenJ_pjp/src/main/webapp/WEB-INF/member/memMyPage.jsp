<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>memMain.jsp</title>
	<%@ include file = "/include/bs4.jsp"%>
	<script>
	'use strict';
	function memberDelCheck() {
		let ans = confirm("정말 탈퇴하시겠습니까?");
		if(ans) {
			ans = confirm("탈퇴 후 1개월간 같은 아이디로 재가입 하실 수 없습니다. \n 탈퇴 하시겠습니까?");
			if(ans) location.href="<%=request.getContextPath()%>/memDelete.mem";
		}
	}
	</script>
	
	<style>
	.box	{
		text-align:center;
	}
	table {
		border-collapse: separate;
		border-spacing: 0 20px;
		width : 300px;
	}
	td {
		text-align : right;
	}
	.card {
  box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
  transition: 0.3s;
  width: 40%;
  position: relative;
  display: -ms-flexbox;
  display: flex;
  -ms-flex-direction: column;
  flex-direction: column;
  min-width: 0;
  word-wrap: break-word;
  background-color: #fff;
  background-clip: border-box;
  border: 1pxsolidrgba(0,0,0,.125);
  border-radius: 0.25rem;
}
.card:hover {
  box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2);
}

.container {
  padding: 2px 16px;
}
body {
    font-family: Verdana,sans-serif;
    font-size: 15px;
    line-height: 1.5;
}
</style>
</head>
<body>
<%@ include file ="/include/nav.jsp"%>
<%@ include file ="/include/header_home.jsp"%>
<div class="w3-main w3-content w3-padding" style="max-width:1300px; margin-top: auto; margin-left: auto; margin-right:auto; display:flex; align-items: center; flex-direction: column;">
	<h3><b>My Page</b></h3><br/>

<div class="card">
  <c:if test="${vo.gender == '남자'}"><img src="./images/img_avatar.png" alt="Avatar" style="width:100%"></c:if>
  <c:if test="${vo.gender == '여자'}"><img src="./images/img_avatar2.png" alt="Avatar" style="width:100%"></c:if>
  
  <div class="container" style="margin-left:auto; text-align:center">
   	<div class="box"><br/>
				 팔로잉 : <a href="<%=request.getContextPath()%>/memFollow.mem"><b><font color='blue'>${aMidCnt}</font></b></a> &nbsp;
			   팔로워 : <a href="<%=request.getContextPath()%>/memFollower.mem"><b><font color='blue'>${bMidCnt}</font></b></a>
		</div>
		<table style="width: 100%">
	
	 <tr>
		 	<th><a href="<%=request.getContextPath()%>/memUpdate.mem">회원정보 변경</a></th>
	 </tr>
	 <tr>
		 	<th><a href="<%=request.getContextPath()%>/memUpdatePwd.mem">비밀번호 변경</a></th>
	 </tr>
	 <tr>
		 	<th><a href="javascript:memberDelCheck()">회원 탈퇴 신청</a></th>
	 </tr>
	</table><br/>
		<input type="reset" value="돌아가기" onclick=history.back() style=text-align:center class="btn btn-danger"/>
	</div>
 </div>
</div>
<%@ include file ="/include/footer.jsp"%>
</body>
</html>