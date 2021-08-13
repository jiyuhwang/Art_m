<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-sacle = 1.0, user-scalable=no" />
<title>아이디 찾기</title>
<style type="text/css">
body {
	margin: 0;
}

.wrap {
	width: 80%;
	/* height: 135vw; */
	margin: 0 auto;
	padding: 30px;
	margin-top: 30px;
	border: solid 1px;
	border: 1px solid #e5e5e5;
}

.c {
	text-align: center;
}

#id1 {
	font-size: 1.5em;
	margin-bottom: 3px;
}
#id2 {
	font-size: 1.5em;
	margin-bottom: 5px;
}
#id3 {
	font-size: 1.5em;
	margin-bottom: 5px;
}

.a {
   text-align:center;
}

#userName {
  	width: 100%;
    height:50px;
    border: 0;
    outline: none;
    font-size: 14pt;
    border-bottom: 2px solid #e5e5e5;
    margin-bottom: 20px;
}
#userMail {
  	width: 63%;
    height: 30px;
    border: 0;
    outline: none;
    font-size: 14pt;
    border-bottom: 2px solid #e5e5e5;
    margin-bottom: 20px;
}

.c3{
	width: 28%;
	height: 40px;
	display: inline-block;
	background-color: #ffad33;
	color: #fff;
	font-size: 0.8em;
	cursor:pointer;
	border:none;
	border-radius: 20px;
}

#checkMail{
 	width: 63%;
 	height: 30px;
    border: 0;
    outline: none;
    font-size: 14pt;
    border-bottom: 2px solid #e5e5e5;
    margin-bottom: 20px;
}
.cancel{
 	height:40px;
 	width: 90px;
	font-size: 20px;
	color: #888;
	border: 0;
	cursor:pointer;
	border-radius: 10px;
}

.check{
	height:40px;
	background-color: #ffad33;
	width: 90px;
	border:none;
	margin-left: 50px;
	font-size: 20px;
	color: #fff;
	cursor:pointer;
	border-radius: 10px;
}

.button_wrap {
	text-align: center;
}

.top2 {
	background-color: #ffad33;
	height: 80px;
	padding-top: 50px;
}


.tabs {
	display: block;
	width: 80%;
	margin: 40px auto;
	font-size: 16px;
}

.tabs input:nth-of-type(1), .tabs input:nth-of-type(1) ~ div:nth-of-type(1), .tabs input:nth-of-type(2), .tabs input:nth-of-type(2) ~ div:nth-of-type(2) {
    display:none;
    
}
.tabs input:nth-of-type(1):checked ~ div:nth-of-type(1), .tabs input:nth-of-type(2):checked ~ div:nth-of-type(2) {
    display: inline-block;
}
.tabs > label:nth-of-type(1) {
	/* float: left; */
    width: 120px;
    padding: 30px 0 6px 0;
    margin-right: 6px;
    font-size: 24px;
    color: #666;
    margin-top: 14px;
}

.tabs > label:nth-of-type(2) {
	/* float: left; */
    width: 150px;
    padding: 30px 0 6px 0;
    margin-right: 6px;
    font-size: 24px;
    color: #666;
    margin-top: 14px;
    margin-left: 10px;
}

.tabs input:nth-of-type(1):checked ~ label:nth-of-type(1), .tabs > label[for=tab1]:hover {
    color: #EF6C33;
    font-weight: bold;
    border-bottom: 2px solid #EF6C33;
    cursor: pointer;
}
.tabs input:nth-of-type(2):checked ~ label:nth-of-type(2), .tabs > label[for=tab2]:hover {
    color: #EF6C33;
    font-weight: bold;
    border-bottom: 2px solid #EF6C33;
    cursor: pointer;
}


</style>
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
var code = ""; 
$(document).ready(function() {
	
	$("#tab1").on("click", function(){
	    
		location.href = "idfind";   
	});
	
	$("#tab2").on("click", function(){
		    
		location.href = "passwordfind";   
	});
	
	

	$("#emailSend").click(function(){
		if($.trim($("#userName").val()) == "") {
			alert("이름을 입력해주세요.");
			$("#userName").focus();
			return false;
		} else if($.trim($("#userMail").val()) == "") {
			alert("이메일 주소를 정확하게 입력해주세요.");
			$("#userMail").focus();
			return false;
		} else {
			// form의 data를 문자열로 전환
			var params = $("#idFindForm").serialize();
			console.log(params);
			// ajax
			$.ajax({
				url: "idfinds", // 접속 주소
				type: "post", // 전송 방식: get, post
				dataType: "json", // 받아올 데이터 형태
				data: params, // 보낼 데이터(문자열 형태)
				success: function(res) { // 성공 시 다음 함수 실행
					if(res.resMsg == "success") {
					  alert("이메일 인증번호가 전송되었습니다.")
				      $("#checkMail").val(""); 
						console.log(res.list);
					  /* $("#userId2").val(res.data.USER_ID); */
					  var email = $("#userMail").val();            // 입력한 이메일
					  var checkBox = $("#checkMail");        // 인증번호 입력란
					  
					    
					    $.ajax({
					        
					        type:"GET",
					        url:"mailCheck?email=" + email,
					        success:function(data){
					            
					        	checkBox.attr("disabled",false);
					        	code = data;
					        }
					                
					  });
					  
					 } else if(res.resMsg == "failed") {
						alert("탈퇴한 회원이거나 일치하는 회원정보가 없습니다.");
					} else {
						alert("로딩 중 문제 발생");
					}
				},
				error: function(request, status, error) { // 실패 시 다음 함수 실행
					console.log(error);
				}
			});
		}
	});
	
	$("#emailCheck").on("click", function(){
	    
	    var inputCode = $("#checkMail").val();    
	    // 입력코드      
	    if(inputCode == "") {
	    	alert("이메일을 인증해주세요.");
	    } else if(inputCode == code && inputCode != ""){                            // 일치할 경우
	        alert("인증번호가 일치합니다.");        
	    } else {                                            // 일치하지 않을 경우
	        alert("인증번호를 다시 확인해주세요.");
	    }    
	    
	});
	
	
	$(".check").on("click", function() {
		if($.trim($("#userName").val()) == "") {
			alert("이름을 입력해주세요.");
			$("#userName").focus();
		} else if($.trim($("#userMail").val()) == "") {
			alert("이메일 주소를 정확하게 입력해주세요.");
			$("#userMail").focus();
		} else if($("#checkMail").val() == "") {
			alert("인증번호를 입력해주세요.");
			$("#checkMail").focus();
		} else if($("#checkMail").val() != code) {
			alert("이메일 인증번호가 틀립니다.");
		} else {
			$("#idFindForm").attr("action", "findId");
			$("#idFindForm").submit();
		}
	});
	
	$(".cancel").on("click", function() {
		location.href="login";
	
});
	
});
</script>
</head>
<body>
<form action="#" id="idFindForm" method="post">
<input type="hidden" id="userId2" name="userId2" >

<div class="tabs">
	<input id="tab1" type="radio" value="0" checked="checked" />
	<input id="tab2" type="radio" value="1" />
	<label for="tab1">아이디찾기</label>
	<label for="tab2">비밀번호찾기</label>
</div>
<div class="wrap">
	<div class="a"><h1>아이디 찾기</h1></div>
	<div class="c"><h2>이메일 인증</h2></div>
	<span>본인확인 이메일 주소와 입력한 이메일 주소가 같아야, 인증번호를 받을 수 있습니다.</span>
	<br><br>
	<div id="id1">이름</div>
	<input type="text" id="userName" name="userName" placeholder="이름">
<br>
	<div id="id2">이메일주소</div>	
	<input type="text" id="userMail" name="userMail" placeholder="이메일주소">
	<input type="button" id="emailSend" class="c3" value="인증번호받기">
<br>
	<div id="id3">인증번호</div>
	<input type="text" id="checkMail" name="userMailCheck" placeholder= "인증번호입력" disabled="disabled">
	<input type="button" class="c3" id="emailCheck" value="확인">
<br><br>
	<div class="button_wrap">
		<input type="button" class="cancel" value="취소">
		<input type="button" class="check" value="확인">
	</div>
</div>
</form>
</body>
</html>