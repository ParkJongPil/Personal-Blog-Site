package member;

public class MemberVO {
	private int idx;
	private String mid;
	private String pwd;
	private String nickName;
	private String name;
	private String email;
	private String gender;
	private String birthday;
	private String tel;
	private String address;
	private String hobby;
	private String userInfor;
	private String userDel;
	private String photo;
	private int visitCnt;
	private String startDate;
	private String lastDate;
	private int todayCnt;
	private int applyDiff; //날짜 차이를 저장하는 필드
	
	private String follower;	// 내가 팔로우 하는 사람
	private String following;	// 나를 팔로우 하는 사람
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getHobby() {
		return hobby;
	}
	public void setHobby(String hobby) {
		this.hobby = hobby;
	}
	public String getUserInfor() {
		return userInfor;
	}
	public void setUserInfor(String userInfor) {
		this.userInfor = userInfor;
	}
	public String getUserDel() {
		return userDel;
	}
	public void setUserDel(String userDel) {
		this.userDel = userDel;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public int getVisitCnt() {
		return visitCnt;
	}
	public void setVisitCnt(int visitCnt) {
		this.visitCnt = visitCnt;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getLastDate() {
		return lastDate;
	}
	public void setLastDate(String lastDate) {
		this.lastDate = lastDate;
	}
	public int getTodayCnt() {
		return todayCnt;
	}
	public void setTodayCnt(int todayCnt) {
		this.todayCnt = todayCnt;
	}
	public int getApplyDiff() {
		return applyDiff;
	}
	public void setApplyDiff(int applyDiff) {
		this.applyDiff = applyDiff;
	}
	public String getFollower() {
		return follower;
	}
	public void setFollower(String follower) {
		this.follower = follower;
	}
	public String getFollowing() {
		return following;
	}
	public void setFollowing(String following) {
		this.following = following;
	}
	@Override
	public String toString() {
		return "MemberVO [idx=" + idx + ", mid=" + mid + ", pwd=" + pwd + ", nickName=" + nickName + ", name=" + name
				+ ", email=" + email + ", gender=" + gender + ", birthday=" + birthday + ", tel=" + tel + ", address=" + address
				+ ", hobby=" + hobby + ", userInfor=" + userInfor + ", userDel=" + userDel + ", photo=" + photo + ", visitCnt="
				+ visitCnt + ", startDate=" + startDate + ", lastDate=" + lastDate + ", todayCnt=" + todayCnt + ", applyDiff="
				+ applyDiff + ", follower=" + follower + ", following=" + following + "]";
	}
	
	
}
