<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>boUpdate.jsp</title>
  <%@ include file="/include/bs4.jsp" %>
  <script>
  // 게시글 수정
    function fCheck() {
    	var title = myForm.title.value;
    	var content = myForm.content.value;
    	
    	if(title.trim() == "") {
    		alert("게시글 제목을 입력하세요");
    		myForm.title.focus();
    	}
    	else if(content.trim() == "") {
    		alert("글내용을 입력하세요");
    		myForm.content.focus();
    	}
    	else {
    		myForm.submit();
    	}
    }
  </script>
</head>
<body>
<%@ include file="/include/header_home.jsp" %>
<jsp:include page="/include/nav.jsp"/>
<p><br></p>
<div class="container">
  <form name="myForm" method="post" action="boUpdateOk.bo">
	  <table class="table table-borderless">
	    <tr>
	      <td><h2>게시판 글 수정하기</h2></td>
	    </tr>
	  </table>
	  <table class="table">
	    <tr>
	      <th>작성자</th>
	      <td>${sNickName}</td>
	    </tr>
	    <tr>
	      <th>제목</th>
	      <td><input type="text" name="title" value="${vo.title}" class="form-control" autofocus required /></td>
	    </tr>
	    <tr>
	      <th>내용</th>
	      <td><textarea rows="6" name="content" class="form-control" required>${vo.content}</textarea></td>
	    </tr>
	    <tr>
	      <td colspan="2" class="text-center">
	        <input type="button" value="수정" onclick="fCheck()" class="btn btn-danger"/> &nbsp;
	        <input type="reset" value="다시 입력" class="btn btn-primary"/> &nbsp;
	        <input type="button" value="목록" onclick="location.href='${ctp}/boList.bo?pag=${pag}&pageSize=${pageSize}';" class="btn btn-primary"/>
	      </td>
	    </tr>
	  </table>
	  <input type="hidden" name="idx" value="${vo.idx}"/>
	  <input type="hidden" name="pag" value="${pag}"/>
	  <input type="hidden" name="pageSize" value="${pageSize}"/>
	  <input type="hidden" name="sw" value="${param.sw}"/>
  </form>
</div>
<br/>
<%@ include file="/include/footer.jsp" %>
</body>
</html>