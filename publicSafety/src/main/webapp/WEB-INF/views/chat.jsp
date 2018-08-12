<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- 소켓, jquery -->
<script type="text/javascript" src="resources/sockjs-0.3.4.js"></script>
<script type="text/javascript" src="resources/jquery-3.3.1.min.js"></script>

<!-- 컨텍스트 메뉴 입포트 -->
<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.7.0/jquery.contextMenu.min.css" />
<script type="text/javascript" src="resources/js/contextMenu.min.js"></script>
<script type="text/javascript" src="resources/js/jquery.ui.position.js"></script>
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


<style>
* {
	font-family: 'Nanum Gothic';
}

h5 {
	font-family: 'Noto Sans KR';
	font-size: 15px;
	font-weight: bold;
}

h4 {
	font-family: 'Noto Sans KR';
}

h3 {
	font-family: 'Hanna';
	font-style: normal;
	font-weight: 400;
}

h2 {
	font-family: 'Hanna';
	font-style: normal;
	font-weight: 400;
}

h1 {
	font-family: 'Hanna';
	font-style: normal;
	font-weight: 400;
}
</style>

<script>
	$(document).ready(function() {
		$.ajax({
			method : 'POST'
			,url   : 'chatList'
			,data  : 'roomName=100'
			,dataType : 'json'
			,success : chatList
		});
	});
	
	var temp= 0;
	
	connect();
	
	function chatOne(senduserId, roomN){
		temp = roomN;
		var msg = roomN+"***"+senduserId;
		send(msg);
	}
	
	function chatOneConnect(senduserId, roomN){
		var url = 'chatOne?roomNum='+roomN+'&userId='+senduserId;
		var openWin = window.open(url, 'testWindow', 'width=610, height=500, scrollbars=no');
	}
	

	// 소켓 관련 스크립트
	function connect() {
		sock = new SockJS("<c:url value="/echo"/>");
		sock.onopen = function() {
			appendMessage("연결되었습니다.");
			sock.send(100+":::"+$("#userId").val());
			console.log('open');
			$.ajax({
				method : 'POST'
				,url   : 'chatList'
				,data  : 'roomName=100'
				,dataType : 'json'
				,success : chatList
			});
		};
		sock.onmessage = function(evt) {
			var data = evt.data;
			var strArray  = data.split('|');
			var userid = strArray[0];
			var message   = strArray[1];
			var date      = strArray[2];
			if (message.substring(0, 4) == "msg:") {
				appendMessage(message.substring(4), null, null, userid, date);
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
	function appendMessage(msg, i, senduserId, userid, date) {
		// 메세지 입력창에 msg를 하고 줄바꿈 처리
		var result = 1;
		if (msg == "연결되었습니다.")
			result = 2;
		if (msg == "연결을 끊었습니다.")
			result = 2;
		if(msg.indexOf("***")!=-1){
			var i = msg.substring(0, msg.indexOf("***"))
			var senduserId = msg.substring(msg.indexOf("***")+3);
			result = 3;
		}
		if(i!=null)
			result = 3;
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
									+'<span class="small pull-right">'
									+ date 
									+ '</span>' + '</h4>' + '<p>' + msg + '</p>'
									+ '</div>' + '</div>' + '</div>' + '</div>'
									+ '<hr>');
		} else if(result==2) {
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
		} else{
			$("#chatList").append(
					'<div class="row">' + '<div class="col-lg-10">'
							+ '<div class="media">'
							+ '<a class="pull-left" href="#"></a>'
							+ '<div class="media-body">'
							+ '<h4 class="media-heading">1:1신청</h4>'
							+ '<div class="form-group col-xs-2">'
							+ '</div>' 
							+ userid 
							+ '<span class="small pull-right">' 
							+ '<button id="btn" type="button" class="btn btn-primary pull-right" onclick="chatOneConnect('+senduserId+', '+i+')">연결</button>'
							+ date 
							+ '</span>' + '</h4>' + '<p>' + senduserId + '에게 1:1 채팅을 신청했습니다.</p>'
							+ '</div>' + '</div>' + '</div>' + '</div>'
							+ '<hr>'
						);
			chatOneConnect(senduserId, temp);
		}

	}

	function send(msg) {
		if(msg==null||msg==""){
			var msg = $("#chatContent").val();	
		}
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
</script>

<title>JSP 회원제 채팅 서비스</title>
</head>
<body>

	<c:if test="${sessionScope.loginId != null }">
	</c:if>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="${pageContext.request.contextPath}">실시간
				회원제 채팅 서비스</a>
		</div>
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li class="active"><a href="${pageContext.request.contextPath}">메인</a></li>
			</ul>
			<c:if test="${sessionScope.loginId == null }">
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span>
					</a>
						<ul class="dropdown-menu">
							<li><a href="login">로그인</a></li>
							<li><a href="join">회원가입</a></li>
						</ul></li>
				</ul>
			</c:if>
			<c:if test="${sessionScope.loginId != null }">
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span>
					</a>
						<ul class="dropdown-menu">
							<li><a href="logout">로그아웃</a></li>
						</ul></li>
				</ul>
			</c:if>
		</div>
	</nav>

	<!-- 채팅 입력 시작 -->
	<div class="container bootstrap snippet">
		<div class="row">
			<div class="card col-xs-3 "
				style="overflow-y: scroll; height: 750px;">
				<ul id="listGroup" class="list-group list-group-flush">
					<c:if test="${sessionScope.loginId != null }">
						<script>
							function chatList(resp){
								for (var i= 0; i<resp.length; i++){
									var id = "#"+i
									var sendId = resp[i].userId;
									$("#listGroup")
											.append(
													'<li id="'+i+'" class="list-group-item">'
															+ '<div class="d-flex w-100 justify-content-between">'
															+ '<div class="row">'
															+ '<div class="col-xs-2">'
															+ '<img class="media-object img-circle" src="images/icon.png" width="40px" height="40px">'
															+ '</div>'
															+ '<div class="col-xs-4">'
															+ '<h4 class="mb-1">'+sendId+'</h4>'
															+ '</div>' + '</div>'
															+ '</div>' + '<p>하고싶은말</p>'
															+ '</li>');
											$(id).attr("id", "list"+i);
									}
								var resp = resp.length;
								chatmenu(resp)
							}
							
							function chatmenu(resp) {
								
								// 제이쿼리 콘텍스트 메뉴
								for(var i = 0; i<resp; i++){
									var selector = "#list"+i;
									$.contextMenu({
										selector : selector,
										callback : function(key, options) {
											var m = "clicked: " + key;
											var cc = options;
											var a = cc.selector
											if(key=='edit'){
												var senduserId = $(a).children().children().children().children().text();
												var roomN = a.substring(5,6)
												chatOne(senduserId, roomN);
											}
										},
										items : {
											"edit" : {
												name : "1:1",
												icon : "edit"
											},
											"sep1" : "---------",
											"quit" : {
												name : "Quit",
												icon : function() {
													return 'context-menu-icon context-menu-icon-quit';
												}
											}
										}
									});
								}

								$('.list-group-item').on('click', function(e) {
									console.log('clicked', this);
								})
							}
						</script>
					</c:if>
				</ul>
			</div>
			<div class="row">
				<div class="col-xs-8">
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
								style="overflow-y: auto; width: auto; height: 600px;"></div>
							<div class="portlet-footer">
								<div class="row" style="height: 90px;">
									<div class="form-group col-xs-10">
										<input type="text" style="height: 80px;" id="chatContent"
											class="form-control" placeholder="메시지를 입력" maxlength="100" />
									</div>

									<div class="form-group col-xs-1">
										<button id="sendBtn" type="button"
											class="btn btn-default pull-right">전송</button>
										<div class="clearfix"></div>
									</div>
									<div class="form-group col-xs-1">
										<button id="enterBtn" type="button"
											class="btn btn-default pull-right">연결</button>
										<div class="clearfix"></div>
									</div>
									<div class="form-group col-xs-2">
										<button id="exitBtn" type="button"
											class="btn btn-default pull-right">연결끊기</button>
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
	<input id="userId" type="hidden" value="${sessionScope.loginId }"/>
</body>
</html>