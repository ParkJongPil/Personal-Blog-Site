<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>boContent.jsp</title>
	<%@ include file = "/include/bs4.jsp"%>
	<script>
	// 좋아요 처리
		function goodCheck() {
			$.ajax({
				type : "post",
				url : "${ctp}/boGoodCount",
				data : {idx : ${vo.idx}},
				success : function() {
					location.reload();
				},
				error : function() {
					alert("전송오류~");
				}
			});
		}
		// 게시글 삭제
		function boardDelCheck() {
			let ans = confirm("현재 게시물을 삭제하시겠습니까?");
			if(ans) {
				location.href="boDeleteOk.bo?idx=${vo.idx}&sw=${param.sw}";
			}
		}
		// 댓글 입력처리
		function replyCheck() {
			let content = $("#content").val();
			if(content.trim()=="") {
				alert("댓글을 입력하세요!");
				$("#content").focus();
				return false;
			}
			let query = {
					boardIdx :${vo.idx},
					mid : '${sMid}',
					nickName : '${sNickName}',
					content : content
			}
			$.ajax({
				type : "post",
				url : "${ctp}/boReplyInput",
				data : query,
				success : function(data) {
					if(data == "1"){
						alert("댓글이 입력되었습니다.");
						location.reload();
					}
					else {
						alert("댓글 입력 실패~");
					}
				},
				error : function() {
					alert("전송 오류~");
				}
			});
		}
		//댓글 삭제(ajax처리)
		function replyDelCheck(idx) {
			let ans = confirm("현재 댓글을 삭제하시겠습니까?");
			if(!ans) return false;
			
			$.ajax({
					type : "post",
					url : "${ctp}/boReplyDeleteOk",
					data : {idx : idx},
					success : function(data) {
						if(data =="1") {
							alert("댓글이 삭제되었습니다.");
							location.reload();
						}
						else {
							alert("댓글 삭제 실패~");
						}
					},
					error : function() {
						alert("전송 실패!!");
					}
			});
		}
		// 댓글 수정
		function boReplyUpdate(idx) {
			let content = $("#content").val();
			let query = {
						idx : idx,
						content : content
			}
			$.ajax({
				type : "post",
				url : "${ctp}/boReplyUpdateOk.bo",
				data : query,
				success : function(data) {
					if(data == "1"){
						alert("댓글이 수정되었습니다.");
						location.href="${ctp}/boContent.bo?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}";
					}
					else {
						alert("댓글 수정 실패!!");
					}
				},
					error : function() {
						alert("전송오류!!");
					}
			});
		}
	</script>
	 <style>
    th {
      background-color: #EAEAEA;
      text-align: center;
    }
  </style>
</head>
<body>
<%@ include file ="/include/nav.jsp"%>
<%@ include file ="/include/header_home.jsp"%>

<div class="w3-main w3-content w3-padding" style="max-width:1400px;margin-top:100px">
	<table class="table table-bordered">
	<thead>
		<tr>
			<th style=text-align:center colspan="2">게시글 보기</th>
		</tr>
	</thead>
		<tr>
			<th style="width:200px">글 제목</th>
			<td style=text-align:center>${vo.title}</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td style=text-align:center>${vo.nickName}</td>
		</tr>
		<tr>
			<th>작성일</th>
			<td style=text-align:center>${fn:substring(vo.wDate,0,19)}</td>	<!-- 2022.05.27 15:25:20.01  -->
		</tr>
		<c:if test="${sw==0}">
		<tr>
			<th>조회</th>
			<td style=text-align:center>${vo.readNum}</td>
		</tr>
		<tr>
			<th>좋아요</th>
			<td style=text-align:center><a href="javascript:goodCheck()">❤️</a>(${vo.good})</td>
		</tr>
		</c:if>
<!-- sw==1일때 -->
		<c:if test="${sw==1}"></c:if>
		<tr>
			<th>내용</th>
			<td style=text-align:center colspan="3" style="height:220px">${fn:replace(vo.content,newLine, "<br/>")}</td>
		</tr>
		<c:if test="${sw==0}">
		<tr>
			<th>이미지</th>
			<td style=text-align:center colspan="3" style="height:220px"><img src="${ctp}/data/board/${vo.fName}" style=height:500px; width=1000px/><br/>
			</td>
		</tr>
		</c:if>
		<c:if test="${sw==1}"></c:if>
		<tr>
			<td colspan="4" class="text-center">
			<c:if test="${sMid == vo.mid || sMid== 'admin'}">
					<input type="button" value="삭제" onclick ="boardDelCheck()" class="btn btn-danger"/>
					<input type="button" value="수정" onclick ="location.href='boUpdate.bo?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}&sw=${param.sw}';" class="btn btn-primary"/>
			</c:if>
				<c:if test="${flag == 's'}">
					<input type="button" value="목록" onclick ="location.href='boSearch.bo?pag=${pag}&pageSize=${pageSize}&search=${search}&searchString=${searchString}';" class="btn btn-primary"/>
				</c:if>
				<c:if test="${flag != 's'}">
					<input type="button" value="목록" onclick ="location.href='boList.bo?pag=${pag}&pageSize=${pageSize}';" class="btn btn-primary"/>
				</c:if>
				<c:if test="${sMid == vo.mid}">
				</c:if>
			</td>
		</tr>
	</table>
	
	<!--이전글, 다음글 처리  -->
	<table class="table table-borderless">
		<tr>
			<td>
				<c:if test="${nextVo.nextIdx != 0}">
					👆 <a href="boContent.bo?idx=${nextVo.nextIdx}&pag=${pag}&pageSize=${pageSize}">다음글 :${nextVo.nextTitle}</a><br/>
				</c:if>
				<c:if test="${nextVo.nextIdx != 0}">
					👇 <a href="boContent.bo?idx=${preVo.preIdx}&pag=${pag}&pageSize=${pageSize}">이전글 :${preVo.preTitle}</a><br/>
				</c:if>
			</td>
		</tr>
	</table>
 <br/>
 
  <c:if test="${sw==0}">
  <!--댓글 출력-->
 <table class="table table-hover text-center">
 	<tr>
 		<th>작성자</th>
 		<th style=text-align:center>댓글 내용</th>
 		<th style=text-align:center>작성일자</th>
 	</tr>
 	<c:forEach var="replyVo" items="${replyVos}">
 		<tr class="text-center">
 			<td>
 			${replyVo.nickName}
 			<c:if test="${sMid==replyVo.mid || sMid =='admin'}">
 				(<a href="boContent.bo?replyIdx=${replyVo.idx}&idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}">⚙️</a>,
 				<a href="javascript:replyDelCheck(${replyVo.idx})">✂️</a>)
 			</c:if>
 			</td>
 			<td>
 			${fn:replace(replyVo.content,newLine,"<br/>")}
 			</td>
 			<td>
 			<c:if test="${replyVo.wNdate <=24}">${fn:substring(replyVo.wDate,11,19)}</c:if>
 			<c:if test="${replyVo.wNdate > 24}">${fn:substring(replyVo.wDate,0,10)}</c:if>
 			</td>
 		</tr>
 	</c:forEach>
 </table>
 <!--댓글 입력 -->
 <form name="replyForm" method="post" action="boReplyInput.bo">
 	<table class="table text-center">
 		<tr>
 			<td style="width:85%" class="text-left">
 				댓글 내용 :
 				<textarea rows="4" name="content" id="content" class="form-control">${replyContent}</textarea>
 			</td>
 			<td style="width:15%">
 				<br/>
 				<p>작성자 : ${sNickName}</p>
 				<p>
 					<c:if test="${empty replyContent}"><input type="button" value="댓글 작성" onclick="replyCheck()" class="btn btn-primary"/></c:if>
 					<c:if test="${!empty replyContent}"><input type="button" value="댓글 수정" onclick="boReplyUpdate(${replyIdx})" class="btn btn-danger"/></c:if>
 				</p>
 			</td>
 		</tr>
 	</table>
 	 <input type="hidden" name="boardIdx" value="${vo.idx}"/>
 	 <input type="hidden" name="mid" value="${sMid}"/>
 	 <input type="hidden" name="nickName" value="${sNickName}"/>
 	 <input type="hidden" name="sw" value="${param.sw}"/>
 </form>
 </c:if>
  <c:if test="${sw==1}"></c:if>
</div>
<hr>
<%@ include file ="/include/footer.jsp"%>
</body>
</html>