package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import reply.Reply;

public class UserDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS";
			String dbID ="root";
			String dbPassword = "hjm4973";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
	}	
	
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1; // 로그인 성공
				}
				else 
					return 0; //비밀번호 불일치
			}
			return -1; // 아이디가 없음
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -2; //데이터베이스 오류
	}
	
	public int join(User user) {
		String SQL = "INSERT INTO USER VALUES (?, ?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			pstmt.setString(6, user.getUserPhone());
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이 오류
	}
	
	public User getUser(String userID) {
		String SQL = "SELECT * FROM user WHERE userID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				User user = new User();
				user.setUserID(rs.getString(1));
				user.setUserPassword(rs.getString(2));
				user.setUserName(rs.getString(3));
				user.setUserGender(rs.getString(4));
				user.setUserEmail(rs.getString(5));
				user.setUserPhone(rs.getString(6));
				return user;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(String userID, String userName, String userGender, String userEmail, String userPhone) {
		String SQL = "UPDATE USER SET userName = ?, userGender = ?, userEmail = ?, userPhone = ? WHERE userID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userName);
			pstmt.setString(2, userGender);
			pstmt.setString(3, userEmail);
			pstmt.setString(4, userPhone);
			pstmt.setString(5, userID);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public int delete(String userID) {
		String SQL = "DELETE FROM user WHERE userID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public ArrayList<User> IDSearchList(String text, String userID){
		text='%'+text+'%';
		String SQL = "SELECT userName, userID, userEmail, userPhone FROM USER WHERE userID LIKE ?";
		ArrayList<User> list = new ArrayList<User>();
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, text);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				User user = new User();
				if(!rs.getString(2).equals(userID)) {
					user.setUserName(rs.getString(1));
					user.setUserID(rs.getString(2));
					user.setUserEmail(rs.getString(3));
					user.setUserPhone(rs.getString(4));
					list.add(user);
				}
			}
		} catch(Exception e) {
			e.printStackTrace();			
		}
		return list; 
	}
	
	public ArrayList<User> nameSearchList(String text, String userID){
		text='%'+text+'%';
		String SQL = "SELECT userName, userID, userEmail, userPhone FROM USER WHERE userName like ?";
		ArrayList<User> list = new ArrayList<User>();
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, text);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				User user = new User();
				if(!rs.getString(2).equals(userID)) {
					user.setUserName(rs.getString(1));
					user.setUserID(rs.getString(2));
					user.setUserEmail(rs.getString(3));
					user.setUserPhone(rs.getString(4));
					list.add(user);
				}
			}
		} catch(Exception e) {
			e.printStackTrace();			
		}
		return list; 
	}
	
	public ArrayList<User> emailSearchList(String text, String userID){
		text='%'+text+'%';
		String SQL = "SELECT userName, userID, userEmail, userPhone FROM USER WHERE userEmail like ?";
		ArrayList<User> list = new ArrayList<User>();
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, text);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				User user = new User();
				if(!rs.getString(2).equals(userID)) {
					user.setUserName(rs.getString(1));
					user.setUserID(rs.getString(2));
					user.setUserEmail(rs.getString(3));
					user.setUserPhone(rs.getString(4));
					list.add(user);
				}
			}
		} catch(Exception e) {
			e.printStackTrace();			
		}
		return list; 
	}

	public ArrayList<User> phoneSearchList(String text, String userID){
		text='%'+text+'%';
		String SQL = "SELECT userName, userID, userEmail, userPhone FROM USER WHERE userPhone like ?";
		ArrayList<User> list = new ArrayList<User>();
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, text);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				User user = new User();
				if(!rs.getString(2).equals(userID)) {
					user.setUserName(rs.getString(1));
					user.setUserID(rs.getString(2));
					user.setUserEmail(rs.getString(3));
					user.setUserPhone(rs.getString(4));
					list.add(user);
				}
			}
		} catch(Exception e) {
			e.printStackTrace();			
		}
		return list; 
	}
}
