<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>boInput.jsp</title>
	<%@ include file = "/include/bs4.jsp"%>
	<script>
	'use strict';
	function fCheck() {
		var title = myForm.title.value;
		var content = myForm.content.value;
		var fName = myForm.fName.value;
		
		if(title.trim()=="") {
			alert("게시글 제목을 입력하세요.");
			myForm.title.focus();
		}
		else if(content.trim()=="") {
			alert("내용을 입력하세요.");
			myForm.content.focus();
		}
		else if(fName.trim()=="") {
			alert("사진을 첨부하세요.");
			myForm.fName.focus();
		}
		else {
			myForm.submit();
		}
	}
	
	let cnt = 1;
	
	  function fileAppend() {
	  	cnt++;
	  	let fileBox = "";
	  	fileBox += '<div id="fBox'+cnt+'" class="form-group">';
	  	fileBox += '<input type="file" name="fName'+cnt+'" id="fName'+cnt+'" class="form-control-file border" style="width:85%;float:left;"/>';
	  	fileBox += '<input type="button" value="삭제" onclick="deleteBox('+cnt+')" class="btn btn-danger form-control ml-2" style="width:10%"/>';
	  	fileBox += '</div>';
	  	$("#fileInsert").append(fileBox);
	  }
	</script>
</head>
<body>
<%@ include file ="/include/nav.jsp"%>
<%@ include file ="/include/header_home.jsp"%>
<div class="w3-main w3-content w3-padding" style="max-width:1400px;margin-top:100px">
 <form name ="myForm" method="post" action="${ctp}/boInputOk.bo" enctype="multipart/form-data">
 	<table class="table table-borderless">
 		<tr>
 			<td><h2>글쓰기</h2></td>
 		</tr>
 	</table>
 	<table class="table">
 		<tr>
 			<th>작성자</th>
 			<td>${sNickName}</td>
 		</tr>
 		<tr>
 			<th>제목</th>
 			<td><input type="text" name="title" placeholder="제목을 입력하세요" class="form-control" autofocus required/></td>
 		</tr>
 		<tr>
 			<th>내용</th>
 			<td><textarea rows="6" name="content" class="form-control" required></textarea></td>
 		</tr>
 		<tr>
 			<td colspan="2">
	      <input type="button" value="파일 추가" onclick="fileAppend()" class="btn btn-primary mb-1"/>
	      <input type="file" name="fName" id="fName" class="form-control-file border" accept=".jpg,.gif,.png,.zip,.ppt,.pptx,.hwp"/>
      </td>
    </tr>
 		<tr>
 			<td colspan="2" class="text-center">
 				<input type="button" value="작성 완료" onclick="fCheck()" class="btn btn-primary"/>&nbsp;
 				<input type="reset"  value="다시 입력" class="btn btn-primary"/> &nbsp;
 				<input type="button" value="돌아가기"  onclick="location.href='${ctp}/boList.bo';" class="btn btn-danger"/>
 			</td>
 		</tr>
 	</table>
 </form>
</div>
<hr/>
<%-- <%@ include file ="/include/footer.jsp"%> --%>
</body>
</html>