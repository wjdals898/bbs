package friend;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class FriendDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public FriendDAO() {
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
	
	public Friend getFriend(String userID) {
		String SQL = "SELECT * FROM FRIEND WHERE userID =?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Friend friend = new Friend();
				friend.setFriendID(rs.getString(1));
				friend.setUserID(rs.getString(2));
				friend.setFriendName(rs.getString(3));
				friend.setFriendEmail(rs.getString(4));
				friend.setFriendPhone(rs.getString(5));
				friend.setFriendAvailable(rs.getInt(6));
				friend.setFriendNum(rs.getInt(7));
				return friend;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public ArrayList<String> getFriendInform(String friendID, String userID) {
		//String SQL = "SELECT DISTINCT U.userName, U.userPhone, U.userEmail FROM USER U INNER JOIN BBS B ON B.userID = ? AND U.userID = ?";
		String SQL = "SELECT userName, userPhone, userEmail FROM USER WHERE userID = ?";
		ArrayList<String> list = new ArrayList<String>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, friendID);
			//pstmt.setString(2, friendID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				list.add(friendID);
				list.add(userID);
				list.add(rs.getString(1));
				list.add(rs.getString(2));
				list.add(rs.getString(3));
				list.add("1");
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<String> getBeFriendInform(String friendID, String userID) {
		String SQL = "SELECT DISTINCT U.userName, U.userPhone, U.userEmail FROM USER U INNER JOIN USER_FRIEND F ON F.friendID = ? AND U.userID = ?";
		ArrayList<String> list = new ArrayList<String>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, friendID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				list.add(userID);
				list.add(friendID);
				list.add(rs.getString(1));
				list.add(rs.getString(2));
				list.add(rs.getString(3));
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<BeFriend> getBeFriendList(String friendID, String userID){
		ArrayList<BeFriend> list = new ArrayList<BeFriend>();
		try {
			BeFriend befriend = new BeFriend();
			befriend.setUserID(getBeFriendInform(friendID, userID).get(1));
			befriend.setFriendID(getBeFriendInform(friendID, userID).get(2));
			befriend.setFriendName(getBeFriendInform(friendID, userID).get(3));
			befriend.setFriendPhone(getBeFriendInform(friendID, userID).get(4));
			befriend.setFriendEmail(getBeFriendInform(friendID, userID).get(5));
			list.add(befriend);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public int getNext() {
		String SQL = "SELECT friendNum FROM FRIEND ORDER BY friendNum DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; // 첫 번째 게시물인 경우
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public ArrayList<Friend> getList(String userID){
		String SQL = "SELECT * FROM FRIEND WHERE userID = ? AND friendAvailable = 1";
		ArrayList<Friend> list = new ArrayList<Friend>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Friend friend = new Friend();
				friend.setFriendID(rs.getString(1));
				friend.setUserID(rs.getString(2));
				friend.setFriendName(rs.getString(3));
				friend.setFriendEmail(rs.getString(4));
				friend.setFriendPhone(rs.getString(5));
				friend.setFriendAvailable(rs.getInt(6));
				friend.setFriendNum(rs.getInt(7));
				list.add(friend);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public int delete(String friendID) {
		String SQL = "DELETE FROM FRIEND WHERE friendID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, friendID);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public int addFriend(String friendID, String userID) {
		String SQL = "INSERT INTO FRIEND VALUES (?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, friendID);
			pstmt.setString(2, userID);
			pstmt.setString(3, getFriendInform(friendID, userID).get(2));
			pstmt.setString(4, getFriendInform(friendID, userID).get(4));
			pstmt.setString(5, getFriendInform(friendID, userID).get(3));
			pstmt.setInt(6, 1);
			pstmt.setInt(7, getNext());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public boolean IDcheck(String friendID, String userID) {
		String SQL = "SELECT friendID FROM FRIEND WHERE userID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				if(rs.getString(1).equals(friendID)) {
					return true;
				}
			}
		}  catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public int hide(String friendID) {
		String SQL = "UPDATE FRIEND SET friendAvailable = 0 WHERE friendID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, friendID);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	public ArrayList<Friend> getHideList(String userID){
		String SQL = "SELECT * FROM FRIEND WHERE userID = ? AND friendAvailable = 0";
		ArrayList<Friend> list = new ArrayList<Friend>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Friend friend = new Friend();
				friend.setFriendID(rs.getString(1));
				friend.setUserID(rs.getString(2));
				friend.setFriendName(rs.getString(3));
				friend.setFriendEmail(rs.getString(4));
				friend.setFriendPhone(rs.getString(5));
				friend.setFriendAvailable(rs.getInt(6));
				friend.setFriendNum(rs.getInt(7));
				list.add(friend);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public int display(String friendID) {
		String SQL = "UPDATE FRIEND SET friendAvailable = 1 WHERE friendID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, friendID);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	public ArrayList<Friend> getBeFriendList(String userID){
		String SQL = "SELECT * FROM FRIEND WHERE friendID = ? AND userID != ? AND friendAvailable = 1";
		ArrayList<Friend> list = new ArrayList<Friend>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, userID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Friend friend = new Friend();
				friend.setFriendID(rs.getString(1));
				friend.setUserID(rs.getString(2));
				friend.setFriendName(rs.getString(3));
				friend.setFriendEmail(rs.getString(4));
				friend.setFriendPhone(rs.getString(5));
				friend.setFriendAvailable(rs.getInt(6));
				friend.setFriendNum(rs.getInt(7));
				list.add(friend);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;		
	}
	
	
	
}
