package board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BoReplyUpdateOkCommand implements BoardInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx") == null ? 0 : Integer.parseInt(request.getParameter("idx"));
		String content = request.getParameter("content")== null ? "" : request.getParameter("content");
		
		BoardDAO dao = new BoardDAO();
		
		String res = dao.setReplyUpdateOk(idx, content);
		
		response.getWriter().write(res);
			
	}

}
