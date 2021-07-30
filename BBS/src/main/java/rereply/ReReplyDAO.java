package rereply;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import rereply.ReReply;

public class ReReplyDAO {
	private Connection conn;
	private ResultSet rs;
	
	public ReReplyDAO() {
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
	
	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		} catch(Exception e) {
			e.printStackTrace();			
		}
		return ""; // 데이터베이스 오류
	}
	
	public int getNext() {
		String SQL = "SELECT rereplyID FROM REREPLY ORDER BY rereplyDate DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; // 첫 번째 댓글인 경우
		} catch(Exception e) {
			e.printStackTrace();			
		}
		return -1; // 데이터베이스 오류
	}
	
	public int write(int replyID, String userID, String reReplyContent) {
		String SQL = "INSERT INTO REREPLY VALUES (?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setInt(2, replyID);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, reReplyContent);
			pstmt.setInt(6, 1);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();			
		}
		return -1; // 데이터베이스 오류
	}
	
	public ArrayList<ReReply> getList(){
		String SQL = "SELECT * FROM REREPLY WHERE rereplyAvailable = 1 ORDER BY rereplyDate ASC";
		ArrayList<ReReply> list = new ArrayList<ReReply>();
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			//pstmt.setInt(1, getNext());
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ReReply rereply = new ReReply();
				rereply.setRereplyID(rs.getInt(1));
				rereply.setReplyID(rs.getInt(2));
				rereply.setUserID(rs.getString(3));
				rereply.setRereplyDate(rs.getString(4));
				rereply.setRereplyContent(rs.getString(5));
				rereply.setRereplyAvailable(rs.getInt(6));
				list.add(rereply);
			}
		} catch(Exception e) {
			e.printStackTrace();			
		}
		return list; 
	}
	
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM REREPLY WHERE rereplyID < ? AND rereplyAvailable = 1 ORDER BY rereplyDate ASC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			//pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				return true;
			}
		} catch(Exception e) {
			e.printStackTrace();			
		}
		return false; 
	}
	
	public ReReply getReReply(int reReplyID) {
		String SQL = "SELECT * FROM REREPLY WHERE rereplyID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, reReplyID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ReReply rereply = new ReReply();
				rereply.setReplyID(rs.getInt(1));
				rereply.setRereplyID(rs.getInt(2));
				rereply.setUserID(rs.getString(3));
				rereply.setRereplyDate(rs.getString(4));
				rereply.setRereplyContent(rs.getString(5));
				rereply.setRereplyAvailable(rs.getInt(6));
				return rereply;
			}
		} catch(Exception e) {
			e.printStackTrace();			
		}
		return null; 
	}
	
	public int update(int rereplyID, String rereplyContent) {
		String SQL = "UPDATE REREPLY SET rereplyContent = ? WHERE rereplyID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, rereplyContent);
			pstmt.setInt(2, rereplyID);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();			
		}
		return -1; // 데이터베이스 오류
	}
	
	public int delete(int rereplyID) {
		String SQL = "UPDATE REREPLY SET rereplyAvailable = 0 WHERE rereplyID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, rereplyID);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();			
		}
		return -1; // 데이터베이스 오류
	}
	
}
