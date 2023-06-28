package board;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BoSearchCommand implements BoardInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String search = request.getParameter("search") == null ? "" : request.getParameter("search");
		String searchString = request.getParameter("searchString") == null ? "" : request.getParameter("searchString");
		
		int pag = request.getParameter("pag") == null ? 1 : Integer.parseInt(request.getParameter("pag"));
		int pageSize = request.getParameter("pageSize") == null ? 5 : Integer.parseInt(request.getParameter("pageSize"));
		
		BoardDAO dao = new BoardDAO();
		
		ArrayList<BoardVO> vos = dao.getBoSearch(search, searchString);
		
		String searchTitle ="";
		if(search.equals("title")) searchTitle = "제목";
		else if(search.equals("nickName")) searchTitle="닉네임";
		else searchTitle = "내용";
		
		request.setAttribute("vos", vos);
		request.setAttribute("pag", pag);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("searchString", searchString);
		request.setAttribute("searchCount", vos.size());
		request.setAttribute("searchTitle", searchTitle);
	}

}


