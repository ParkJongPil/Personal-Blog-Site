package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conn.SecurityUtil;

public class MemUpdateOk2Command implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String mid = (String) session.getAttribute("sMid");
		
		String pwd = request.getParameter("pwd")==null? "" : request.getParameter("pwd");
		String nickName = request.getParameter("nickName")==null? "" : request.getParameter("nickName");
		String name = request.getParameter("name")==null? "" : request.getParameter("name");
		String name_ = name;
		String gender = request.getParameter("gender")==null? "" : request.getParameter("gender");
		String birthday = request.getParameter("birthday")==null? "" : request.getParameter("birthday");
		String tel = request.getParameter("tel")==null? "" : request.getParameter("tel");
		String address = request.getParameter("address")==null? "" : request.getParameter("address");
		String email = request.getParameter("email")==null? "" : request.getParameter("email");
		String homePage = request.getParameter("homePage")==null? "" : request.getParameter("homePage");
		String job = request.getParameter("job")==null? "" : request.getParameter("job");
		String content = request.getParameter("content")==null? "" : request.getParameter("content");
		String userInfor = request.getParameter("userInfor")==null? "" : request.getParameter("userInfor");
		
		String[] hobbys = request.getParameterValues("hobby");
		String hobby = "";
		if(hobbys.length != 0) {
			for(String strHobby : hobbys) {
				hobby += strHobby + "/";
			}
		}
		hobby = hobby.substring(0, hobby.lastIndexOf("/"));
		
		// 회원 사진이 업로드 되었는지의 여부 처리?
		String fileSystemName = "";
		String photo = request.getParameter("photo");
		if(photo.equals("noimage")) {
			fileSystemName = "noimage.jpg";
		}
		else {
			fileSystemName = photo;
		}
		
		MemberDAO dao = new MemberDAO();
		
		// DB에 저장될 각각의 필드길이를 체크.......(????)
		
		// 비밀번호 암호화처리(sha256)
		SecurityUtil security = new SecurityUtil();
		pwd = security.encryptSHA256(pwd);
		
		// 비밀번호가 정확할 경우에만 회원정보를 수정처리할 수 있게 한다.
		MemberVO vo = dao.getMemLoginOk(mid, pwd);
		if(vo.getNickName() == null) {
			request.setAttribute("msg", "passwordNo");
			request.setAttribute("url", request.getContextPath()+"/memUpdate.mem");
			return;
		}
		
		// 닉네임 중복체크를 다시한번 해준다.
//		name = dao.memNickCheck(nickName);
//		if(!name.equals("")) {  // 사용 불가한 닉네임
//			request.setAttribute("msg", "nickCheckNo");
//			request.setAttribute("url", request.getContextPath()+"/memJoin.mem");
//			return;
//		}
		
		// 모든 체크가 완료된 정확한 회원정보를 DB에 저장하기위해 vo객체에 담아서 dao로 전송한다.
		vo = new MemberVO();
		vo.setMid(mid);
		vo.setPwd(pwd);
		vo.setNickName(nickName);
		vo.setName(name_);
		vo.setGender(gender);
		vo.setBirthday(birthday);
		vo.setTel(tel);
		vo.setAddress(address);
		vo.setEmail(email);
		vo.setHobby(hobby);
		vo.setPhoto(fileSystemName);
		vo.setUserInfor(userInfor);
		
		int res = dao.setMemUpdateOk(vo);
		
		if(res == 1) {
			session.setAttribute("sNickName", nickName);
			request.setAttribute("msg", "memUpdateOk");
		}
		else {
			request.setAttribute("msg", "memUpdateNo");
		}
		request.setAttribute("url", request.getContextPath()+"/memMyPage.mem");
	}

}
