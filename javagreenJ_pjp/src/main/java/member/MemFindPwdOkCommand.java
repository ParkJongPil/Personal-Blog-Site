package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MemFindPwdOkCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid")== null ? "" : request.getParameter("mid");
		String email= request.getParameter("email")==null? "" : request.getParameter("email");
		
		MemberDAO dao = new MemberDAO();
		String msg ="";
		int res = dao.pwdSearch(mid,email);
		
		if(res == 1) {
			msg = "pwdSearchOk";
			request.setAttribute("url", request.getContextPath()+"/memFindPwd2.mem?mid="+ mid);
		}
		else {
			msg = "pwdSearchOk";
			request.setAttribute("url", request.getContextPath()+"/memFindPwd.mem");
		}
		request.setAttribute("mid", mid);
		request.setAttribute("msg", msg);
	}

}
