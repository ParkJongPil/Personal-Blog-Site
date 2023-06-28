<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memJoin.jsp</title>
  <%@ include file="/include/bs4.jsp" %>
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="${ctp}/js/woo.js"></script>
  <script>
  	'use strict';
  	let idCheckSw = 0;
  	let nickCheckSw = 0;
  	
    // 회원가입폼 체크 후 서버로 전송하기
    function fCheck() {
    	let regMid = /^[a-z0-9_]{4,20}$/;
      let regPwd = /(?=.*[a-zA-Z])(?=.*?[#?!@$%^&*-]).{4,24}/;
      let regNickName = /^[가-힣]+$/;
      let regName = /^[가-힣a-zA-Z]+$/;
      let regEmail =/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
      let regTel = /\d{2,3}-\d{3,4}-\d{4}$/g;
      
      let submitFlag = 0;		// 전송체크버튼으로 값이 1이면 체크완료되어 전송처리한다.
    	
    	let mid = myForm.mid.value;
    	let pwd = myForm.pwd.value;
    	let nickName = myForm.nickName.value;
    	let name = myForm.name.value;
    	let email1 = myForm.email1.value;
    	let email2 = myForm.email2.value;
      let email = email1 + '@' + email2;
      let tel1 = myForm.tel1.value;
      let tel2 = myForm.tel2.value;
      let tel3 = myForm.tel3.value;
      let tel = myForm.tel1.value + "-" + myForm.tel2.value + "-" + myForm.tel3.value;
    	
    	// 사진 업로드 체크
    	let fName = myForm.fName.value;
    	let ext = fName.substring(fName.lastIndexOf(".")+1);	// 파일 확장자 발췌
    	let uExt = ext.toUpperCase();		// 확장자를 대문자로 변환
    	let maxSize = 1024 * 1024 * 2; 	// 업로드할 회원사진의 용량은 2MByte까지로 제한한다.
    	
    	// 기타 추가로 체크해야 할 항목들을 모두 체크하세요.....
    	if(!regMid.test(mid)) {
        alert("아이디는 영문 소문자와 숫자, 언더바(_)만 사용가능합니다.(길이는 4~20자리까지 허용)");
        myForm.mid.focus();
        return false;
      }
      else if(!regPwd.test(pwd)) {
        alert("비밀번호는 1개이상의 문자와 특수문자 조합의 6~24 자리로 작성해주세요.");
        myForm.pwd.focus();
        return false;
      }
      else if(!regNickName.test(nickName)) {
        alert("닉네임은 한글만 사용가능합니다.");
        myForm.nickName.focus();
        return false;
      }
      else if(!regName.test(name)) {
        alert("성명은 한글과 영문대소문자만 사용가능합니다.");
        myForm.name.focus();
        return false;
      }
      else if(!regEmail.test(email)) {
        alert("이메일 형식에 맞지않습니다.");
        myForm.email1.focus();
        return false;
      }
    	
      if(tel2 != "" || tel3 != "") {	// 전화번호 입력 시 체크!
      	if(!regTel.test(tel)) {
	        alert("전화번호 형식에 맞지않습니다.(000-0000-0000)");
	        myForm.tel2.focus();
	        return false;
	      }
	      else {
	    	  submitFlag = 1;
	      }
      }
      
      // 전화번호 입력하지 않았을 경우
      if(tel2 =="" && tel3 =="") {
    	  tel2 = " ";
    	  tel3 = " ";
    	  tel= tel1 + "-" + tel2 + "-" + tel3;
    	  submitFlag = 1;
      }
      
  		// 전송전에 '주소'를 하나로 묶어서 전송처리 준비한다.
  		let postcode = myForm.postcode.value + " ";
  		let roadAddress = myForm.roadAddress.value + " ";
  		let detailAddress = myForm.detailAddress.value + " ";
  		let extraAddress = myForm.extraAddress.value + " ";
  		myForm.address.value = postcode + "/" + roadAddress + "/" + detailAddress + "/" + extraAddress + "/";
  		
  		// 전송전에 파일에 관한 사항체크...
  		if(fName.trim() == "") {
  			myForm.photo.value = "noimage"
			submitFlag = 1;
  		}
  		else {
  			let fileSize = document.getElementById("file").files[0].size;
  			
  			if(uExt != "JPG" && uExt != "GIF" && uExt != "PNG") {
  				alert("업로드 가능한 파일은 'JPG/GIF/PNG'파일 입니다.");
  				return false;
  			}
  			else if(fName.indexOf(" ") != -1) {
  				alert("업로드 파일명에 공백을 포함할 수 없습니다.");
  				return false;
  			}
  			else if(fileSize > maxSize) {
  				alert("업로드 파일의 크기는 2MByte를 초과할수 없습니다.");
  				return false;
  			}
    		submitFlag = 1;
    	}
    	
  		// 전송전에 모든 체크가 끝나서 submitFlag가 1이되면 서버로 전송한다.
    	if(submitFlag == 1) {
    		if(idCheckSw == 0) {
    			alert("아이디 중복체크버튼을 눌러주세요!");
    		}
    		else if(nickCheckSw == 0) {
    			alert("닉네임 중복체크버튼을 눌러주세요!");
    		}
    		else {
	  			// 묶여진 필드(email/tel)를 폼태그안에 hidden태그의 값으로 저장시켜준다.
	  			myForm.email.value = email;
	  			myForm.tel.value = tel;
	  			
	  			myForm.submit();
    		}
    	}
    	else {
    		alert("회원가입 실패~~");
    	}
    }
    
    // ID 중복체크
    function idCheck() {
    	document.getElementById('mid').readOnly = true;
    	let mid = myForm.mid.value;
    	let url = "${ctp}/memIdCheck.mem?mid="+mid;
    	
    	if(mid == "") {
    		alert("아이디를 입력하세요!");
    		myForm.mid.focus();
    	}
    	else {
    		idCheckSw = 1;
    		window.open(url,"nWin","width=580px,height=250px");
    	}
    }
    
    // nickName 중복체크
    function nickCheck() {
    	document.getElementById('nickName').readOnly = true;
    	let nickName = myForm.nickName.value;
    	let url = "${ctp}/memNickCheck.mem?nickName="+nickName;
    	
    	if(nickName == "") {
    		alert("닉네임을 입력하세요!");
    		myForm.nickName.focus();
    	}
    	else {
    		nickCheckSw = 1;
    		window.open(url,"nWin","width=580px,height=250px");
    	}
    }
  </script>
  <style>
  .mainBody{
		width: 600px;
		height: 1300px;
		border: 10px;
		border-color: gray;
		border-radius: 10px;
		border-style: solid;	
		margin-left: 400px;
		margin-top:100px;
		padding: 50px;
	}
	.modal-content {
		border : 0px;
		margin-top:-40px;
		margin-bottom:100px;
	}
  </style>
</head>
<body>
<%@ include file="/include/header_home.jsp" %>
<%@ include file="/include/nav.jsp" %>
<div class="w3-main w3-content w3-padding" style="max-width:1400px;margin-top:10px">
  <form name="myForm" method="post" action="${ctp}/memJoinOk.mem" class="was-validated">
  	<div class="mainBody">
    <div class="modal-dialog">
    	<div class="modal-content">
    <div class="form-group">
    <div><h2 style="text-align:center">회원가입</h2></div>
    <br/>
      <label for="mid">아이디 <font color="red">*</font> &nbsp; &nbsp;<input type="button" value="아이디 중복체크" class="btn btn-primary btn-sm" onclick="idCheck()" ></label>
      <input type="text" class="form-control" name="mid" id="mid" placeholder="아이디를 입력하세요."required autofocus/>
    </div>
    <div class="form-group">
      <label for="pwd">비밀번호 <font color="red">*</font></label>
      <input type="password" class="form-control" id="pwd" placeholder="비밀번호를 입력하세요." name="pwd" required />
    </div>
    <div class="form-group">
      <label for="nickName">닉네임 <font color="red">*</font> &nbsp; &nbsp;<input type="button" value="닉네임 중복체크" class="btn btn-primary btn-sm" onclick="nickCheck()"/></label>
      <input type="text" class="form-control" id="nickName" placeholder="닉네임명을 입력하세요." name="nickName" required />
    </div>
    <div class="form-group">
      <label for="name">성명 <font color="red">*</font></label>
      <input type="text" class="form-control" id="name" placeholder="성명을 입력하세요." name="name" required />
    </div>
    <div class="form-group">
      <label for="email1">이메일 주소 <font color="red">*</font></label>
				<div class="input-group mb-3">
				  <input type="email" class="form-control" placeholder="이메일을 입력하세요." id="email1" name="email1" required />
				  <div class="input-group-append">
				    <select name="email2" class="custom-select">
					    <option value="naver.com" selected>naver.com</option>
					    <option value="hanmail.net">hanmail.net</option>
					    <option value="hotmail.com">hotmail.com</option>
					    <option value="gmail.com">gmail.com</option>
					    <option value="nate.com">nate.com</option>
					    <option value="yahoo.com">yahoo.com</option>
					  </select>
				  </div>
				</div>
	  </div>
    <div class="form-group">
      <div class="form-check-inline">
        <span class="input-group-text">성별 :</span> &nbsp; &nbsp;
			  <label class="form-check-label">
			    <input type="radio" class="form-check-input" name="gender" value="남자" checked>남자
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="radio" class="form-check-input" name="gender" value="여자">여자
			  </label>
			</div>
    </div>
    <div class="form-group">
      <label for="birthday">생일</label>
      <c:set var="now" value="<%=new java.util.Date() %>"/>
      <fmt:formatDate var="birthday" value="${now}" pattern="yyyy-MM-dd"/>
			<input type="date" name="birthday" value="${birthday}" class="form-control"/>
    </div>
    <div class="form-group">
      <div class="input-group mb-3">
	      <div class="input-group-prepend">
	        <span class="input-group-text">전화번호 :</span> &nbsp;&nbsp;
			      <select name="tel1" class="custom-select">
					    <option value="010" selected>010</option>
					    <option value="02">서울</option>
					    <option value="031">경기</option>
					    <option value="032">인천</option>
					    <option value="041">충남</option>
					    <option value="042">대전</option>
					    <option value="043">충북</option>
			        <option value="051">부산</option>
			        <option value="052">울산</option>
			        <option value="061">전북</option>
			        <option value="062">광주</option>
					  </select>-
	      </div>	
	      <input type="text" name="tel2" size=4 maxlength=4 class="form-control"/>-
	      <input type="text" name="tel3" size=4 maxlength=4 class="form-control"/>
	    </div> 
    </div>
    <div class="form-group">
      <label for="address">주소</label>
			<input type="hidden" name="address" id="address">
			<div class="input-group mb-1">
				<input type="text" name="postcode" id="sample6_postcode" placeholder="우편번호" class="form-control">
				<div class="input-group-append">
					<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn1">
				</div>
			</div>
			<input type="text" name="roadAddress" id="sample6_address" size="50" placeholder="주소" class="form-control mb-1">
			<div class="input-group mb-1">
				<input type="text" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소" class="form-control"> &nbsp;&nbsp;
				<div class="input-group-append">
					<input type="text" name="extraAddress" id="sample6_extraAddress" placeholder="참고항목" class="form-control">
				</div>
			</div>
    </div>
    <div class="form-group">
      <div class="form-check-inline">
        <span class="input-group-text">취미</span> &nbsp; &nbsp;
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" value="등산" name="hobby"/>등산
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" value="볼링" name="hobby"/>볼링
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" value="독서" name="hobby"/>독서
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" value="영화감상" name="hobby"/>영화감상
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" value="수영" name="hobby"/>수영
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" value="기타" name="hobby" checked/>기타
			  </label>
			</div>
    </div>
    <div class="form-group">
      <div class="form-check-inline">
        <span class="input-group-text">정보공개</span>  &nbsp; &nbsp; 
			  <label class="form-check-label">
			    <input type="radio" class="form-check-input" name="userInfor" value="공개" checked/>공개
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="radio" class="form-check-input" name="userInfor" value="비공개"/>비공개
			  </label>
			</div>
    </div>
    <div  class="form-group">
      회원 사진 (파일용량 : 2MByte이내)
      <input type="file" name="fName" id="file" class="form-control-file border"/>
    </div>
    <button type="button" class="btn btn-primary" onclick="fCheck()">회원가입</button> &nbsp;
    <button type="reset"  class="btn btn-primary">다시 작성</button> &nbsp;
    <button type="button" class="btn btn-danger" onclick="location.href='${ctp}/memLogin.mem';">돌아가기</button>
    <input type="hidden" name="photo"/>
    <input type="hidden" name="email"/>
    <input type="hidden" name="tel"/>
  </div>
  </div>
  </div>
  </form>
  <p><br/></p>
</div>
<br/>
</body>
</html>