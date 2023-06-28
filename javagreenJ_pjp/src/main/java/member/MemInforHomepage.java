package member;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/memInforHomepage")
public class MemInforHomepage extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String aMid = (String) session.getAttribute("sMid");
		String bMid = request.getParameter("bMid")== null ? "" : request.getParameter("bMid");
		// int idx= request.getParameter("idx")==null ? 0 : Integer.parseInt(request.getParameter("idx"));
		
		MemberDAO dao = new MemberDAO();
		
		// 이미 팔로우 신청되어있는지 검색후 팔로우 처리
		String res = dao.searchFollow(aMid,bMid);
		
		if(res.equals("1")) {
			// 팔로우 신청
			res = dao.followUp(aMid, bMid);
		}
		else {
			res = "0";
		}
		response.getWriter().write(res);
	}
}
