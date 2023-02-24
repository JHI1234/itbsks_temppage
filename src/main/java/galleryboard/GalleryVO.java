package galleryboard;

import java.sql.Timestamp;

public class GalleryVO {
	
	private int gnum;
	private String gtitle;
	private Timestamp greg_date;
	private String gimage;
	
	public int getGnum() {
		return gnum;
	}
	public void setGnum(int gnum) {
		this.gnum = gnum;
	}
	public String getGtitle() {
		return gtitle;
	}
	public void setGtitle(String gtitle) {
		this.gtitle = gtitle;
	}
	public Timestamp getGreg_date() {
		return greg_date;
	}
	public void setGreg_date(Timestamp greg_date) {
		this.greg_date = greg_date;
	}
	public String getGimage() {
		return gimage;
	}
	public void setGimage(String gimage) {
		this.gimage = gimage;
	}


	
	
}
