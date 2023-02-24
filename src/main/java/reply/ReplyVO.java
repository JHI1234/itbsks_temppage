package reply;

import java.sql.Timestamp;

public class ReplyVO {
	private int rnum;
	private String rwriter;
	private String reply;
	private Timestamp rreg_date;
	private int ref;
	
	public int getRnum() {
		return rnum;
	}
	public void setRnum(int rnum) {
		this.rnum = rnum;
	}
	public String getRwriter() {
		return rwriter;
	}
	public void setRwriter(String rwriter) {
		this.rwriter = rwriter;
	}
	public String getReply() {
		return reply;
	}
	public void setReply(String reply) {
		this.reply = reply;
	}
	public Timestamp getReg_date() {
		return rreg_date;
	}
	public void setReg_date(Timestamp reg_date) {
		this.rreg_date = reg_date;
	}
	public int getRef() {
		return ref;
	}
	public void setRef(int ref) {
		this.ref = ref;
	}

	
	
}
