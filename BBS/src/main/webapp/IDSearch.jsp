<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1" >
<link rel="stylesheet" href="css/bootstrap.css" >
<link rel="stylesheet" href="css/custom.css" >
<title>JSP 게시판 웹 사이트</title>
<style type="text/css">
	a, a:hover {
		color : #000000;
		text-decoration : none;
	}
</style>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		int pageNumber = 1;
		if(request.getParameter("pageNumber") != null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
	  		<button type="button" class="navbar-toggle collapsed"
	  			data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
	  			aria-expanded="false">
	  			<span class="icon-bar"></span>
	  			<span class="icon-bar"></span>
	  			<span class="icon-bar"></span>
	  		</button>
	  		<a class="navbar-brand" href="main.jsp">JSP 게시판 웹 사이트</a>
	  	</div>
	  	<%
	  		if(userID==null) {
	  	%>
	  	<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
	  		<ul class="nav navbar-nav">
	  			<li><a href="main.jsp">메인</a></li>
	  			<li><a href="bbs.jsp">전체 게시판</a></li>
	  		</ul>
	  	<%
	  		} else {
	  	%>
	  	<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
	  		<ul class="nav navbar-nav">
	  			<li><a href="main.jsp">메인</a></li>
	  			<li class="active"><a href="findFriend.jsp">친구 검색</a></li>
	  			<li><a href="bbs.jsp">전체 게시판</a></li>
	  			<li><a href="mybbs.jsp">마이 게시판</a></li> <!-- 개인 게시판 Mybbs.jsp예정 -->
	  			<li><a href="HOTbbs.jsp">핫 게시판</a></li>
	  		</ul>
	  	
	  	<%
	  		}
	  	%>
	  		<%
	  			if(userID == null) {
	  			
	  		%>
	  		<ul class="nav navbar-nav navbar-right">
	  			<li class="dropdown">
	  				<a href="#" class="dropdown-toggle"
	  					data-toggle="dropdown" role="button" aria-haspopup="true"
	  					aria-expanded="false">접속하기<span class="caret"></span></a>
	  				<ul class="dropdown-menu">
	  					<li><a href="login.jsp">로그인</a></li>
	  					<li><a href="join.jsp">회원가입</a></li>
	  				</ul>
	  			</li>
	  		</ul>
	  		<%
	  			} else {
	  				
			%>
			<ul class="nav navbar-nav navbar-right">
	  			<li class="dropdown">
	  				<a href="#" class="dropdown-toggle"
	  					data-toggle="dropdown" role="button" aria-haspopup="true"
	  					aria-expanded="false"><%= userID %>님의 회원관리<span class="caret"></span></a>
	  				<ul class="dropdown-menu">
	  					<li><a href="logoutAction.jsp">로그아웃</a></li>
	  					<li><a href="privacy.jsp">개인정보</a></li>
	  					<li><a href="friendlist.jsp">친구관리</a></li>
	  					<li class="active"><a href="findFriend.jsp">친구검색</a>
	  				</ul>
	  			</li>
	  		</ul>
			<%
	  			}
			%>
	  	</div>
	</nav>
	
	<%
		UserDAO userDAO = new UserDAO();
		ArrayList<User> sList = userDAO.IDSearchList(request.getParameter("content"), userID);
		int n = sList.size();
	%>
	
	<div class="container" >
		<div class="jumbotron" style="margin:0;">
			<div class="container">
				<h1>아이디 검색</h1>
				<div>
					<form method="post" action="searchAction.jsp?option=1" style="display:flex; justify-content:left; margin-top:30px;">
						<input type="text" class="form-control" name="friendSearch" id="content" maxlength="40" style="margin-left:30px; width:650px">
						<input type="submit" id="id_Search" class="btn btn-primary" style="margin-left:30px;" value="검색">
					</form>
				</div>
				<div style="display:flex; justify-content:center; margin-top:50px; font-size:1.5em;">총 (<%= n %>)건의 검색 결과</div>
			
				<div class="row" style="margin:20px;">
					<table class="table table-striped" style="text-align:center; border: 1px solid #dddddd;">
						<thead>
							<tr style="font-weight:bold;">
								<td>이름</td>
								<td>아이디</td>
								<td>이메일</td>
								<td>전화번호</td>
								<td> </td>
							</tr>
						</thead>
						<tbody>
							<%
								for(int i=0; i<sList.size(); i++){
									if(!sList.get(i).getUserID().equals(userID)){
							%>
							<tr>
								<td><%= sList.get(i).getUserName() %></td>
								<td><%= sList.get(i).getUserID() %></td>
								<td><%= sList.get(i).getUserEmail() %></td>
								<td><%= sList.get(i).getUserPhone() %></td>
								<td><a href="addFindFriendAction.jsp?id=<%= sList.get(i).getUserID() %>" class="btn btn-primary" >추가</a></td>
							</tr>
							<%
									}
								}
							%>
						</tbody>
					</table>
				</div>
				<div>
					<a href="findFriend.jsp" class="btn btn-primary">이전</a> 
				</div>
			</div>
		</div>
	</div>
	
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>