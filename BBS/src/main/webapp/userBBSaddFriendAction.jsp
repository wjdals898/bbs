<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="friend.FriendDAO" %>
<%@ page import="java.io.PrintWriter" %>
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
		String writerID = null;
		if(session.getAttribute("writerID") != null){
			writerID = (String) session.getAttribute("writerID");
		}
		FriendDAO friendDAO = new FriendDAO();
		if( userID == null ){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		} else if(friendDAO.IDcheck(writerID, userID)) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 저장된 친구입니다.')");
			script.println("location.href = 'Userbbs.jsp?writerID="+request.getParameter("writerID")+"'");
			script.println("</script>");			
		}else {
			int result = friendDAO.addFriend(writerID, userID);
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
				script.println("location.href = 'Userbbs.jsp?writerID="+request.getParameter("writerID")+"'");
				script.println("</script>");		
				}
		}

	%>
</body>
</html>