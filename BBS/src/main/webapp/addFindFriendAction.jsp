<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="friend.FriendDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		String findID = request.getParameter("id");
		
		FriendDAO friendDAO = new FriendDAO();
		
		if( userID == null ){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		} else if(friendDAO.IDcheck(findID, userID)) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 저장된 친구입니다.')");
			script.println("history.back()");
			script.println("</script>");			
		}else {
			int result = friendDAO.addFriend(findID, userID);
			if(result == -1 ){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('친구저장에 실패했습니다')");
				script.println("history.back()");					
				script.println("</script>");	
			} else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('친구목록에 저장했습니다')");
				script.println("history.back()");
				script.println("</script>");		
				}
		}

	%>
</body>
</html>