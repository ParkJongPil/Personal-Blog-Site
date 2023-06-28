package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conn.SecurityUtil;

public class MemUpdatePwdOkCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String mid = (String) session.getAttribute("sMid")== null ? "" : (String) session.getAttribute("sMid");
		String pwd = request.getParameter("newPwd")==null ? "" : request.getParameter("newPwd");
		
		// 비밀번호 암호화
		SecurityUtil security = new SecurityUtil();
		pwd = security.encryptSHA256(pwd);
		
		MemberDAO dao = new MemberDAO();
		int res = dao.getMemUpdatePwd(mid, pwd);
		
		if(res==0) {
			request.setAttribute("msg", "passwordNo");
			request.setAttribute("url", request.getContextPath()+"/member/memUpdatePwd.mem");
		}
		else {
			request.setAttribute("msg", "passwordOk");
			request.setAttribute("url", request.getContextPath()+"/");
		}
	}

}
