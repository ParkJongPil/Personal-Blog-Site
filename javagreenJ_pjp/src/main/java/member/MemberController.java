package member;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("*.mem")
public class MemberController extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MemberInterface command = null;
		String viewPaged = "/WEB-INF";
		
		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/") +1, uri.lastIndexOf("."));
		
		//세션이 끊겼으면 작업의 진행을 홈으로 보냄
		HttpSession session = request.getSession();
		String mid = session.getAttribute("sMid")== null ? "" : (String) session.getAttribute("sMid");
		
		if(com.equals("memLogin")) {
			command = new MemLoginCommand();
			command.execute(request, response);
			viewPaged += "/member/memLogin.jsp";
		}
		else if(com.equals("memLogOut")) {
			command = new MemLogOutCommand();
			command.execute(request, response);
			viewPaged = "/message/message.jsp";
		}
		else if(com.equals("memLoginOk")) {
			command = new MemLoginOkCommand();
			command.execute(request, response);
			viewPaged = "/message/message.jsp";
		}
		else if(com.equals("memJoin")) {
			viewPaged += "/member/memJoin.jsp";
		}
		else if(com.equals("memJoinOk")) {
			command = new MemJoinOkCommand();
			command.execute(request, response);
			viewPaged = "/message/message.jsp";
		}
		else if(com.equals("memMyPage")) {
			command = new MemMyPageCommand();
			command.execute(request, response);
			viewPaged += "/member/memMyPage.jsp";
		}
		else if(com.equals("memIdCheck")) {
			command = new MemIdCheckCommand();
			command.execute(request, response);
			viewPaged += "/member/memIdCheck.jsp";
		}
		else if(com.equals("memNickCheck")) {
			command = new MemNickCheckCommand();
			command.execute(request, response);
			viewPaged += "/member/memNickCheck.jsp";
		}
		else if(com.equals("memFindId")) {
			viewPaged += "/member/memFindId.jsp";
		}
		else if(com.equals("memFindId2")) {
			viewPaged += "/member/memFindId2.jsp";
		}
		else if(com.equals("memFindPwd")) {
			viewPaged += "/member/memFindPwd.jsp";
		}
		else if(com.equals("memFindPwd2")) {
			viewPaged += "/member/memFindPwd2.jsp";
		}
		else if(com.equals("memFindPwdOk")) {
			command = new MemFindPwdOkCommand();
			command.execute(request, response);
			viewPaged = "/message/message.jsp";
		}
		else if(com.equals("memFindIdOk")) {
			command = new MemFindIdOkCommand();
			command.execute(request, response);
			viewPaged = "/message/message.jsp";
		}
		else if(com.equals("memUpdate")) {
			command = new MemUpdateCommand();
			command.execute(request, response);
			viewPaged += "/member/memUpdate.jsp";
		}
		else if(com.equals("memUpdateOk")) {
			command = new MemUpdateOkCommand();
			command.execute(request, response);
			viewPaged = "/message/message.jsp";
		}
		else if(mid.equals("")) {
			viewPaged = "/";
		}
		else if(com.equals("memList")) {
			command = new MemListCommand();
			command.execute(request, response);
			viewPaged += "/member/memList.jsp";
			}
		else if(com.equals("memUpdateOk2")) {
			command = new MemUpdateOk2Command();
			command.execute(request, response);
			viewPaged = "/message/message.jsp";
		}
		else if(com.equals("memUpdatePwd")) {
			viewPaged += "/member/memUpdatePwd.jsp";
		}
		else if(com.equals("memUpdatePwdOk")) {
			command = new MemUpdatePwdOkCommand();
			command.execute(request, response);
			viewPaged = "/message/message.jsp";
		}
		else if(com.equals("memUserDelete")) {
			command = new MemUserDeleteCommand();
			command.execute(request, response);
			viewPaged = "/message/message.jsp";
		}
		else if(com.equals("memDelete")) {
			command = new MemDeleteCommand();
			command.execute(request, response);
			viewPaged = "/message/message.jsp";
		}
		else if(com.equals("memInforHomePage")) {
			command = new MemInforHomePageCommand();
			command.execute(request, response);
			viewPaged += "/member/memInforHomePage.jsp";
		}
		else if(com.equals("memFollow")) {
			command = new MemFollowCommand();
			command.execute(request, response);
			viewPaged += "/member/memFollow.jsp";
		}
		else if(com.equals("memFollower")) {
			command = new MemFollowerCommand();
			command.execute(request, response);
			viewPaged += "/member/memFollower.jsp";
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPaged);
		dispatcher.forward(request, response);
	}
}
