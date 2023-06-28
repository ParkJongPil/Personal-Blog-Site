package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MemLogOutCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		String nickName = (String) session.getAttribute("sNickName");
		
		session.invalidate();
		
		request.setAttribute("msg", "memLogOutOk");
		request.setAttribute("url", request.getContextPath()+"/memLogin.mem");;
		request.setAttribute("val", nickName);
	}

}
