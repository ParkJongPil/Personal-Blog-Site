package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import conn.GetConn;

public class MemberDAO {
	GetConn getConn = GetConn.getInstance();
	
	private Connection conn = getConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql ="";
	
	MemberVO vo = null;
	
	
	
	
	// 로그인 체크(아이디와 비밀번호 체크)
	public MemberVO getMemLoginOk(String mid, String pwd) {
		vo = new MemberVO();
		try {
		sql = "select * from member where mid =? and pwd =? and userDel='NO'";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, mid);
		pstmt.setString(2, pwd);
		rs = pstmt.executeQuery();
		if(rs.next()) {
			vo.setNickName(rs.getString("nickName"));
			vo.setLastDate(rs.getString("lastDate"));
			vo.setTodayCnt(rs.getInt("todayCnt"));
		}
		} catch (SQLException e) {
			System.out.println("SQL에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vo;
	}

	//오늘 처음 방문시는 오늘 방문 카운트(todayCnt)를 0으로 세팅함
	public void setTodayCntUpdate(String mid) {
		try {
			sql="update member set todayCnt= 0 where mid =?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL에러 : " +e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
	}
	// 개별 회원 정보를 모두 DB에서 가져와서 VO에 담아준다.
	public MemberVO getUserInfor(String mid) {
		vo = new MemberVO();
		try {
			sql="select * from member where mid =?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs= pstmt.executeQuery();
			rs.next();
			
			vo.setIdx(rs.getInt("idx"));
			vo.setMid(rs.getString("mid"));
			vo.setPwd(rs.getString("pwd"));
			vo.setNickName(rs.getString("nickName"));
			vo.setName(rs.getString("name"));
			vo.setEmail(rs.getString("email"));
			vo.setGender(rs.getString("gender"));
			vo.setBirthday(rs.getString("birthday"));
			vo.setTel(rs.getString("tel"));
			vo.setAddress(rs.getString("address"));
			vo.setHobby(rs.getString("hobby"));
			vo.setUserInfor(rs.getString("userInfor"));
			vo.setUserDel(rs.getString("userDel"));
			vo.setPhoto(rs.getString("photo"));
			vo.setVisitCnt(rs.getInt("visitCnt"));
			vo.setStartDate(rs.getString("startDate"));
			vo.setLastDate(rs.getString("lastDate"));
			vo.setTodayCnt(rs.getInt("todayCnt"));
		} catch (SQLException e) {
			System.out.println("SQL에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vo;
	}
	//아이디 찾기(분실 했을 경우)
	public String memFindId(String email) {
		String mid="";
		try {
			sql="select mid from member where email =?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			rs.next();
			mid = rs.getString("mid");
		} catch (SQLException e) {
			System.out.println("SQL에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return mid;
	}
	// 비밀번호 찾기
	public int pwdSearch(String mid, String email) {
		int res = 0;
		try {
			sql="select * from member where mid=? and email=? ";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.setString(2, email);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				res = 1;
			}
			
		} catch (SQLException e) {
			System.out.println("SQL에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return res;
	}
	// 비밀번호 재설정
	public int pwdUpdateOk(String mid, String pwd) {
		int res = 0;
		try {
			sql = "update member set pwd =? where mid =?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, pwd);
			pstmt.setString(2, mid);
			pstmt.executeUpdate();
			res=1;
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}
	// 아이디 중복체크
	public String memIdCheck(String mid) {
		String name = "";
		try {
		sql = "select name from member where mid =?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, mid);
		rs = pstmt.executeQuery();
		if(rs.next()) name = rs.getString("name");
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return name;
	}
	
	// 닉네임 중복 체크하기
	public String memNickCheck(String nickName) {
		String name ="";
		try {
			sql = "select name from member where nickName =?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, nickName);
			rs = pstmt.executeQuery();
			if(rs.next()) name = rs.getString("name");
		} catch (SQLException e) {
			System.out.println("SQL에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return name;
	}
	// 회원가입 처리
	public int setMemJoinOk(MemberVO vo) {
		int res = 0;
		try {
			sql="insert into member values(default,? ,? ,? ,? ,? ,? ,? ,? ,? ,? ,? ,default,default,default,default,default,default)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getMid());
			pstmt.setString(2, vo.getPwd());
			pstmt.setString(3, vo.getNickName());
			pstmt.setString(4, vo.getName());
			pstmt.setString(5, vo.getEmail());
			pstmt.setString(6, vo.getGender());
			pstmt.setString(7, vo.getBirthday());
			pstmt.setString(8, vo.getTel());
			pstmt.setString(9, vo.getAddress());
			pstmt.setString(10, vo.getHobby());
			pstmt.setString(11, vo.getUserInfor());
			pstmt.executeUpdate();
			res =1;
		} catch (SQLException e) {
		System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}
	
	// 회원 정보 수정
	public int setMemUpdateOk(MemberVO vo) {
		int res= 0;
		
		try {
			sql= "update member set nickName=?, name=?, gender=?, birthday=?,"
					+ " tel=?, address =?, email=?, hobby=?,"
					+ "photo=?, userInfor=? where mid=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, vo.getNickName());
			pstmt.setString(2, vo.getName());
			pstmt.setString(3, vo.getGender());
			pstmt.setString(4, vo.getBirthday());
			pstmt.setString(5, vo.getTel());
			pstmt.setString(6, vo.getAddress());
			pstmt.setString(7, vo.getEmail());
			pstmt.setString(8, vo.getHobby());
			pstmt.setString(9, vo.getPhoto());
			pstmt.setString(10, vo.getUserInfor());
			pstmt.setString(11, vo.getMid());
			pstmt.executeUpdate();
			res=1;
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
  	}
		return res;
	}
	
	// 비밀번호 변경(마이페이지)
	public int getMemUpdatePwd(String mid, String pwd) {
		int res =0;
		try {
			sql="update member set pwd=? where mid=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, pwd);
			pstmt.setString(2, mid);
			pstmt.executeUpdate();
			
			res=1;
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
  	}
		return res;
	}
	// 회원리스트 전체보기
	public ArrayList<MemberVO> getMemList() {
		 ArrayList<MemberVO> vos = new ArrayList<MemberVO>();
		 try {
				 sql = "select * from member where userInfor = '공개' order by idx desc";
				 pstmt = conn.prepareStatement(sql);
				 rs = pstmt.executeQuery();
			 
			 while(rs.next()) {
				 	vo = new MemberVO();
				 	
				 	vo.setIdx(rs.getInt("idx"));
					vo.setMid(rs.getString("mid"));
					vo.setPwd(rs.getString("pwd"));
					vo.setNickName(rs.getString("nickName"));
					vo.setName(rs.getString("name"));
					vo.setGender(rs.getString("gender"));
					vo.setBirthday(rs.getString("birthday"));
					vo.setTel(rs.getString("tel"));
					vo.setAddress(rs.getString("address"));
					vo.setEmail(rs.getString("email"));
				  vo.setHobby(rs.getString("hobby"));
				  vo.setPhoto(rs.getString("photo"));
				  vo.setUserInfor(rs.getString("userInfor"));
				  vo.setUserDel(rs.getString("userDel"));
				  vo.setVisitCnt(rs.getInt("visitCnt"));
				  vo.setStartDate(rs.getString("startDate"));
				  vo.setLastDate(rs.getString("lastDate"));
				  vo.setTodayCnt(rs.getInt("todayCnt"));			 
				  
			 		vos.add(vo);
		 	}
			} catch (SQLException e) {
				System.out.println("SQL 에러 : " + e.getMessage());
			} finally {
				getConn.rsClose();
	  	}
		
		return vos;
	}
		
	//회원 탈퇴 신청 처리
	public int setMemDeleteUpdate(String mid) {
		int res=0;
		try {
			sql="update member set userDel='OK' where mid=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.executeUpdate();
			res=1;
		} catch (SQLException e) {
			System.out.println("SQL에러 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}
	// 탈퇴 신청 후 30일이 경과된 회원을 DB에서 완전히 삭제 시킴
	public int setMemDeleteUpdate(int idx) {
		int res =0;
		try {
			sql="delete from member where idx=? ";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			res=1;
		} catch (SQLException e) {
			System.out.println("SQL에러 : "+e.getMessage());
		}	finally {
			getConn.pstmtClose();
		}
		return res;
	}

//회원 리스트 전체보기(관리자 메뉴)
	public ArrayList<MemberVO> getMemList2(String mid, String admin) {
		ArrayList<MemberVO> vos = new ArrayList<MemberVO>();
		 try {
			 if(mid.equals("admin")) {
				 sql = "SELECT *,TIMESTAMPDIFF(DAY, lastDate, NOW()) as applyDiff from member order by idx desc";
			 }
			 else {
				 sql = "select * from member where userInfor = '공개' order by idx desc";
			 }
				 pstmt = conn.prepareStatement(sql);
				 rs = pstmt.executeQuery();
			 
			 while(rs.next()) {
				 	vo = new MemberVO();
				 	
				 	vo.setIdx(rs.getInt("idx"));
					vo.setMid(rs.getString("mid"));
					vo.setPwd(rs.getString("pwd"));
					vo.setNickName(rs.getString("nickName"));
					vo.setName(rs.getString("name"));
					vo.setGender(rs.getString("gender"));
					vo.setBirthday(rs.getString("birthday"));
					vo.setTel(rs.getString("tel"));
					vo.setAddress(rs.getString("address"));
					vo.setEmail(rs.getString("email"));
				  vo.setHobby(rs.getString("hobby"));
				  vo.setPhoto(rs.getString("photo"));
				  vo.setUserInfor(rs.getString("userInfor"));
				  vo.setUserDel(rs.getString("userDel"));
				  vo.setVisitCnt(rs.getInt("visitCnt"));
				  vo.setStartDate(rs.getString("startDate"));
				  vo.setLastDate(rs.getString("lastDate"));
				  vo.setTodayCnt(rs.getInt("todayCnt"));			 
				  if(mid.equals("admin")) vo.setApplyDiff(rs.getInt("applyDiff"));
				  
			 		vos.add(vo);
		 	}
			} catch (SQLException e) {
				System.out.println("SQL 에러 : " + e.getMessage());
			} finally {
				getConn.rsClose();
	  	}
		
		return vos;
	}
	//최종 방문수, 오늘 방문수 증가하기
	public void setMemUpdateOk(String mid) {
		try {
			sql="update member set visitCnt= visitCnt+1, todayCnt= todayCnt+1, lastDate= now() where mid=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("SQL에러 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
	}
//팔로우 증가
	public String followUp(String aMid, String bMid) {
		String res= "0";
		try {
			sql="insert into follow values(default,?,?)";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, aMid);
			pstmt.setString(2, bMid);
			pstmt.executeUpdate();
			res="1";
		} catch (SQLException e) {
			System.out.println("SQL에러 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}

	// 팔로우 신청 여부 확인
	public String searchFollow(String aMid, String bMid) {
		String res="1";
		try {
			sql="select * from follow where aMid=? and bMid=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, aMid);
			pstmt.setString(2, bMid);
			rs= pstmt.executeQuery();
			if(rs.next()) res="0";
		} catch (SQLException e) {
			System.out.println("SQL에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return res;
	}
	// 팔로우한 갯수
	public int midCnt(String mid, String flag) {
		int aMidCnt =0;
		try {
			if(flag.equals("a")) {
				sql="select count(*) from follow where aMid=?";
			}
			else {
				sql="select count(*) from follow where bMid=?";
			}
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs= pstmt.executeQuery();
			if(rs.next()) aMidCnt=rs.getInt(1);
		} catch (SQLException e) {
			System.out.println("SQL에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return aMidCnt;
	}
	// 나를 팔로우 하는 사람들 목록
	public ArrayList<MemberVO> getFollowerList(String bMid) {
		ArrayList<MemberVO> vos =  new ArrayList<MemberVO>();
		try {
			sql="select * from follow where bMid=? order by idx desc";
			pstmt= conn.prepareStatement(sql);
			pstmt.setString(1, bMid);
			rs = pstmt.executeQuery();
			while(rs.next()) {
			 	vo = new MemberVO();
			 	vo.setIdx(rs.getInt("idx"));
			 	vo.setFollowing(rs.getString("aMid"));
			  vo.setFollower(rs.getString("bMid"));
			  
		 		vos.add(vo);
	 	}
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
  	}
		return vos;
	}
	// 내가 팔로우 하는 사람들 목록
	public ArrayList<MemberVO> getFollowList(String aMid) {
		ArrayList<MemberVO> vos = new ArrayList<MemberVO>();
		try {
			sql="select * from follow where aMid=? order by idx desc";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, aMid);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				vo = new MemberVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setFollowing(rs.getString("aMid"));
				vo.setFollower(rs.getString("bMid"));
				
				vos.add(vo);
			}
		} catch (SQLException e) {
		System.out.println("SQL에러 : "+e.getMessage());
		}finally {
			getConn.rsClose();
		}
		return vos;
	}

}
	

