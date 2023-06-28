package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import conn.SecurityUtil;

public class MemJoinOkCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid =request.getParameter("mid") == null? "" : request.getParameter("mid");
		String pwd =request.getParameter("pwd") == null? "" : request.getParameter("pwd");
		String nickName=request.getParameter("nickName") == null? "" : request.getParameter("nickName");
		String name=request.getParameter("name") == null? "" : request.getParameter("name");
		String name_=name;
		String email=request.getParameter("email") == null? "" : request.getParameter("email");
		String gender=request.getParameter("gender") == null? "" : request.getParameter("gender");
		String birthday=request.getParameter("birthday") == null? "" : request.getParameter("birthday");
		String tel=request.getParameter("tel") == null? "" : request.getParameter("tel");
		String address=request.getParameter("address") == null? "" : request.getParameter("address");
		String userInfor=request.getParameter("userInfor") == null? "" : request.getParameter("userInfor");
		
		String[] hobbys = request.getParameterValues("hobby");
		String hobby = "";
		if(hobbys.length != 0) {
			for(String strHobby : hobbys) {
				hobby += strHobby + "/";
			}
		}
		hobby = hobby.substring(0, hobby.lastIndexOf("/"));
		
		// 회원 사진이 업로드 되었는지 여부 처리
		String fileSystemName = "";
		String photo = request.getParameter("photo");
		if(photo.equals("noimage")) {
			fileSystemName = "noimage.jpg";
		}
		else {
			fileSystemName = photo;
		}
		// 아이디와 닉네임 중복체크를 다시한번 해준다.
		MemberDAO dao = new MemberDAO();
		
		name = dao.memIdCheck(mid);
		if(!name.equals("")) { // 사용 불가한 아이디
			request.setAttribute("msg", "idCheckNo");
			request.setAttribute("url", request.getContextPath()+"/memJoin.mem");
			return;
		}
		
		name = dao.memNickCheck(nickName);
		if(!name.equals("")) { //사용 불가한 닉네임
			request.setAttribute("msg", "nickCheckNo");
			request.setAttribute("url", request.getContextPath()+"/memJoin.mem");
			return;
		}
		// DB에 저장할 각각의 필드길이를  체크함
		
		
		// 비밀번호 암호화 처리(SHA256)
		SecurityUtil security = new SecurityUtil();
		pwd = security.encryptSHA256(pwd);
		
		// 모든 체크가 완료된 정확한 회원정보를 DB에 저장하기 위해 VO객체에 담아서 DAO로 전송한다.
		MemberVO vo = new MemberVO();
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
		
		int res = dao.setMemJoinOk(vo);
		
		if(res ==1) {
			request.setAttribute("msg", "memJoinOk");
			request.setAttribute("url", request.getContextPath()+"/memLogin.mem");
		}
		else {
			request.setAttribute("msg", "memJoinNo");
			request.setAttribute("url", request.getContextPath()+"/memJoin.mem");
		}
		
	}

}
