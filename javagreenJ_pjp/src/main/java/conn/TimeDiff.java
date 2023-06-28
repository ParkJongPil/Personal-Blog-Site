package conn;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

// 오늘(현재) 날짜와 DB의 날짜간의 시간차이를 계산하여 돌려주는 클래스
public class TimeDiff {
	// 1. '오늘 날짜(1)'와 'DB의 날짜(2)'를 '문자' 형식으로 변경시킨다.	- 날짜 형식 기호에 맞도록 설계할것
	// 2. 날짜 연산을 위해서 다시 '날짜' 형식으로 변경한다.
	// 3. 날짜차이를 시간(24시간제)으로 계산하기 위해 '숫자'형식으로 변환
	
	// 외부로부터 날짜를 입력받아서 연산처리한 후 다시 정수값으로 돌려준다.
	public int timeDiff(String wCdate) {
		//1-1. 날짜 형식을 문자(202205111245)형식으로 맞추기 위한 준비작업
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm"); // hh: 12시간제(AM/PM), HH: 24시간제
		String strToday = sdf.format(cal.getTime());
	
		// 2-1. 날짜 연산을 위해서 문자형식의 날짜를 날짜 형식으로 변경시켜준다.
		Date today = null;
		try {
		  today = sdf.parse(strToday);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		//                   0         1         2
		//                   012345678901234567890
		// 									 2022-05-11 13:05:25.7
		// 1-2. DB에 저장된 날짜(2022-05-11 13:05:25.7)를 앞에 작업한 오늘 날짜와 같은 포맷형식(yyyyMMddHHmm)으로 처리한다.
		String strWCdate = wCdate.substring(0,4)+wCdate.substring(5,7)+wCdate.substring(8,10)+wCdate.substring(11,13)+wCdate.substring(14,16);
		
		// 2-2. 날짜 연산을 위해 DB에서 가져온 문자변환 형식 자료를 날짜 형식으로 변환 한다.
		Date dateWdate = null;
		try {
			dateWdate = sdf.parse(strWCdate);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		// 3. 날짜 형식으로 변경된 두 자료(today/dateWdate)를 숫자형식(getTime())으로 변경처리한다.(시간으로 연산처리 하기위함) : 결과값 ms(1/1000)형식으로 반환한다.
		long diffTime = (today.getTime() - dateWdate.getTime())	/ (60 * 60 * 1000)+1;
		
		return (int) diffTime;
	}
	
}