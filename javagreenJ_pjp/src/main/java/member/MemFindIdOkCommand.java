package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MemFindIdOkCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email =request.getParameter("email")==null ? "" : request.getParameter("email");
		
		MemberDAO dao = new MemberDAO();
		
		String mid = dao.memFindId(email);
		String msg ="";
		
		if(mid.equals("")) {
			msg="findNo";
			request.setAttribute("url", request.getContextPath()+"/memFindId.mem");
		}
		else {
			msg = "findOk";
			request.setAttribute("url", request.getContextPath()+"/memFindId2.mem?mid="+mid);
		}
		request.setAttribute("mid", mid);
		request.setAttribute("msg", msg);
	}

}
