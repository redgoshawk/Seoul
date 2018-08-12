<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<link href="http://fonts.googleapis.com/earlyaccess/nanumgothic.css" rel="stylesheet">
<link href="http://fonts.googleapis.com/earlyaccess/hanna.css" rel="stylesheet">
<link href="http://fonts.googleapis.com/earlyaccess/notosanskr.css" rel="stylesheet">

<meta name="viewport" content="width=device-width, initial-scale=1">


<link rel="stylesheet" type="text/css" href="css/custom.css" />
<script type="text/javascript" src="resources/jquery-3.3.1.min.js"></script>

<script type="text/javascript" src="resources/js/bootstrap.js"></script>
<link rel="stylesheet" type="text/css" href="css/bootstrap.css" />

<meta http-equiv="Content-Type" charset="UTF-8">
<title>JSP 회원제 채팅 서비스</title>
<style>
*{
	font-family: 'Nanum Gothic';
}
h5{
	font-family: 'Noto Sans KR';
	font-size: 15px;
	font-weight: bold;
}

h4{
	font-family: 'Noto Sans KR';
}

h3{
	font-family: 'Hanna';
  font-style: normal;
  font-weight: 400;
}

h2{
	font-family: 'Hanna';
  font-style: normal;
  font-weight: 400;
}

h1{
	font-family: 'Hanna';
  font-style: normal;
  font-weight: 400;
}
</style>
<script>

function registerCheckFunction(){
	var userId = $('#userId').val();
	var sendData = {
			"userId" : userId
	};
	 $.ajax({
		type:'POST'
		,url: 'userCheck'
		,data: JSON.stringify(sendData)
		,async: false
		,dataType  : 'json'
		,contentType : 'application/json; carset=UTF-8'
		,success: function(result){
			alert(result);
			 if(result !="1"){
				$('#checkMessage').html('사용할 수 없는 아이디입니다.');
				$('#checkType').attr('class', 'modal-content panel-warning');
			} else{
				$('#checkMessage').html('사용할 수 있는 아이디입니다.');
				$('#checkType').attr('class', 'modal-content panel-success');
			} 
			$("#myModal").modal();
		}
	}); 
	
}

function passwordCheckfunction(){
	var userPassword = $('#userPassword').val();
	var userPassword2 = $('#userPassword2').val();
	if(userPassword != userPassword2){
		$('#passwordCheckMessage').html('비밀번호가 서로 일치하지 않습니다.');
	} else{
		$('#passwordCheckMessage').html('');
	}
}


</script>

</head>
<body>	
	
	<c:if test="${sessionScope.loginId != null }">
	</c:if>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
			data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
				<a class="navbar-brand" href="${pageContext.request.contextPath}">실시간 회원제 채팅 서비스</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li class="active"><a href="${pageContext.request.contextPath}">메인</a></li>
			</ul>
			<c:if test="${sessionScope.loginId == null }">
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" 
					data-toggle="dropdown" role="button" aria-haspopup="true" 
					aria-expanded="false">회원관리<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그아웃</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
			</c:if>
		</div>
	</nav>
	<!-- 여기서부터 join -->
	<div class="container">
		<form method="post" action="join">
			<table class="table table-bordered table-hover" style="text-align: center;border:1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="3"><h4>회원등록양식</h4></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 110px;"><h5>아이디</h5></td>
						<td><input class="form-control" type="text" id="userId" name="userId" placeholder="아이디를 입력하세요"></td>
						<td style="width: 110px;"><input type="button" class="btn btn-primary" aria-pressed="false" onclick="registerCheckFunction();" value="중복체크"></td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>비밀번호</h5></td>
						<td colspan="2"><input onkeyup="passwordCheckfunction();" class="form-control" id="userPassword"
						 type="password" name="userPassword" placeholder="비밀번호를 입력하세요"></td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>비밀번호</h5></td>
						<td colspan="2"><input onkeyup="passwordCheckfunction();" class="form-control" id="userPassword2"
						 type="password" name="userPassword2" placeholder="비밀번호확인 입력하세요"></td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>이름</h5></td>
						<td colspan="2"><input class="form-control" id="userName"
						 type="text" name="userName" placeholder="이름을 입력하세요"></td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>성별</h5></td>
						<td colspan="2">
							<div class="form-group" style="text-align: center; margin: 0 auto;">
								<div class="btn-group" data-toggle="buttons">
								  <label class="btn btn-primary active">
								    	<input type="radio" name="userGender" autocomplete="off" checked> 남자
								  </label>
								  <label class="btn btn-primary">
								    	<input type="radio" name="userGender" autocomplete="off"> 여자
								  </label>
								</div>
							</div>
						</td>
					</tr>
					
					<tr>
						<td style="width: 110px;"><h5>이메일</h5></td>
						<td colspan="2"><input class="form-control" id="userEmail"
						 type="email" name="userEmail" placeholder="이메일을 입력하세요"></td>
					</tr>
					<tr>
						<td style="text-align: left" colspan="3"><h5 style="color:red;" id="passwordCheckMessage"></h5><input class="btn btn-primary pull-right" type="submit" value="등록"></td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
	
  <!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog" tabindex="-1" aria-hidden="true">
  	<div class="vertical-alignment-helper">
		<div class="modal-dialog vertical-align-center">
	    <!-- Modal content-->
	    <div id="checkType" class="modal-content panel-info">
	        <div class="modal-header panel-heading">
	        	<button type="button" class="close" data-dismiss="modal">
	          		<span aria-hidden="true">&times</span>
	          		<span class="sr-only">Close</span>	
          		</button>
		        <h4 class="modal-title">
		        	확인메시지
		        </h4>
	        </div>
		        <div id="checkMessage" class="modal-body">
		        </div>
		        <div class="modal-footer">
		        	<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
		        </div>
     		</div>
      	</div>
	  </div>
	</div>
	
	  <!-- Modal2 -->
  <div class="modal fade" id="joinModal" role="dialog" tabindex="-1" aria-hidden="true">
  	<div class="vertical-alignment-helper">
		<div class="modal-dialog vertical-align-center">
	    <!-- Modal content-->
	    <div id="checkType" class="modal-content panel-info">
	        <div class="modal-header panel-heading">
	        	<button type="button" class="close" data-dismiss="modal">
	          		<span aria-hidden="true">&times</span>
	          		<span class="sr-only">Close</span>	
          		</button>
		        <h4 class="modal-title">
		        	확인메시지
		        </h4>
	        </div>
		        <div id="checkMessage" class="modal-body">
		        </div>
		        <div class="modal-footer">
		        	<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
		        </div>
     		</div>
      	</div>
	  </div>
	</div>
</body>
</html>