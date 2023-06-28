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
