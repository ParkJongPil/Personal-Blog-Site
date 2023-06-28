<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>memInforHomePage.jsp</title>
	<%@ include file = "/include/bs4.jsp"%>
	<script>
	'use strict';
	function fCheck() {
		let bMid = '${vo.mid}';
		// let idx = ${vo.idx};
		$.ajax({
			type : "post",
			url : "${ctp}/memInforHomepage",
			data : {
				// idx : idx,
				bMid : bMid
				},
			success : function(res) {
				if(res=='1') {
					alert('팔로우가 신청 되었습니다.');
					location.reload();
				}
				else {
					alert('팔로우가 이미 신청되어 있습니다.');
				}
			},
			error : function() {
				alert("전송오류~");
			}
		});
	}
	</script>
	<style>
body {
  font-family: Arial, Helvetica, sans-serif;
}

.flip-card {
  background-color: transparent;
  width: 300px;
  height: 300px;
  perspective: 1000px;
}

.flip-card-inner {
  position: relative;
  width: 100%;
  height: 100%;
  text-align: center;
  transition: transform 0.6s;
  transform-style: preserve-3d;
  box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
}

.flip-card:hover .flip-card-inner {
  transform: rotateY(180deg);
}

.flip-card-front, .flip-card-back {
  position: absolute;
  width: 100%;
  height: 100%;
  -webkit-backface-visibility: hidden;
  backface-visibility: hidden;
}

.flip-card-front {
  background-color: #bbb;
  color: black;
}

.flip-card-back {
  background-color: white;
  color: blue;
  transform: rotateY(180deg);
}
td {
	text-align:center;
}
.text{
	text-algin:center;
}
.btn{
	text-align:center;
}
</style>
</head>
<body>
<%@ include file ="/include/nav.jsp"%>
<%@ include file ="/include/header_home.jsp"%>

<div class="w3-main w3-content w3-padding" style="max-width:1400px;margin-top:100px; display:flex; justify-content: space-evenly; flex-direction: column; align-items: center">
<div class="flip-card">
  <div class="flip-card-inner">
    <div class="flip-card-front">
     <c:if test="${vo.gender=='남자'}"><img src="./images/img_avatar.png" alt="Avatar" style="width:300px;height:300px;"></c:if>
     <c:if test="${vo.gender=='여자'}"><img src="./images/img_avatar2.png" alt="Avatar" style="width:300px;height:300px;"></c:if>
    </div>
    <div class="flip-card-back">
     	<h3 class="text">회원 정보 상세보기</h3>
	<br/>
	<table class="table table-hover text-left ">
			<tr>
			<th><font color= black>닉네임 : </font></th>
			<td><b>${vo.nickName}</b></td>
			</tr>
			<tr>
			<th><font color= black>아이디 : </font></th>
			<td>${vo.mid}</td>
			</tr>
			<tr>
			<th><font color= black>이메일 : </font></th>
			<td>${vo.email}</td>
			</tr>
			<tr>
			<th><font color= black> 성별 : </font></th>
			<td>${vo.gender}</td>
			</tr>
			<tr>
			<th><font color= black> 취미  : </font></th>
			<td>${vo.hobby}</td>
			</tr>
			<tr>
			<tr><td colspan="5"></td></tr>
	</table>
    </div>
  </div>
</div><br/><br/>

	<div class="btn">
		<c:if test="${sMid != vo.mid}">
		<input type="button" value="팔로잉" onclick="fCheck()" class="btn btn-primary"/>&nbsp; &nbsp;
		</c:if>
		<input type="button" value="돌아가기" onclick="history.back()" class="btn btn-danger"/>
	</div>
</div>
<%@ include file ="/include/footer.jsp"%>
</body>
</html> 