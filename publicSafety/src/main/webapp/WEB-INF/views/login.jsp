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
						<li><a href="logout">로그아웃</a></li>
						<li><a href="join">회원가입</a></li>
					</ul>
				</li>
			</ul>
			</c:if>
		</div>
	</nav>
	
	<div class="container">
		<form method="POST" action="login">
			<table class="table table-borered table-hover"	style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="2"><h4>로그인 양식</h4></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 110px;"><h5>아이디</h5></td>
						<td><input class="form-control" type="text" name="userId" maxlength="20" placeholder="아이디를 입력하세요" ></td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>비밀번호</h5></td>
						<td><input class="form-control" type="password" name="userPassword" maxlength="20" placeholder="비밀번호를 입력하세요" ></td>
					</tr>
					<tr>
						<td style="text-align: left" colspan="2"><input class="btn btn-primary pull-right" type="submit" value="로그인"></td>
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
	    <div id="checkType" class="modal-content panel-warning">
	        <div class="modal-header panel-heading">
	        	<button type="button" class="close" data-dismiss="modal">
	          		<span aria-hidden="true">&times</span>
	          		<span class="sr-only">Close</span>	
          		</button>
		        <h4 class="modal-title">
		        	경고메시지
		        </h4>
	        </div>
		        <div id="checkMessage" class="modal-body">
		        	<h5>${result}</h5>
		        </div>
		        <div class="modal-footer">
		        	<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
		        </div>
     		</div>
      	</div>
	  </div>
	</div>
	
	<c:if test="${result!=null }">
		<script>
			$("#myModal").modal();
			history.replaceState({}, null, location.pathname);
		</script>
	</c:if>
</body>
</html>