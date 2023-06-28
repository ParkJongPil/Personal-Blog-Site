package admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.BoardDAO;
import board.BoardVO;

public class AdNoticeOkCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String nickName = session.getAttribute("sNickName") == null ? "" : (String) session.getAttribute("sNickName");
		String mid = session.getAttribute("sMid") == null ? "" : (String) session.getAttribute("sMid");
		String title = request.getParameter("title") == null ? "" : request.getParameter("title");
		String content = request.getParameter("content") == null ? "" : request.getParameter("content");
		
		title= "[공지사항] " + title;
		
		BoardVO vo = new BoardVO();
		vo.setNickName(nickName);
		vo.setTitle(title);
		vo.setContent(content);
		vo.setMid(mid);
		
		BoardDAO dao = new BoardDAO();
		int res = dao.setadNoticeOk(vo);
		
		if(res ==1) {
			request.setAttribute("msg", "adNoticeOk");
			request.setAttribute("url", request.getContextPath()+"/boList.bo");
		}
		else {
			request.setAttribute("msg", "adNoticeNo");
			request.setAttribute("url", request.getContextPath()+"/adNotice.ad");
		}
	}
		
	}

