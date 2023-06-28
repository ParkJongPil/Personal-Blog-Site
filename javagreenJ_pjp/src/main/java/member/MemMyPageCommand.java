package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MemMyPageCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		String mid =(String) session.getAttribute("sMid");
		
		MemberDAO dao = new MemberDAO();
		
		MemberVO vo = dao.getUserInfor(mid);
		
		int aMidCnt = dao.midCnt(mid, "a");
		int bMidCnt = dao.midCnt(mid, "b");
		
		request.setAttribute("vo", vo);
		request.setAttribute("lastDate", vo.getLastDate());
		request.setAttribute("todayCnt", vo.getTodayCnt());
		request.setAttribute("visitCnt", vo.getVisitCnt());
		request.setAttribute("aMidCnt", aMidCnt);
		request.setAttribute("bMidCnt", bMidCnt);
		
		
	}

}
