package admin;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("*.ad")
public class AdminController extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AdminInterface command = null;
		String viewPaged = "/WEB-INF";
		
		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/")+1, uri.lastIndexOf("."));
			//세션이 끊겼으면 작업의 진행을 홈으로 보냄
			HttpSession session = request.getSession();
			String mid = session.getAttribute("sMid")== null ? "" : (String) session.getAttribute("sMid");
		if(!mid.equals("admin")) {
			viewPaged = "/";
		}
		else if(com.equals("adMenu")) {
			viewPaged += "/admin/adMenu.jsp";
		}
		else if(com.equals("adMemList")) {
			command = new AdMemListCommand();
			command.execute(request, response);
			viewPaged += "/admin/member/adMemList.jsp";
		}
		else if(com.equals("adLeft")) {
			viewPaged += "/admin/adLeft.jsp";
		}
		else if(com.equals("adContent")) {
			viewPaged += "/admin/adContent.jsp";
		}
		else if(com.equals("adNotice")) {
			viewPaged += "/admin/adNotice.jsp";
		}
		else if(com.equals("adNoticeOk")) {
			command = new AdNoticeOkCommand();
			command.execute(request, response);
			viewPaged = "/message/message.jsp";
		}
		else if(com.equals("adInput")) {
			viewPaged = "notice/adInput.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPaged);
		dispatcher.forward(request, response);
	}
}
