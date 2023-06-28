package member;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MemFollowCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String aMid = (String) session.getAttribute("sMid");
		
		MemberDAO dao = new MemberDAO();
		
		//내가 팔로우 하는 사람들 목록
		ArrayList<MemberVO> vos = dao.getFollowList(aMid);
		
		
		request.setAttribute("vos", vos);
		request.setAttribute("curScrStartNo", vos.size());
	}

}
