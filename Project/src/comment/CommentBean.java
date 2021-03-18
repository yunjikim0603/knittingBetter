package comment;

import java.sql.Timestamp;

public class CommentBean {
	private int comm_num;
	private int board_num;
	private String comm_id;
	private String comm_content;
	private Timestamp comm_date;
	
	
	
	public int getComm_num() {
		return comm_num;
	}
	public void setComm_num(int comm_num) {
		this.comm_num = comm_num;
	}
	public int getBoard_num() {
		return board_num;
	}
	public void setBoard_num(int board_num) {
		this.board_num = board_num;
	}
	public String getComm_id() {
		return comm_id;
	}
	public void setComm_id(String comm_id) {
		this.comm_id = comm_id;
	}

	public String getComm_content() {
		return comm_content;
	}
	public void setComm_content(String comm_content) {
		this.comm_content = comm_content;
	}
	
	public Timestamp getComm_date() {
		return comm_date;
	}
	public void setComm_date(Timestamp comm_date) {
		this.comm_date = comm_date;
	}
	
	
	
	
	
}
