package board;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class BoListCommand implements BoardInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String mid = (String) session.getAttribute("sMid");
		int sw = request.getParameter("sw")==null ? 0 : Integer.parseInt(request.getParameter("sw")) ;
		
		BoardDAO dao = new BoardDAO();
				
			ArrayList<BoardVO> vos = dao.getBoList(sw , "");	// 이미지 게시글
			
			
			ArrayList<BoardVO> follvos = dao.getBoList(4 ,mid);	// 내가 팔로우하는 게시글
			ArrayList<BoardVO> myvos = dao.getBoList(5 ,mid);		// 내 게시글
			
			ArrayList<BoardVO> advos = dao.getNoticeList(0);	// 공지사항 게시글
			
			request.setAttribute("myvos", myvos);
			request.setAttribute("follvos", follvos);
			request.setAttribute("vos", vos);
			request.setAttribute("advos", advos);
	}
}
