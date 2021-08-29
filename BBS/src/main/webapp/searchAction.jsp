<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	if( userID == null ){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요.')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
	} else {
		if(request.getParameter("friendSearch").equals(""))
		{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('내용을 입력해주세요.')");
			script.println("history.back()");
			script.println("</script>");
		} else{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				if(request.getParameter("option").equals("1")) {
					script.println("location.href = 'IDSearch.jsp?content="+request.getParameter("friendSearch")+"'");
				}
				if(request.getParameter("option").equals("2")) {
					script.println("location.href = 'nameSearch.jsp?content="+request.getParameter("friendSearch")+"'");
				}
				if(request.getParameter("option").equals("3")) {
					script.println("location.href = 'phoneSearch.jsp?content="+request.getParameter("friendSearch")+"'");
				}
				if(request.getParameter("option").equals("4")) {
					script.println("location.href = 'emailSearch.jsp?content="+request.getParameter("friendSearch")+"'");
				}
				script.println("</script>");
		}
	}
	%>
</body>
</html>