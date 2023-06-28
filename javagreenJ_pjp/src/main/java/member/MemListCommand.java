package member;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MemListCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MemberDAO dao = new MemberDAO();
		
		// 회원 목록 확인 가능
		ArrayList<MemberVO> vos = dao.getMemList();
		
		request.setAttribute("vos", vos);
		request.setAttribute("curScrStartNo", vos.size());
	}

}
