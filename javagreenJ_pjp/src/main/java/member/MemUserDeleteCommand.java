package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MemUserDeleteCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = Integer.parseInt(request.getParameter("idx"));
		
		MemberDAO dao = new MemberDAO();
		
		int res = dao.setMemDeleteUpdate(idx);
		
		if(res==1) {
			request.setAttribute("msg", "userDeleteOk");
		}
		else {
			request.setAttribute("msg", "userDeleteNo");
		}
			request.setAttribute("url", request.getContextPath()+"/adMemList.ad");
	}

}
