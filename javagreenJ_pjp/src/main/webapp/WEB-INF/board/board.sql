show tables;

create table board(
	idx int  not null auto_increment, /* 게시글의 고유번호 */
	mid 	 varchar(20) not null,	 	  /* 회원 아이디(게시글 조회 시 사용)*/
	nickName varchar(20) not null, 	  /* 게시글을 올린 사람의 닉네임 */
	title	 varchar(100) not null,	  	/* 게시글의 글 제목 */
	content	 text not null,			  		/* 글 내용 */
	wDate	 datetime default now(),  	/* 글 올린 날짜 */
	readNum  int default 0,			  		/* 조회수 */
	good	 int default 0, 		  			/* '좋아요' 횟수 누적처리 */
	fSName varchar(100) not null,			/* 이미지 추가*/
	primary key(idx)				  				/* 게시판의 기본키: 고유번호 */
);

desc board;

insert into board values (default,'admin','관리자','게시판','이곳은 게시판~',default,default,default);

select * from board;


/* 댓글 테이블(boardReply) */
create table boardReply(
	idx int not null auto_increment, 		/* 댓글의 고유번호 */
	boardIdx int not null,		     			/* 원본글의 고유번호(외래키로 지정함) */
	mid	 	 varchar(20) not null,				/* 댓글 올린이의 아이디 */
	nickName varchar(20) not null,			/* 댓글 올린이의 닉네임 */
	content text		not null,						/* 댓글 내용 */
	wDate	datetime default now(),				/* 댓글쓴 날짜 */
	primary	key(idx),										/* 주키(기본키)는 idx */
	foreign Key(boardIdx) references board(idx) /* board테이블의 idx를 boardReply테이블의 외래키(boardIdx)로 설정함 */
	on update cascade										/* 원본 테이블에서의 주키의 변경에 영향을 받는다. */
	on delete restrict									/* 원본 테이블에서의 주키 삭제 시키지 못하게 한다.(삭제시는 에러 발생하고 원본키를 삭제하지 못함) */ 
);	

select * from boardReply;
drop table boardReply;


show tables;

/* 공지사항(boardNotice) */
create table boardNotice(
	adIdx int  not null auto_increment, /* 게시글의 고유번호 */
	admid 	 varchar(20) not null,	 	  /* 회원 아이디(게시글 조회 시 사용)*/
	adnickName varchar(20) not null, 	  /* 게시글을 올린 사람의 닉네임 */
	adTitle	 varchar(100) not null,	  	/* 게시글의 글 제목 */
	adContent	 text not null,			  		/* 글 내용 */
	adWDate	 datetime default now(),  	/* 글 올린 날짜 */
	adReadNum  int default 0,			  		/* 조회수 */
	primary key(adIdx)				  			 	  /* 게시판의 기본키: 고유번호 */
);



SELECT * FROM board WHERE mid IN (SELECT bMid FROM follow );
SELECT * FROM board WHERE mid IN (SELECT bMid FROM follow where aMid='admin');
SELECT * FROM board WHERE mid IN (SELECT bMid FROM follow where aMid='kms1234');

select * from board where mid = 'kms1234' order by idx desc;

select * from board, (select bMid from follow order by bMid ASC FETCH FIRST 1 ROWS ONLY)as F;
select * from board where mid = (select aMid from follow where bMid = 'hkd1234');
select * from board where mid = 
select bMid from follow where aMid = 'admin';
