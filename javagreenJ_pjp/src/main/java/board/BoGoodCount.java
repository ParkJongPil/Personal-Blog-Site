package board;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/boGoodCount")
public class BoGoodCount extends HttpServlet{
	@Override
	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx= request.getParameter("idx")==null ? 0 : Integer.parseInt(request.getParameter("idx"));
		
		BoardDAO dao = new BoardDAO();
		
		//좋아요수 증가처리하기
		HttpSession session = request.getSession();
		ArrayList<String>  goodtIdx = (ArrayList)session.getAttribute("sGoodIdx");
		if(goodtIdx ==null) {
			goodtIdx = new ArrayList<String>();
		}
		String imsiGoodIdx = "good" + idx;
		if(!goodtIdx.contains(imsiGoodIdx)) {
			dao.setGoodCount(idx);
			goodtIdx.add(imsiGoodIdx);
		}
		session.setAttribute("sGoodIdx", goodtIdx);
		
	}
	}
