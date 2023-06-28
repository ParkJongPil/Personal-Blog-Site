package board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BoUpdateOkCommand implements BoardInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")== null ? 0 : Integer.parseInt(request.getParameter("idx"));
		//int pag = request.getParameter("pag")== null ? 1 : Integer.parseInt(request.getParameter("pag"));
		//int pageSize = request.getParameter("pageSize")== null ? 5 : Integer.parseInt(request.getParameter("pageSize"));
		int sw = request.getParameter("sw")==null ? 0 : Integer.parseInt(request.getParameter("sw"));
		
		String title = request.getParameter("title") == null ? "" : request.getParameter("title");
		String content = request.getParameter("content") == null ? "" : request.getParameter("content");
		
		BoardVO vo = new BoardVO();
		vo.setIdx(idx);
		vo.setTitle(title);
		vo.setContent(content);
		
		BoardDAO dao = new BoardDAO();
		
		int res= dao.setBoUpdateOk(vo,sw);
		
		if(res==1) {
			request.setAttribute("msg", "boUpdateOk");
		}
		else {
			request.setAttribute("mgs", "boUpdateNo");
		}
		request.setAttribute("url", request.getContextPath()+ "/boContent.bo?idx="+idx+"&sw="+sw);
	}

}
