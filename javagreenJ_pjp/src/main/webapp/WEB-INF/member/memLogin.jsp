<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	
	<title>memLogin.jsp</title>
	<%@ include file = "/include/bs4.jsp"%>
	<script>
		function fCheck() {
			myForm.submit();
		}
	</script>
<style>
.modal-content{
	border:0px;
}
.col2{
	text-align:right;
	width:200px;
	margin-right:20px;
}
</style>
</head>
<body>
<%@ include file ="/include/nav.jsp"%>
<%@ include file ="/include/header_home.jsp"%>

<div class="w3-main w3-content w3-padding" style="max-width:1400px;margin:100px auto">
	<div class="modal-dialog">
	  <div class="modal-content">
		  <div class="container ">
			<form name="myForm" method="post" action="${ctp}/memLoginOk.mem" class="was-validated" style="height:350px">
				<div class="w-3 container" style="text-align:center"><h2>로그인</h2></div><br/>
				<div class="form-group">
					<input  type="text" class="form-control" name="mid" id="mid" value="${mid}" placeholder="아이디" required autofocus/>
					<div class="valid-feedback">입력성공</div>
					<div class="invalid-feedback">아이디는 필수 입력사항입니다.</div>
				</div>
				<div class="form-group">
					<input type="password" class="form-control" name="pwd" id="pwd" placeholder="비밀번호" required/>
					<div class="invalid-feedback">비밀번호는 필수 입력사항입니다.</div>
				</div>
				<div class="form-group">
					<button type="submit" class="btn btn-primary" style="width:466px">로그인</button>&nbsp;&nbsp;&nbsp;
					<button type="reset" class="btn btn-danger btn-sm" style="width:466px">취소</button>&nbsp; &nbsp;
				</div>
				<div class="row" style="font-size:12px">
					<span class="col"><input type="checkbox" name="idCheck" checked/> 🔒 아이디 저장</span>
					<span class="col2"><a href="{ctp}/memFindId.mem"><b>아이디</b></a> | <a href="{ctp}/memFindPwd.mem"><b>비밀번호 찾기</b></a> | <a href="{ctp}/memJoin.mem"><b>회원가입</b></a></span>
				</div>
			</form>
			</div>
		</div>
 </div>			
</div>
<hr>
<%@ include file="/include/footer.jsp" %>

</body>
</html>