package filter;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/filter/test1")
public class Test1 extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		request.setCharacterEncoding("utf-8");
//		response.setContentType("text/html; charset=utf-8");
		
		String name = request.getParameter("name")==null? "" : request.getParameter("name");
		String gender = request.getParameter("gender")==null? "" : request.getParameter("gender");
		int age = request.getParameter("age")==null? 20 : Integer.parseInt(request.getParameter("age"));
		
		PrintWriter out = response.getWriter();
		
		out.println("<p>성명 : "+name+"</p>") ;
		out.println("<p>성별 : "+gender+"</p>");
		out.println("<p>나이 : "+age+"</p>");
		out.println("<p><a href='"+request.getContextPath()+"/0421/filter/test1.jsp'>돌아가기</a></p>");
	}
}
