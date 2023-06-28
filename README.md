# 개인 블로그 사이트

<hr/>
<h2>링크 주소</h2>

구현 링크 : https://youtu.be/Y19Zrg1eSSg

<h2>1. 구현 목표 </h2>
  <li>사람들끼리 소통할 수 있는 공간을 직접 제작하고 싶단 생각을 하였고, 
  실제로 티스토리 블로그를 관리하고 있어 관심을 갖고 제작하게 되었습니다.</li>

<h2>2. 개발 일정 </h2>
  <li>2022.05.23 ~ 2022.06.02</li>
  
<h2>3. 개발환경</h2>

개발언어 : JAVA(1.8) <br/> 
프로그램 : Eclipse <br/>
서버 :  Apache Tomcat 9.0 <br/>
데이터베이스 : Mysql 5.1.49 / HediSql 9.5 / Mybatis <br/>
기타 : JSP / HTML5 / CSS3 / JavaScript / Ajax / Jquery <br/>

<h2>4. DB설계</h2>

![image](https://github.com/ParkJongPil/Personal-Blog-Site/assets/102267949/e8daf36b-0514-4063-8545-70ef2cc6b267)

![image](https://github.com/ParkJongPil/Personal-Blog-Site/assets/102267949/ca8f02d8-9ff0-4f72-933e-4eacf13b9b2d)

![image](https://github.com/ParkJongPil/Personal-Blog-Site/assets/102267949/73555bd3-9baa-49d3-ac75-2eed9b33ef45)

<h2>5. 주요 화면 구현</h2>

![image](https://github.com/ParkJongPil/Personal-Blog-Site/assets/102267949/e5af2eca-5338-42dd-8493-a3a8daf19375)

![image](https://github.com/ParkJongPil/Personal-Blog-Site/assets/102267949/f98ff500-8800-4aa8-b362-d3ddeab7f78b)

![image](https://github.com/ParkJongPil/Personal-Blog-Site/assets/102267949/ddd19c3d-766c-4f3b-84ee-8eb7591e787d)

<h2>화면 구현 상세 리스트</h2>

1. 로그인 구현 

2. 회원가입
- 아이디는 영문 소문자와 숫자, 언더바(_)만 사용가능 (길이는 4~20자리까지 허용)
- 아이디 중복 체크 / Read Only 처리
- 비밀번호는 1개이상의 문자와 특수문자 조합의 6~24 자리로 작성
- 닉네임 중복 체크 / Read Only 처리

3. 아이디 / 비밀번호 찾기 

4. 마이페이지
- 비밀번호 변경
- 정보 수정
- 회원탈퇴 신청

5. 공지사항
- 수정
- 삭제

6. 이미지 게시판
- 작성
- 수정
- 삭제
- 상세보기
- 게시글 목록
- 게시글 검색
- 이전글 / 다음글

7.  댓글
- 작성
- 수정
- 삭제

8. 홈 화면
- 최근 게시글 5개
- 조회수 높은순 5개
- 댓글 높은순 5개
- 좋아요 높은순 5개
- 공지사항 보기 5개

9. 관리자 메뉴
-탈퇴 회원 만료 처리
-공지사항 등록

10. 팔로우
- 팔로잉 신청
- 팔로잉, 팔로워 리스트
- 팔로우한 게시글
- 내가 쓴 게시글 보기
