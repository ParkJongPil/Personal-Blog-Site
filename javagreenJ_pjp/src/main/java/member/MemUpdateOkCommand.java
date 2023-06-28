package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import conn.SecurityUtil;

public class MemUpdateOkCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid= request.getParameter("mid")== null ? "" : request.getParameter("mid");
		String pwd = request.getParameter("pwd1")== null? "" : request.getParameter("pwd1");
		SecurityUtil security = new SecurityUtil();
		pwd = security.encryptSHA256(pwd);
		System.out.println(pwd + mid);
		MemberDAO dao = new MemberDAO();
		
		int res = dao.pwdUpdateOk(mid, pwd);
		if (res == 1) {
			request.setAttribute("msg", "pwdUpdateOk");
		}
		else {
			request.setAttribute("msg", "pwdUpdateNo");
		}
		request.setAttribute("url", request.getContextPath()+"/memLogin.mem");
	}

}
