<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="friend.Friend" %>
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
		if( userID == null ){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}
		String friendID = "";
		if(request.getParameter("friendID") != null){
			friendID = request.getParameter("friendID");
		}
		if(friendID == ""){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 아이디입니다')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		Friend friend = new FriendDAO().getFriend(userID);
		if(!userID.equals(friend.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		} else {
				FriendDAO friendDAO = new FriendDAO();
				int result = friendDAO.delete(friendID);
				if(result == -1 ){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('아이디 삭제에 실패했습니다')");
					script.println("history.back()");
					script.println("</script>");	
				} else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'friendlist.jsp'");
					script.println("</script>");		
					}
		}
		

	%>
</body>
</html>