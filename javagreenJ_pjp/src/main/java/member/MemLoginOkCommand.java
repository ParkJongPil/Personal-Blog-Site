package member;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conn.SecurityUtil;

public class MemLoginOkCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid")== null ? "" : request.getParameter("mid");
		String pwd = request.getParameter("pwd")== null ? "" : request.getParameter("pwd");
		
		// 비밀번호 암호화
		SecurityUtil security = new SecurityUtil();
		pwd = security.encryptSHA256(pwd);
		
		MemberDAO dao = new MemberDAO();
		MemberVO vo = dao.getMemLoginOk(mid, pwd);
		
		// 로그인 실패 
		if(vo.getNickName() == null) {
			request.setAttribute("msg", "loginNo");
			request.setAttribute("url", request.getContextPath()+"/memLogin.mem");
			return;
		}
		
		// 로그인 성공(1. 주요자료 세션 저장, 2. 오늘 방문횟수에 대한 처리, 3. 방문수 증가, 4. 쿠키에 아이디 저장 유무)
		HttpSession session = request.getSession();
		
		session.setAttribute("sMid", mid);
		session.setAttribute("sNickName", vo.getNickName());
		
		if(mid.equals("admin")) session.setAttribute("sAdmin", "adminOk");
		
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String strNow =sdf.format(now);
		
		// 최종방문일과 오늘 날짜를 비교해서 다른 경우는 오늘 방문횟수(today Cnt)값을 0으로 세팅
		if(!vo.getLastDate().substring(0,10).equals(strNow)) dao.setTodayCntUpdate(mid);
		
		// 일일 방문수 증가
		dao.setMemUpdateOk(mid);
		
		//쿠키변수 'cMid'에 사용자 아이디인 'mid'를 넣어서 생성한다.
		String idCheck = request.getParameter("idCheck")==null? "off" : "on";
		Cookie cookieMid = new Cookie("cMid", mid);
		if(idCheck.equals("on")) {
			cookieMid.setMaxAge(60*60*24*7);	// cookieMid 쿠키 만료시간은 7일
		}
		else {
			cookieMid.setMaxAge(0);						// cookieMid 쿠키 삭제
		}
		response.addCookie(cookieMid);
		
		request.setAttribute("msg", "loginOk");
		request.setAttribute("url", request.getContextPath()+"/memMyPage.mem");
		
	}

}
