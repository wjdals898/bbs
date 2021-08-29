<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
    
<%@ page import="rereply.ReReplyDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="rereply" class="rereply.ReReply" scope="page" />
<jsp:setProperty name="rereply" property="rereplyContent" />
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
			if(rereply.getRereplyContent() == null)
			{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('내용을 입력해주세요.')");
				script.println("history.back()");
				script.println("</script>");
			} else{
				ReReplyDAO rereplyDAO = new ReReplyDAO();
				int result = rereplyDAO.write(Integer.parseInt(request.getParameter("replyID")), userID, rereply.getRereplyContent());
				if(result == -1 ){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('대댓글 작성에 실패했습니다')");
					script.println("history.back()");
					script.println("</script>");	
				} else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'view.jsp?bbsID="+request.getParameter("bbsID")+"'");
					script.println("</script>");		
				}
			}
		}
	%>
</body>
</html>