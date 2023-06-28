package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MemDeleteCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		String mid = (String) session.getAttribute("sMid");
		
		MemberDAO dao = new MemberDAO();
		
		int res = dao.setMemDeleteUpdate(mid);
		
		if(res==1) {
			request.setAttribute("msg", "memDeleteUpdateOk");
			request.setAttribute("url", request.getContextPath()+"/memLogOut.mem");
		}
		else {
			request.setAttribute("msg", "memDeleteUpdateNo");
			request.setAttribute("url", request.getContextPath()+"/memMyPage.mem");
		}
	}

}
