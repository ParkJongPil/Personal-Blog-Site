<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<%
String msg = (String) request.getAttribute("msg");
String url = (String) request.getAttribute("url");
String mid = (String) request.getAttribute("mid");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>message.jsp</title>
<script>
	'use strict';
	
	let msg='<%=msg%>';
	let url='<%=url%>';
	let val ='${val}';
	let mid='<%=mid%>';
	
	if(msg =="loginJoinOk") msg="회원에 가입되었습니다.";
	else if(msg =="loginJoinNo") msg="회원가입 실패~~";
	else if(msg =="loginDeleteOk") msg="회원가입 성공~~";
	else if(msg =="loginDeleteNo") msg="회원 탈퇴 실패~~";
	else if(msg =="loginIdCheckNo") msg="중복 회원이 존재합니다.~~";
	else if(msg =="loginUpdateOk") msg="수정 완료~~";
	else if(msg =="loginUpdateNo") msg="수정 완료실패~~";
	else if(msg =="adminLogOutOk") msg="관리자 로그아웃 되었습니다.";
	else if(msg =="guestDeleteOk") msg="게시글이 삭제 되었습니다.";
	else if(msg =="guestDeleteNo") msg="게시글이 삭제 되지 않았습니다.";
	else if(msg =="memJoinOk") msg="회원에 가입되었습니다.";
	else if(msg =="memJoinNo") msg="회원가입 실패~";
	else if(msg =="idCheckNo") msg="아이디가 중복되었습니다.~";
	else if(msg =="nickCheckNo") msg="닉네임이 중복되었습니다.";
	else if(msg =="loginOk") msg='${sMid}'+"님 로그인 되었습니다.";
	else if(msg =="loginNo") msg= "로그인 실패!";
	else if(msg =="memLogOutOk") msg= val + "님 로그아웃 되셨습니다.";
	else if(msg == "findNo") msg="아이디를 찾을수 없습니다. 다시 한번 입력해 주세요!";
	else if(msg == "findOk") msg="아이디를 찾았습니다!";
	else if(msg == "findPwdNo")msg="계정을 찾지 못했습니다. 다시 입력해 주세요.";
	else if(msg == "findPwdOk")msg="계정을 찾았습니다. 비밀번호를 재설정하세요.";
	else if(msg == "levelChangeOk")msg="님 레벨이 변경되었습니다.";
	else if(msg == "memDeleteUpdateOk")msg="회원에서 탈퇴 되었습니다.";
	else if(msg == "memDeleteUpdateNo")msg="회원 탈퇴 실패~~";
	else if(msg == "userDeleteOk")msg="회원DB에서 삭제처리 시켰습니다.";
	else if(msg == "userDeleteNo")msg="회원DB에서 삭제처리 실패~~";
	else if(msg == "pwdUpdateOk")msg="패스워드가 변경 되었습니다. 다시 로그인 해주세요.";
	else if(msg == "pwdUpdateNo")msg="패스워드가 변경 실패!";
	else if(msg ==  "passwordNo")msg="비밀번호가 틀립니다. 확인해 주세요!";
	else if(msg ==  "passwordOk")msg="비밀번호가 변경되었습니다.";
	else if(msg ==  "memUpdateOk")msg="개인정보 수정 완료";
	else if(msg ==  "memUpdateNo")msg="개인정보 수정 실패";
	else if(msg ==  "boInputOk")msg="게시글이 등록되었습니다.";
	else if(msg ==  "boInputNo")msg="게시글이 등록 실패!";
	else if(msg ==  "memUpdatePwd")msg="비밀번호를 재설정합니다.";
	else if(msg ==  "memUpdatePwd2")msg="비밀번호가 변경되었습니다.";
	else if(msg ==  "boUpdateOk") msg= "게시글이 수정되었습니다!";
	else if(msg ==  "boUpdateNo") msg= "게시글이 수정 실패~~";
	else if(msg ==  "boDeleteOk") msg= "게시글이 삭제되었습니다!";
	else if(msg ==  "boDeleteNo") msg= "게시글이 삭제 실패~~\n댓글을 먼저 지워주세요!";
	else if(msg ==  "pwdSearchOk") msg= "비밀번호를 재설정 해주세요";
	else if(msg ==  "pwdSearchNo") msg= "유효한 정보가 없습니다. 다시입력해주세요";
	else if(msg ==  "adNoticeOk") msg= "공지사항이 등록되었습니다.";
	else if(msg ==  "adNoticeNo") msg= "공지사항 등록 실패~";
	else if(msg ==  "boListNoSOk") msg= "로그인 후 이용 가능합니다! 로그인 페이지로 이동합니다.";
	
	alert(msg);
	if(url != "") location.href=url;
	
	
</script>
</head>
<body>
</body>
</html>