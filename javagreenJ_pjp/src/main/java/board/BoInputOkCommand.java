package board;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class BoInputOkCommand implements BoardInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String mid = session.getAttribute("sMid") == null ? "" :(String) session.getAttribute("sMid");
		String nickName =session.getAttribute("sNickName") == null ? "" : (String) session.getAttribute("sNickName");
		
		ServletContext application = request.getServletContext();
		String realPath = application.getRealPath("/data/board");
		int maxSize = 1920 * 1280 * 10;		// 최대용량을 10MByte로 사용하고자 한다.
		String encoding = "UTF-8";
		
		MultipartRequest multipartRequest = new MultipartRequest(request, realPath, maxSize, encoding, new DefaultFileRenamePolicy());	// 객체 생성시 업로드 완료됨
		
		String fName = request.getParameter("fName");  // 외부 라이브러리를 사용하게되면 request객체로는 폼안의 자료들을 불러올 수 없다.
		String filesystemName = multipartRequest.getFilesystemName("fName");  // 실제로 서버에 저장되는 파일명
		
		String title = multipartRequest.getParameter("title");		
		String content = multipartRequest.getParameter("content");
		
		BoardVO vo = new BoardVO();
		vo.setMid(mid);
		vo.setNickName(nickName);
		vo.setTitle(title);
		vo.setContent(content);
		vo.setfName(filesystemName);
		
		BoardDAO dao = new BoardDAO();
		int res = dao.setBoInputOk(vo);
		
		if(res ==1) {
			request.setAttribute("msg", "boInputOk");
			request.setAttribute("url", request.getContextPath()+"/boList.bo");
		}
		else {
			request.setAttribute("msg", "boInputNo");
			request.setAttribute("url", request.getContextPath()+"/boInput.bo");
		}
	}
}
