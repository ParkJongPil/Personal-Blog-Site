package board;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class BoContentCommand implements BoardInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null ? 0 : Integer.parseInt(request.getParameter("idx"));
		//int pag = request.getParameter("pag")==null ? 1 : Integer.parseInt(request.getParameter("pag"));
		//int pageSize = request.getParameter("pageSize")==null ? 5 : Integer.parseInt(request.getParameter("pageSize"));
		String flag = request.getParameter("flag")==null? "": request.getParameter("flag");
		String search = request.getParameter("search")==null? "": request.getParameter("search");
		String searchString = request.getParameter("searchString")==null? "": request.getParameter("searchString");
		int sw = request.getParameter("sw") ==null? 0 : Integer.parseInt(request.getParameter("sw"));
		
		BoardDAO dao = new BoardDAO();
		
		// 글 조회수 1회 증가시키기(조회수 중복방지처리 -세션 사용 : 'board+고유번호'를 객체 배열에 추가시킨다.)
		HttpSession session = request.getSession();
		ArrayList<String>  contentIdx = (ArrayList)session.getAttribute("sContentIdx");
		if(contentIdx == null) {
			contentIdx = new ArrayList<String>();
		}
		String imsiContentIdx = "board" + idx;
		if(!contentIdx.contains(imsiContentIdx)) {
			dao.setReadNum(idx);
			contentIdx.add(imsiContentIdx);
		}
		session.setAttribute("sContentIdx", contentIdx);
		
		// 현재 선택된 게시된 글(idx)의 전체 내용물 가져오기
		BoardVO vo = dao.getBoContent(idx,sw);
		
		request.setAttribute("vo", vo);
		//request.setAttribute("pag", pag);
		//request.setAttribute("pageSize", pageSize);
		request.setAttribute("flag", flag);
		request.setAttribute("search", search);
		request.setAttribute("searchString", searchString);
		request.setAttribute("sw", sw);
		
		// 이전글과 다음글 처리(이전글/다음글의 타이틀을 가져온다.)
		BoardVO preVo= dao.getPreNextSearch("pre",idx);
		BoardVO nextVo= dao.getPreNextSearch("next",idx);
		request.setAttribute("preVo", preVo);
		request.setAttribute("nextVo", nextVo);
		
		// 입력된 댓글 가져오기
		ArrayList<BoardReplyVO> replyVos = dao.getBoardReply(idx);
		request.setAttribute("replyVos", replyVos);
		
		// 댓글 수정처리를 위한 작업(replyIdx를 가지고, 댓글의 content를 가져와서 다시 전송 시킨다.)
		int replyIdx = request.getParameter("replyIdx")==null ? 0 : Integer.parseInt(request.getParameter("replyIdx"));
		if(replyIdx != 0) {
			String replyContent= dao.getReplyContent(replyIdx);
			request.setAttribute("replyIdx", replyIdx);
			request.setAttribute("replyContent", replyContent);
		}
	}

}
