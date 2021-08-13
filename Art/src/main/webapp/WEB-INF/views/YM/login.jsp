<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-sacle = 1.0, user-scalable=no" />
<title>Art 로그인</title>
<style type="text/css">

body {

}
.wrap {
	font-size: 1em;
    margin: 0 auto;
    width: 87%;
    text-align: center;
}

a {
	color: inherit;
	text-decoration: none;
}


.incorrect{
	font-size: 2em;
	width: 90%;
	margin: 3vw auto;
	text-align: center;
}

#loginForm2 {
    width: 90%;
    border: 1px solid white;
    margin: 10% auto;
    overflow: hidden;
}

.logo3 {
    width: 200px;
	margin: 0 auto;
	margin-bottom: 5vw;
}

#userId, #userPw {
	width: 91%;
	border-radius: 15px;
	height: 17vw;
	font-size: 1.5em;
	padding: 0 4%;
}
#btnLogin {
    width: 100%;
    height: 15vw;
    border-radius: 15px;
    padding: 15px;
    font-size: 1.5em;
    background-color: #ffad33;;
    border: none;
    font-weight: 900;
    color: #333;
    margin-top: 4vw;
}
</style>
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script src="resources/script/jquery/jquery.cookie.js"></script>
<script type="text/javascript">

	$(document).ready(function() {
		
		/* $("#loginForm2").animate({
			'margin-top': "+=20%",
		}, 500); */
		
		$('#loginForm').keypress(function(event){
		     if (event.which == 13 ) {
		         $('#btnLogin').click();
		         return false;
		     }
		});
		
		$("#btnLogin").on("click", function() {
			if($.trim($("#userId").val()) == "") {
				alert("아이디를 입력해주세요.");
				$("#userId").focus();
			} else if($.trim($("#userPw").val()) == "") {
				alert("비밀번호를 입력해주세요.");
				$("#userPw").focus();
			} else {
				// form의 data를 문자열로 전환
				var params = $("#loginForm").serialize();
				console.log(params);
				// ajax
				$.ajax({
					url: "Logins", // 접속 주소
					type: "post", // 전송 방식: get, post
					dataType: "json", // 받아올 데이터 형태
					data: params, // 보낼 데이터(문자열 형태)
					success: function(res) { // 성공 시 다음 함수 실행
						if(res.resMsg == "success" || res.resMsg2 == "success") {
							location.href = "main";
						} else {
							$('.incorrect').html("가입하지 않은 아이디이거나, 잘못된 비밀번호입니다");
							$('.incorrect').css("color", "red");
							$('.incorrect').css("text-align", "left");
						}
					},
					error: function(request, status, error) { // 실패 시 다음 함수 실행
						console.log(error);
					}
				});
			}
		});
	})
</script>
</head>
<body>
<div id="loginForm2">
        <div class="logo3"><img src="resources/images/JY/art2.png" alt="art" width="200px" height="100px"></div>
        <form action="#" id="loginForm" method="post" >

            <input type="text" id="userId" name="userId" placeholder="ID" value="${param.selectId}">

            <input type="password" id="userPw" name="userPw" placeholder="PASSWORD">

            <input type="button" id="btnLogin" value="로그인">
            <div class="incorrect"></div>
            <div class="wrap">
	           	<a href="agree">회원가입</a> |
				<a href="idfind">아이디찾기</a> |
				<a href="passwordfind">비밀번호 찾기 </a>
			</div>   
        </form>
    </div>
</body>

</html>