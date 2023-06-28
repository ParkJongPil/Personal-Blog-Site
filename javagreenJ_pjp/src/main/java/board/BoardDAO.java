package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import org.apache.catalina.filters.AddDefaultCharsetFilter;

import conn.GetConn;
import conn.TimeDiff;

public class BoardDAO {
	GetConn getConn = GetConn.getInstance();
	private Connection conn = getConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql ="";
	
	BoardVO vo = null;
	
	//페이징 처리를 위한 전체 레코드 수 구하기
	public int totRecCnt(int recent) {
		int totRecCnt = 0;
		try {
			if(recent == 0) {
				sql = "select count(*) as cnt from board";	
				pstmt = conn.prepareStatement(sql);
			}
			else {
				sql = "select count(*) as cnt from board where date_sub(now), interval ? day) < wDate;";	
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, recent);
			}
			rs = pstmt.executeQuery();
			
			rs.next();	// 값 존재 확인
			totRecCnt = rs.getInt("cnt");
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return totRecCnt;
	}
// 전체 자료 검색
	public ArrayList<BoardVO> getBoList(int sw, String mid) {
		ArrayList<BoardVO> vos = new ArrayList<BoardVO>();
		try {
				if(sw ==0) {
					sql= "select *,(select count(*) from boardReply where boardIdx=board.idx)as replyCount from board order by idx desc";
					pstmt=conn.prepareStatement(sql);
				}
				else if(sw ==1) {	//좋아요 높은순
					sql= "select *,(select count(*) from boardReply where boardIdx=board.idx)as replyCount from board order by good desc";
					pstmt=conn.prepareStatement(sql);
				}
				else if(sw==2){	// 댓글 높은순
					 sql= "select *,(select count(*) from boardReply where boardIdx=board.idx)as replyCount from board order by replyCount desc";
					pstmt=conn.prepareStatement(sql);
				}
				else if(sw ==3) {	//조회 높은순
					sql= "select *,(select count(*) from boardReply where boardIdx=board.idx)as replyCount from board order by readNum desc";
					pstmt=conn.prepareStatement(sql);
				}
				else if(sw==4){
					// 팔로우 하는 게시글
					sql= "SELECT * FROM board WHERE mid IN (SELECT bMid FROM follow where aMid=?) order by idx desc";
					pstmt=conn.prepareStatement(sql);
					pstmt.setString(1, mid);
				}
				else if(sw==5){
				//내 게시글
					sql= "select * from board where mid = ? order by idx desc";
					pstmt=conn.prepareStatement(sql);
					pstmt.setString(1, mid);
				}
					rs = pstmt.executeQuery();
					while(rs.next()) {
						vo = new BoardVO();
						vo.setIdx(rs.getInt("idx"));
						vo.setNickName(rs.getString("nickName"));
						vo.setTitle(rs.getString("title"));
						vo.setContent(rs.getString("content"));
						
						// 날짜를 24시간제로 체크하기 위해서 사용자가 만든 클래스의 메소드로 처리
						vo.setwDate(rs.getString("wDate"));
						vo.setwCdate(rs.getString("wDate"));
						TimeDiff timediff = new TimeDiff();	// 날짜 계산하는 사용자 클래스
						int res = timediff.timeDiff(vo.getwCdate());	
						vo.setwNdate(res);	// 오늘 날짜와 글쓴 날짜의 시간차를 숫자형식 변수에 저장시켜준다.
						
						vo.setReadNum(rs.getInt("readNum"));
						vo.setGood(rs.getInt("good"));
						vo.setMid(rs.getString("mid"));
						if(sw == 0 || sw == 1 || sw == 2 || sw == 3) {
							vo.setReplyCount(rs.getInt("replyCount"));						
						}
						
						vo.setfName(rs.getString("fName"));
						
						vos.add(vo);
					}
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		}finally {
			getConn.rsClose();
		}
		return vos;
	}
	
	// 게시글 저장하기
	public int setBoInputOk(BoardVO vo) {
		int res= 0;
		try {
			sql="insert into board values(default,?,?,?,?,default,default,default,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getMid());
			pstmt.setString(2, vo.getNickName());
			pstmt.setString(3, vo.getTitle());
			pstmt.setString(4, vo.getContent());
			pstmt.setString(5, vo.getfName());
			pstmt.executeUpdate();
			res= 1;
		} catch (SQLException e) {
			System.out.println("SQL에러 : " +e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}
	
	// 게시판 검색기 처리
	public ArrayList<BoardVO> getBoSearch(String search, String searchString) {
		ArrayList<BoardVO> vos = new ArrayList<BoardVO>();
		try {
			sql="select * from board where " +search+" like ? order by idx desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" +searchString+"%");
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new BoardVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setNickName(rs.getString("nickName"));
				vo.setTitle(rs.getString("title"));
				vo.setContent(rs.getString("content"));
				vo.setwDate(rs.getString("wDate"));
				vo.setwCdate(rs.getString("wDate"));
				vo.setReadNum(rs.getInt("readNum"));
				vo.setGood(rs.getInt("good"));
				vo.setMid(rs.getString("mid"));
				vo.setfName(rs.getString("fName"));
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		
		return vos;
	}
	// 게시글 삭제하기
	public int setBoDeleteOk(int idx, int sw) {
		int res=0;
		try {
		if(sw==  0) {
			sql = "delete from board where idx=?";
			pstmt= conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			res=1;
		}
		else if(sw== 1){
		sql = "delete from boardNotice where adIdx=?";
		pstmt= conn.prepareStatement(sql);
		pstmt.setInt(1, idx);
		pstmt.executeUpdate();
		res=1;
		}
		} catch (SQLException e) {
			System.out.println("SQL에러 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}
	
	// 댓글 자료 수정하기
	public String setReplyUpdateOk(int idx, String content) {
		String res="0";
		try {
			sql="update boardReply set content=? where idx=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, content);
			pstmt.setInt(2, idx);
			pstmt.executeUpdate();
			res="1";
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}
	// 게시된 1개 글의 모든 내용을 가져옴
	public BoardVO getBoContent(int idx, int sw) {
		vo = new BoardVO();
		try {
			if(sw==0) {
				sql="select * from board where idx=?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setInt(1, idx);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					vo.setIdx(rs.getInt("idx"));
					vo.setNickName(rs.getString("nickName"));
					vo.setTitle(rs.getString("title"));
					vo.setContent(rs.getString("content"));
					vo.setwDate(rs.getString("wDate"));
					vo.setReadNum(rs.getInt("readNum"));
					vo.setGood(rs.getInt("good"));
					vo.setMid(rs.getString("mid"));
					vo.setfName(rs.getString("fName"));
				}
				
			}
			else if(sw==1) {
				sql="select * from boardNotice where adIdx=?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setInt(1, idx);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					vo.setIdx(rs.getInt("adIdx"));
					vo.setNickName(rs.getString("adnickName"));
					vo.setTitle(rs.getString("adTitle"));
					vo.setContent(rs.getString("adContent"));
					vo.setwDate(rs.getString("adWDate"));
					vo.setReadNum(rs.getInt("adReadNum"));
					vo.setMid(rs.getString("admid"));
				}
				
			}
		} catch (SQLException e) {
			System.out.println("SQL에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vo;
	}
	// 게시글 수정
	public int setBoUpdateOk(BoardVO vo, int sw) {
		int res=0;
		try {
			
		if(sw==0) {
			sql ="update board set title=?, content=? where idx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getTitle());
			pstmt.setString(2, vo.getContent());
			pstmt.setInt(3, vo.getIdx());
			pstmt.executeUpdate();
			res=1;
		}
		  else if(sw==1) { 
		  sql="update boardNotice set adTitle=?, adContent=? where adIdx=?"; 
		  pstmt =conn.prepareStatement(sql); 
		  pstmt.setString(1, vo.getTitle());
		  pstmt.setString(2, vo.getContent()); 
		  pstmt.setInt(3, vo.getIdx());
		  pstmt.executeUpdate(); 
		  res=1; 
		}
		} catch (SQLException e) {
			System.out.println("SQL에러 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}
	//글 조회수 1 증가하기
	public void setReadNum(int idx) {
		try {
			sql="Update board set readNum = readNum +1 where idx =?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		}finally {
			getConn.rsClose();
		}
	}
//이전글, 다음글 내용 가져오기
	public BoardVO getPreNextSearch(String str, int idx) {
		vo = new BoardVO();
		try {
			if(str.equals("pre")) {
				sql ="select * from board where idx < ? order by idx desc limit  1";
			}
			else {
				sql="select * from board where idx > ? limit 1";
			}
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs= pstmt.executeQuery();
			
			if(str.equals("pre") && rs.next()) {
				vo.setPreIdx(rs.getInt("idx"));
				vo.setPreTitle(rs.getString("title"));
			}
			else if(str.equals("next")&& rs.next()){
				vo.setNextIdx(rs.getInt("idx"));
				vo.setNextTitle(rs.getString("title"));
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vo;
	}
//부모글에 해당하는 댓글 내용 가져오기
	public ArrayList<BoardReplyVO> getBoardReply(int boardIdx) {
		ArrayList<BoardReplyVO> replyVos = new ArrayList<BoardReplyVO>();
		try {
			sql="select * from boardReply where boardIdx=?";
			pstmt = conn.prepareStatement(sql); 
			pstmt.setInt(1, boardIdx);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				BoardReplyVO replyVo= new BoardReplyVO();
				replyVo.setIdx(rs.getInt("idx"));
				replyVo.setBoardIdx(boardIdx);
				replyVo.setMid(rs.getString("mid"));
				replyVo.setNickName(rs.getString("nickName"));
				
				// 날짜를 24시간제로 체크하기 위해서 사용자가 만든 클래스의 메소드로 처리한다.(timeDiff())
				replyVo.setwDate(rs.getString("wDate"));
				replyVo.setwCdate(rs.getString("wDate"));
				TimeDiff timediff = new TimeDiff();	// 날짜 계산하는 사용자 클래스
				int res = timediff.timeDiff(replyVo.getwCdate());	
				replyVo.setwNdate(res);	// 오늘 날짜와 글쓴 날짜의 시간차를 숫자형식 변수에 저장시켜준다.
				
				replyVo.setContent(rs.getString("content"));
				
				replyVos.add(replyVo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return replyVos;
	}
//댓글 수정을 위해, 선택한 댓글의 내용을 가져오기 위한 처리
	public String getReplyContent(int replyIdx) {
		String content ="";
		try {
			sql = "select content from boardReply where idx=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, replyIdx);
			rs= pstmt.executeQuery();
			rs.next();
			content=rs.getString(1);
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return content;
	}
	// 좋아요 횟수 1증가 처리
	public void setGoodCount(int idx) {
		try {
			sql = "update board set good= good +1 where idx =?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		}finally {
			getConn.pstmtClose();
		}
		
	}
	//댓글 삭제
	public String boReplyDeleteOk(int idx) {
		String res ="0";
		try {
			sql="delete from boardReply where idx =?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			res="1";
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}
	
	//댓글 입력처리
	public String setReplyInputOk(BoardReplyVO replyVo) {
			String res = "0";
			try {
				sql="insert into boardReply values (default,?,?,?,?,default)";
				pstmt=conn.prepareStatement(sql);
				pstmt.setInt(1, replyVo.getBoardIdx());
				pstmt.setString(2, replyVo.getMid());
				pstmt.setString(3, replyVo.getNickName());
				pstmt.setString(4, replyVo.getContent());
				pstmt.executeUpdate();
				res="1";
			} catch (SQLException e) {
				System.out.println("SQL 에러 : " + e.getMessage());
			} finally {
				getConn.pstmtClose();
			}
		return res;	
		}
	
	// 공지사항 작성하기
	public int setadNoticeOk(BoardVO vo) {
		int res= 0;
		try {
			sql ="insert into boardNotice values(default, ?, ?,?,?, default,default)";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, vo.getMid());
			pstmt.setString(2, vo.getNickName());
			pstmt.setString(3, vo.getTitle());
			pstmt.setString(4, vo.getContent());
			pstmt.executeUpdate();
			res=1;
		} catch (SQLException e) {
			System.out.println("SQL 에러 :" + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}
	// 공지사항 목록보기
			 public ArrayList<BoardVO> getNoticeList(int i) {
				ArrayList<BoardVO> advos = new
			  ArrayList<BoardVO>(); 
			  try { 
			  if(i == 1) {
			  	sql="select * from boardNotice";
			  	pstmt=conn.prepareStatement(sql); 
			  	rs= pstmt.executeQuery();
			  }
			  
			  while(rs.next())  { 
			  vo = new BoardVO(); 
			  vo.setMid(rs.getString("admid"));
			  vo.setIdx(rs.getInt("adIdx")); 
			  vo.setNickName(rs.getString("adnickName"));
			  vo.setTitle(rs.getString("adTitle"));
			  vo.setContent(rs.getString("adContent")); // 날짜를 24시간제로 체크하기 위해서 사용자가 만든 클래스의메소드로 처리 
			  vo.setwDate(rs.getString("adWDate"));
			  vo.setwCdate(rs.getString("adWDate")); 
			  TimeDiff timediff = new TimeDiff(); //날짜 계산하는 사용자 클래스 
			  int res = timediff.timeDiff(vo.getwCdate());
			  vo.setwNdate(res); // 오늘 날짜와 글쓴 날짜의 시간차를 숫자형식 변수에 저장시켜준다.
			  vo.setReadNum(rs.getInt("adReadNum"));
			  advos.add(vo); }
			 
		} catch (SQLException e) {
			System.out.println("SQL에러 :" +e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return advos;
	}
			 // 게시글 삭제전 댓글 지우기
			public void boReplyDelete(int idx) {
				try {
					sql="delete from boardReply where boardIdx=?";
					pstmt= conn.prepareStatement(sql);
					pstmt.setInt(1, idx);
					pstmt.executeUpdate();
				} catch (SQLException e) {
					System.out.println("SQL에러 :" +e.getMessage());
				} finally {
					getConn.pstmtClose();
				}
			}
			
			
}
