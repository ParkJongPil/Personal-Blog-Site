show tables;

create table member(
	idx 			int not null auto_increment,					/* 회원 고유번호 */
	mid 			varchar(20) not null,									/* 아이디 */
	pwd 			varchar(100) not null,								/* 비밀번호 */
	nickName 	varchar(20) not null,									/* 중복 불가능 */
	name 		  varchar(20) not null,									/* 성명 */
	email 		varchar(50) not null,									/* 이메일(아이디, 비밀번호 분실 시 필요)*/
	gender 		varchar(10) default '남자',							/* 성별 */
	birthday 	datetime default now(),								/* 생일 */
	tel 			varchar(15),													/* 전화번호 */
	address 	varchar(100),													/* 주소 */
	hobby 		varchar(60),													/* 취미 */
	userInfor char(6) default '공개',									/* 회원 정보 공개여부(공개/비공개) */
	userDel		char(2) default 'NO',									/* 회원 탈퇴 신청 */ 		
	photo 		varchar(100) default 'noimage.jpg',		/* 프로필 사진 */
	visitCnt 	int default 0,												/* 방문횟수 */ 
	startDate datetime default now(),								/* 최초 가입일 */
	lastDate 	datetime default now(),								/* 마지막 접속일 */
	todayCnt 	int default 0,												/* 오늘 방문한 횟수 */
	primary Key(idx, mid)
);

desc member;
drop table member;s

insert into member values(default, 'admin', '1234','관리자','관리자','pjp8191@naver.com',default,default,'010-9772-7753','충북 청주시 흥덕구 증안로 100','영화감상/볼링',default,default,default,default,default,default,default);
select * from member;

SELECT TIMESTAMPDIFF(DAY, '2022-05-01', '2022-05-06');
SELECT TIMESTAMPDIFF(DAY, lastDate, NOW()) from member;
SELECT TIMESTAMPDIFF(DAY, lastDate, NOW()) from member where userDel ='OK';

SELECT *,TIMESTAMPDIFF(DAY, lastDate, NOW()) as applyDiff from member order by idx desc;
/*
*DATEDIFF :날짜 차이(2022-01-31)를 구하는 함수(날짜1-날짜2)
* 사용법 : DATEDIFF(날짜1, 날짜2)
* 사용예 :
SELECT DATEDIFF('2022-01-31',NOW());

*TIMESTAMPDIFF 함수 : 날짜와 시간(2022-01-31 12:30:50)  차이를 구하는 함수(날짜2-날짜1)
* 사용법 : TIMESTAMPDIFF(날짜1, 날짜2)
*단위 :
* 초 : SECOND, 분 :MINUTE, 시 :HOUR
* 일 : DAY, 월 : MONTH, 년 : YEAR
사용예 :
SELECT TIMESTAMPDIFF(DAY, '2022-05-01', '2022-05-06');
*/


show tables;

/* 팔로우 처리*/
create table follow(
	idx 	int not null auto_increment,
	aMid	varchar(30) not null,				/* 내가 팔로우 하는 사람(팔로우) */
	bMid  varchar(30) not null,				/* 나를 팔로우 하는 사람(팔로워) */
	primary Key(idx)
);

select * from board where mid = (select  bmid from follow where aMid = ?)
drop table follow;
select * from follow;

select * from follow,board where follow.idx = board.idx and follow.bMid =? 

