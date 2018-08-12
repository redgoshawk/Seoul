<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>

<!-- 소켓, jquery -->
<script type="text/javascript" src="resources/sockjs-0.3.4.js"></script>
<script type="text/javascript" src="resources/jquery-3.3.1.min.js"></script>

<!-- 폰트 관련 임포트  -->
<link href="http://fonts.googleapis.com/earlyaccess/nanumgothic.css"
	rel="stylesheet">
<link href="http://fonts.googleapis.com/earlyaccess/hanna.css"
	rel="stylesheet">
<link href="http://fonts.googleapis.com/earlyaccess/notosanskr.css"
	rel="stylesheet">


<!-- 부트스트랩+css -->
<link rel="stylesheet" type="text/css" href="css/custom.css" />
<script type="text/javascript" src="resources/js/bootstrap.js"></script>
<link rel="stylesheet" type="text/css" href="css/bootstrap.css" />

<meta http-equiv="Content-Type" charset="UTF-8">

<meta charset="UTF-8">

<script>
//소켓 관련 스크립트

window.onload = function(){
	
	var sock = new SockJS("<c:url value="/echo"/>");
	
	connect();
	function connect() {
		sock.onopen = function() {
			alert($("#roomNum").val());
			appendMessage("연결되었습니다.");
			sock.send($("#roomNum").val()+":::"+$("#userId").val());
			console.log('open');
		};
		sock.onmessage = function(evt) {
			var data = evt.data;
			var strArray  = data.split('|');
			var userid = strArray[0];
			var message   = strArray[1];
			var date   = strArray[2];
			if (message.substring(0, 4) == "msg:") {
				appendMessage(message.substring(4), userid, date);
			}
			
			
		};
		sock.onclose = function() {
			appendMessage("연결을 끊었습니다.");
			console.log('close');
		};
	}

	function onClose() {
		appendMessage("연결을 끊었습니다.");
		$("#data").append("연결 끊김");
	}

	function disconnect() {
		sock.close();
	}

	// 나가기 버튼 클릭시  작동 함수 소켓을 닫는다.
	function appendMessage(msg, userid, date) {
		// 메세지 입력창에 msg를 하고 줄바꿈 처리
		var result = 1;
		if (msg == "연결되었습니다.")
			result = 2;
		if (msg == "연결을 끊었습니다.")
			result = 2;
		if (result == 1) {
			$("#chatList")
					.append(
							'<div class="row">'
									+ '<div class="col-lg-12">'
									+ '<div class="media">'
									+ '<a class="pull-left" href="#">'
									+ '<img class="media-object img-circle" src="images/icon.png" width="60px" height="60px">'
									+ '</a>' + '<div class="media-body">'
									+ '<h4 class="media-heading">'
									+ userid
									+ '<span class="small pull-right">'
									+ date 
									+ '</span>' + '</h4>' + '<p>' + msg + '</p>'
									+ '</div>' + '</div>' + '</div>' + '</div>'
									+ '<hr>');
		} else {
			$("#chatList").append(
					'<div class="row">' + '<div class="col-lg-12">'
							+ '<div class="media">'
							+ '<a class="pull-left" href="#">' + '</a>'
							+ '<div class="media-body">'
							+ '<h4 class="media-heading">'
							+ '<span class="small pull-right">'
							+ '</span>' + '</h4>' + '<p>' + msg + '</p>'
							+ '</div>' + '</div>' + '</div>' + '</div>'
							+ '<hr>');
		}

	}

	function send() {
		var msg = $("#chatContent").val();
		sock.send("msg:" + msg);
		$("#chatContent").val("");
	}

	$(document).ready(function() {
		$('#chatContent').keypress(function(event) {
			var keycode = (event.keyCode ? event.keyCode : event.which);
			if (keycode == '13') { // 엔터 키보드가 13
				send();
			}
			event.stopPropagation(); /// 이벤트 발생 범위 한정하는 코드 
		});
		$('#sendBtn').click(function() {
			send();
		});
		$('#enterBtn').click(function() {
			connect();
		});
		$('#exitBtn').click(function() {
			disconnect();
		});
	});
}

</script>


<title>Insert title here</title>
</head>
<body>
	<!-- 채팅 입력 시작 -->
	<div class="container bootstrap snippet">
		<div class="row" style="width: 600px;">
			<div class="card col-xs-4"
				style="overflow-y: scroll; height: 450px;">
				<ul id="listGroup" class="list-group list-group-flush">
					<c:if test="${sessionScope.loginId != null }">
						<script>
							$("#listGroup")
									.append(
											'<li class="list-group-item">'
													+ '<div class="d-flex w-100 justify-content-between">'
													+ '<div class="row">'
													+ '<div class="col-xs-2">'
													+ '<img class="media-object img-circle" src="images/icon.png" width="40px" height="40px">'
													+ '</div>'
													+ '<div class="col-xs-4">'
													+ '<h4 class="mb-1">${sessionScope.loginName }</h4>'
													+ '</div>' + '</div>'
													+ '</div>' + '<p>하고싶은말</p>'
													+ '</li>');
						</script>
					</c:if>
				</ul>
			</div>
			<div class="row" >
				<div class="col-xs-7">
					<div class="portlet portlet-default">
						<div class="portlet-heading">
							<div class="portlet-title">
								<h4>
									<i class="fa fa-circle text-green"></i>실시간 채팅창
								</h4>
							</div>
							<div class="clearfix"></div>
						</div>
						<div id="chat" class="panel-collapse collapse in">
							<div id="chatList" class="portlet-body chat-widget"
								style="overflow-y: auto; width: auto; height: 300px;"></div>
							<div class="portlet-footer">
								<div class="row" style="height: 90px;">
									<div class="form-group col-xs-10">
										<input type="text" style="height: 80px;" id="chatContent"
											class="form-control" placeholder="메시지를 입력" maxlength="100" />
									</div>

									<div class="form-group col-xs-2">
										<button id="sendBtn" type="button"
											class="btn btn-default pull-right">전송</button>
										<div class="clearfix"></div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<input type="hidden" id="roomNum" value="${roomNum}">
	<input type="hidden" id="userId" value="${userId}">

</body>
</html>