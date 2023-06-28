package board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BoUpdateCommand implements BoardInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx") == null ? 0 : Integer.parseInt(request.getParameter("idx"));
		// int pag = request.getParameter("pag") == null ? 0 : Integer.parseInt(request.getParameter("pag"));
		// int pageSize = request.getParameter("pageSize") == null ? 0 : Integer.parseInt(request.getParameter("pageSize"));
		int sw = request.getParameter("sw") == null ? 0 : Integer.parseInt(request.getParameter("sw"));
		
		BoardDAO dao = new BoardDAO();
		
		BoardVO vo = dao.getBoContent(idx,sw);
		
		request.setAttribute("vo", vo);
		//request.setAttribute("pag", pag);
		//request.setAttribute("pageSize", pageSize);
		
	}

}
