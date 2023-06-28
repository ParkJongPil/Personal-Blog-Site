package admin;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import member.MemberDAO;
import member.MemberVO;

public class AdMemListCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		String mid = (String) session.getAttribute("sMid");
		String admin = request.getParameter("admin")==null ? "" : request.getParameter("admin");
				
		MemberDAO dao = new MemberDAO();
		

		ArrayList<MemberVO> vos = dao.getMemList2(mid,admin);
		
		request.setAttribute("vos", vos);
		request.setAttribute("curScrStartNo", vos.size());
	}

}
