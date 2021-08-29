<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="friend.FriendDAO" %>
<%@ page import="friend.Friend" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1" >
<link rel="stylesheet" href="css/bootstrap.css" >
<link rel="stylesheet" href="css/custom.css" >
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
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
	  		if(userID == null) {
	  	%>
	  	
	  	<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
	  		<ul class="nav navbar-nav">
	  			<li class="active"><a href="main.jsp">메인</a></li>
	  			<li><a href="bbs.jsp">전체 게시판</a></li>
	  		</ul>
	  	<%
	  		} else {
	  	%>
	  	<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
	  		<ul class="nav navbar-nav">
	  			<li><a href="main.jsp">메인</a></li>
	  			<li class="active"><a href="friendlist.jsp">친구목록수정</a></li>
	  			<li><a href="bbs.jsp">전체 게시판</a></li>
	  			<li><a href="mybbs.jsp">마이 게시판</a></li> <!-- 개인 게시판 Mybbs.jsp예정 -->
	  			<li><a href="HOTbbs.jsp">핫 게시판</a></li> <!-- 핫 게시판 HOTbbs.jsp예정 -->
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
	  					<li class="active"><a href="friendlist.jsp">친구관리</a></li>
	  					<li><a href="findFriend.jsp">친구검색</a></li>
	  				</ul>
	  			</li>
	  		</ul>
			<%
	  			}
			%>
	  	</div>
	</nav>
	<div class="container">
		<div class="jumbotron">
			<div class="container">
				<h1>친구목록</h1>
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd" >
				<thead>
					<tr>
						<th style="background-color : #eeeeee; text-align: center;">아이디</th>
						<th style="background-color : #eeeeee; text-align: center;">이름</th>
						<th style="background-color : #eeeeee; text-align: center;">전화번호</th>
						<th style="background-color : #eeeeee; text-align: center;">이메일</th>
						<th style="background-color : #eeeeee; text-align: center;">숨김 / 삭제</th>
					</tr>
				</thead>
				<tbody>
					<%
						FriendDAO friendDAO = new FriendDAO();
						ArrayList<Friend> list = friendDAO.getList(userID);
						for(int i=0; i<list.size(); i++){
					%>
					<tr>
						<td><%= list.get(i).getFriendID() %></td>
						<td><%= list.get(i).getFriendName() %></td>
						<td><%= list.get(i).getFriendPhone() %></td>
						<td><%= list.get(i).getFriendEmail() %></td>
						<td>
							<a class="btn btn-primary btn-pull" href="friendlisthideAction.jsp?friendID=<%=list.get(i).getFriendID() %>" role="button">숨김</a>
							<a class="btn btn-primary btn-pull" href="friendlistdeleteAction.jsp?friendID=<%=list.get(i).getFriendID()%>" role="button">삭제</a>
						</td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
				<p><a class="btn btn-primary btn-pull"href="friendlist.jsp" role="button">친구목록 수정 완료</a></p>
			</div>
		</div>
	</div>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>