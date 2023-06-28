package board;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("*.bo")
public class BoardController extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BoardInterface command = null;
		String viewPaged = "/WEB-INF";
		
		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/")+1, uri.lastIndexOf("."));
		
		//세션이 끊겼으면 작업의 진행을 홈으로 보냄
		HttpSession session = request.getSession();
		String mid = session.getAttribute("sMid")== null ? "" : (String) session.getAttribute("sMid");
		
		if(com.equals("boList")) {
			command = new BoListCommand();
			command.execute(request, response);
			viewPaged += "/board/boList.jsp";
		}
		else if(com.equals("boInput")) {
			command = new BoInputCommand();
			command.execute(request, response);
			viewPaged += "/board/boInput.jsp";
		}
		else if(com.equals("boInputOk")) {
			command = new BoInputOkCommand();
			command.execute(request, response);
			viewPaged = "/message/message.jsp";
		}
		else if(com.equals("boSearch")) {
			command = new BoSearchCommand();
			command.execute(request, response);
			viewPaged += "/board/boSearch.jsp";
		}
		else if(com.equals("boContent")) {
			command = new BoContentCommand();
			command.execute(request, response);
			viewPaged += "/board/boContent.jsp";
		}
		else if(com.equals("boDeleteOk")) {
			command = new BoDeleteOkCommand();
			command.execute(request, response);
			viewPaged = "/message/message.jsp";
		}
		else if(com.equals("boReplyUpdateOk")) {
			command = new BoReplyUpdateOkCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("boUpdate")) {
			command = new BoUpdateCommand();
			command.execute(request, response);
			viewPaged += "/board/boUpdate.jsp";
		}
		else if(com.equals("boUpdateOk")) {
			command = new BoUpdateOkCommand();
			command.execute(request, response);
			viewPaged = "/message/message.jsp";
		}
		else if(com.equals("boLeft")) {
			viewPaged += "/board/boLeft.jsp";
		}
		else if(com.equals("boListNoS")) {
			command = new BoListNoSCommand();
			command.execute(request, response);
			viewPaged = "/message/message.jsp";
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPaged);
		dispatcher.forward(request, response);
	}
}
