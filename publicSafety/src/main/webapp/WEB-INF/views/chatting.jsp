<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/sockjs/1/sockjs.min.js"></script>
<script type="text/javascript">

	var sock;
	sock = new SockJS("<c:url value="/echo"/>");
	//websocket을 지정한 URL로 연결 , 웹소켓 생성...생성자로 
	 
	//websocket 서버에서 메시지를 보내면 자동으로 실행된다.
	//websocket 과 연결을 끊고 싶을때 실행하는 메소드
	
	
	function disconnect() {
		
	}
	
	// 나가기 버튼 클릭시  작동 함수 소켓을 닫는다.

	function appendMessage(msg) {

		// 메세지 입력창에 msg를 하고 줄바꿈 처리
		$("#chatMessageArea").append(msg + "<br>");

		// 채팅창의 heigth를 할당
		var chatAreaHeight = $("#chatArea").height();

		// 쌓인 메세지의 height에서 채팅창의 height를 뺀다
		// 이를 이용해서 바로 밑에서 스크롤바의 상단여백을 설정한다
		var maxScroll = $("#chatMessageArea").height() - chatAreaHeight;

		/* .scrollTop(int) : Set the current vertical position of the scroll bar
		                     for each of the set of matched elements.*/
		// .scrollTop(int) : 파라미터로 들어간 px 만큼 top에 공백을 둔 채
		//                   스크롤바를 위치시킨다
		$("#chatArea").scrollTop(maxScroll);
	}
	
	function send() {
	        
	        var nickname = $("#nickname").val();
	        var msg = $("#message").val();
	        sock.send("msg:"+nickname+":" + msg);
	        $("#message").val("");
	    }

	//evt 파라미터는 websocket이 보내준 데이터다.
	function onMessage(evt) { //변수 안에 function자체를 넣음.
		var data = evt.data;
		 if (data.substring(0, 4) == "msg:") {
	            appendMessage(data.substring(4));
	        }
		/* sock.close(); */
	}
	
	function onOpen(evt) {
		sock.open;
		appendMessage("연결되었습니다.");
		sock.send("ROOMNUM::::"+$("#roomNum").val());
	}
	function onClose(evt) {
		sock.close();
		appendMessage("연결을 끊었습니다.");
		$("#data").append("연결 끊김");
	}

	$(document).ready(function() {
		$('#message').keypress(function(event){
			var keycode = (event.keyCode ? event.keyCode : event.which);
			 if(keycode == '13'){ // 엔터 키보드가 13
	                send(); 
	            }
			 event.stopPropagation(); /// 이벤트 발생 범위 한정하는 코드 
        });
        $('#sendBtn').click(function() { send(); });
        $('#enterBtn').click(function() { onOpen(); });
        $('#exitBtn').click(function() { onClose(); });
	});
	
</script>
<style>
#chatArea {
    width: 200px; height: 100px; overflow-y: auto; border: 1px solid black;
}
</style>
</head>
<body>
    이름:<input type="text" id="nickname"><br>
   방번호:<input type="text" id="roomNum">
    <input type="button" id="enterBtn" value="입장">
    <input type="button" id="exitBtn" value="나가기">
    
    <h1>대화 영역</h1>
    <div id="chatArea"><div id="chatMessageArea"></div></div>
    <br/>
    <input type="text" id="message">
    <input type="button" id="sendBtn" value="전송">
</body>
</html>

