<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-sacle = 1.0, user-scalable=no" />
<title>개인정보 관리</title>
<link rel="stylesheet" href="resources/css/JY/set.css">
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">

//이메일 형식 유효성 검사
function mailFormCheck(email){
    var form = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
    return form.test(email);
}

//비밀번호 형식 유효성 검사
function checkPassword(password){
    
    if(!/^(?=.*[a-zA-Z])(?=.*[~!@#$%^*+=-])(?=.*[0-9]).{8,25}$/.test(password)){            
        alert('숫자+영문자+특수문자 조합으로 8자리 이상 사용해야 합니다.');
        $('#pw').val('').focus();
        return false;
    }    
    var checkNumber = password.search(/[0-9]/g);
    var checkEnglish = password.search(/[a-z]/ig);
    if(checkNumber <0 || checkEnglish <0){
        alert("숫자와 영문자를 혼용하여야 합니다.");
        $('#pw').val('').focus();
        return false;
    }
    if(/(\w)\1\1\1/.test(password)){
        alert('같은 문자를 4번 이상 사용하실 수 없습니다.');
        $('#pw').val('').focus();
        return false;
    }
        
    return true;
}

var code = "";                //이메일전송 인증번호 저장위한 코드

$(document).ready(function() {

	$('.select').on("change", function() {
		if($("select[name=category]").val() == '0') {
			location.href = "myreport";
		} else if($("select[name=category]").val() == '1') {
			location.href = "profile";
		} else if($("select[name=category]").val() == '2') {
			location.href = "set";
		} else {
			location.href = "withdrawal";
		}
	});
	
	$("#pw").change(function(){
	    checkPassword($('#pw').val());
	});
	
	
	$('#pw, #pwCheck').on("propertychange change keyup paste input", function(){
		check_pw();
	});
	
	
	$("#emailSend").click(function(){
	    
		  var email = $("#email").val();            // 입력한 이메일
		    
		  
		  if(email == "${data.MAIL}") {
		    	alert("기존 이메일 주소와 같습니다.");
		    	return false;
		    } else if(!mailFormCheck(email)){
		        alert("올바르지 못한 이메일 형식입니다.");
		        return false;
		    } else {
		        alert("이메일이 전송 되었습니다. 이메일을 확인해주세요.");
		   		$("#email3").val("");
		    }
		  var checkBox = $("#email3");        // 인증번호 입력란
		  var boxWrap = $(".mail_check_input_box");    // 인증번호 입력란 박스
		    
		    $.ajax({
		        
		        type:"GET",
		        url:"mailCheck?email=" + email,
		        success:function(data){
		            
		            //console.log("data : " + data);
		        	checkBox.attr("disabled",false);
		        	boxWrap.attr("id", "mail_check_input_box_true");
		        	code = data;
		        }
		                
		  });
	});
	
	
	/* $("#emailCheck").on("click", function(){
	    
	    var inputCode = $("#email3").val();        // 입력코드      
		if(inputCode == code){                            // 일치할 경우
	        alert("인증번호가 일치합니다.");        
	    } else {                                            // 일치하지 않을 경우
	        alert("인증번호를 다시 확인해주세요.");
	    }    
	    
	}); */
	
	
	$(".profile_manage").on("click", function() {
		location.href = "profile";
	});
	
	$(".privacy").on("click", function() {
		location.href = "set";
	});
	
	$(".stop").on("click", function() {
		location.href = "withdrawal";
	});
	
	$(".report").on("click", function() {
		location.href = "myreport";
	});
	
	$("table tr:nth-child(2)").hide();
	$("table tr:nth-child(3)").hide();


	
	$("#btnEditPw").on("click", function() {
		if($('#nowPw').val() == "") {
			alert("비밀번호를 입력해주세요.");
			$("#nowPw").focus();
			return false;
		}
		
		$("#userPw2").val($("#nowPw").val());
		var params = $("#pwForm").serialize();

		
		$.ajax({
			url: "pwCheck",
			type: "post",
			dataType: "json",
			data: params,
			success: function(res){
				if(res.msg == "exist") {
					if($("table tr:nth-child(2)").css("display") == "none") {
						$("table tr:nth-child(2)").show();
						$("table tr:nth-child(3)").show();
					} else {
						$("table tr:nth-child(2)").hide();
						$("table tr:nth-child(3)").hide();
					}
				} else if(res.msg == "none") {
					$("#nowPw").val("");
					$("#nowPw").focus();
					alert("비밀번호가 일치하지 않습니다.");
				} else {
					alert("문제가 발생하였습니다.")
				}
				
			}, error: function(request, status, error){
				console.log(error);
			}
		});
	});
	
	
	$("#pwSend").on("click", function(){
		$("#sendPw").val($("#pw").val());
		
		if($("#pw").val() == "") {
			$("#pw").focus();
			return false;
		} else if($("#pwCheck").val() == "") {
			$("#pwCheck").focus();
			return false;
		} else if($("#pw").val() == $('#nowPw').val()) {
			alert("기존 비밀번호와 다르게 설정해주세요.");
			$("#pw").val("");
			$("#pwCheck").val("");
			$("#pw").focus();
			return false;
		} else if($("#pw").val() != $("#pwCheck").val()) {
			$("#pw").val("");
			$("#pwCheck").val("");
			$("#pw").focus();
			return false;
		} else {
			var params= $("#pwForm").serialize();
			
			$.ajax({
				url: "pwsets", // 접속 주소
				type: "post", // 전송 방식: get, post
				dataType: "json", // 받아올 데이터 형태
				data: params, // 보낼 데이터(문자열 형태)
				success: function(res) { // 성공 시 다음 함수 실행
				    if(res.msg == "success") {
						alert("비밀번호 수정이 완료되었습니다.");
						$("#pwForm").attr("action", "set");
						$("#pwForm").submit();
					} else if(res.msg == "failed") {
						alert("작성에 실패하였습니다.");
					} else {
						alert("작성 중 문제가 발생하였습니다.")
					}
				},
				error: function(request, status, error) { // 실패 시 다음 함수 실행
					console.log(error);
				}
			});
		}
		
	});
	$("#btnSave").on("click", function(){
	console.log($("#email3").prop("disabled"));
	    
		if($("#name").val() == "") {
			$("#name").focus();
			return false;
		} else if($("#phone").val() == "") {
			$("#phone").focus();
			return false;
		} else if($("#year").val() == "") {
			$("#year").focus();
			return false;
		} else if($("select[name=birthMonth]").val() == '월') {
			$(".month").focus();
			return false;
		} else if($('#day').val() == "") {
			$("#day").focus();
			return false;
		} else if($("#email").val() == "") {
			$("#email").focus();
			return false;
		} else if($("#email3").val() == "" && $("#email3").prop("disabled") == false) {
			$("#email3").focus();
			alert("asdfa");
			return false;
		} else if($("#email").val() != "${data.MAIL}"&& $("#email3").val() == ""){
			alert("이메일을 인증해주세요.");
			return false;
		} else if($("#email").val() != "${data.MAIL}" && $("#email3").val() != code) {
			alert("이메일 인증번호를 다시 확인해주세요.");
			return false;
		} else {
			
			var params= $("#setForm").serialize();
		
			$.ajax({
				url: "sets", // 접속 주소
				type: "post", // 전송 방식: get, post
				dataType: "json", // 받아올 데이터 형태
				data: params, // 보낼 데이터(문자열 형태)
				success: function(res) { // 성공 시 다음 함수 실행
					if(res.msg == "success") {
						alert("회원정보 수정이 완료되었습니다.");
						$("#setForm").attr("action", "set");
						$("#setForm").submit();
					} else if(res.msg == "failed") {
						alert("작성에 실패하였습니다.");
					} else {
						alert("작성 중 문제가 발생하였습니다.")
					}
				},
				error: function(request, status, error) { // 실패 시 다음 함수 실행
					console.log(error);
				}
			});
	  	}
	    
	});
});
	

	function check_pw(){
		 
        /* var pw = document.getElementById('pw').value; */
        /* var SC = ["!","@","#","$","%"];
        var check_SC = 0; */

        
        if(document.getElementById('pw').value !='' && document.getElementById('pwCheck').value!=''){
            if(document.getElementById('pw').value==document.getElementById('pwCheck').value){
                document.getElementById('check2').innerHTML='비밀번호가 일치합니다.';
                document.getElementById('check2').style.color='green';
            } else{
                document.getElementById('check2').innerHTML='비밀번호가 일치하지 않습니다.';
                document.getElementById('check2').style.color='red';
            }
        } else {
        	document.getElementById('check2').innerHTML='';
        }
	}
	
	function handleOnInput(el, maxlength) {
	  if(el.value.length > maxlength)  {
		  el.value = el.value.substr(0, maxlength);
	  }
	}
	
	function handleOnInput2(el, maxlength) {
	  if(el.value.length > maxlength)  {
		  el.value = el.value.substr(0, maxlength);
	  }
	}
</script>
</head>
<body>
<form action="#" id="pwForm" method="post">
	<input type="hidden" id="sendPw" name="userPw" value="">
	<input type="hidden" name="userNo" value="${sUserNo}">
	<input type="hidden" id="userPw2" name="userPw2" value="">
</form>
<form action="#" id="setForm" method="post">
	<input type="hidden" name="userNo" value="${sUserNo}">
	
	<c:choose>
		<c:when test="${empty sUserNo}">
			<c:import url="header2.jsp"></c:import>
		</c:when>
		<c:otherwise>
			<c:import url="header.jsp">
				<c:param name="url" value="profile"></c:param>
			</c:import>
		</c:otherwise>
	</c:choose>
	
	<div class="wrap">
		<select class="select" name="category">
			<option value="0">나의 신고목록</option>
			<option value="1">프로필관리</option>
			<option value="2" selected="selected">개인정보관리</option>
			<option value="3">탈퇴하기</option>
		</select>
		<div class="title">개인정보 관리</div>
		<div class="contents">
			<table cellspacing="0" class="table">
				<tr>
					<th>현재<br/>비밀번호</th>
					<td>
						<input id="nowPw" type="password" size="10" maxlength="200" placeholder="현재 비밀번호를 입력해주세요."/>
						<input id="btnEditPw" type="button" value="수정"/>
					</td>
				</tr>
				<tr>
					<th>새<br/>비밀번호</th>
					<td><input id="pw" type="password" onchange="check_pw()" size="10" maxlength="200" placeholder="새 비밀번호를 입력해주세요."/></td>
				</tr>
				<tr>
					<th>새<br/>비밀번호<br/>확인</th>
					<td><input id="pwCheck" type="password" onchange="check_pw()" size="10" maxlength="200" placeholder="새 비밀번호를 확인해주세요."/>
						<input id="pwSend" type="button" value="수정하기">
						<br/>
						<span id="check2"></span>
					</td>
				</tr>
				<tr>
					<th>이름</th>
					<td><input id="name" type="text" name="userName" size="10" maxlength="10" value="${data.NAME}" /><br/></td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td>
						<c:set var="Birth" value="${data.BIRTHDAY}" />
						<input type="number" id="year" name="birthYear" value="${fn:substring(Birth,0,4)}" size="10" maxlength="4" placeholder="년(4자)" oninput='handleOnInput(this, 4)'/>
						<select name="birthMonth" class="month">
								<option>월</option>
								<option value="01" <c:if test="${fn:substring(Birth,5,7) eq '01'}">selected</c:if>>01</option>
								<option value="02" <c:if test="${fn:substring(Birth,5,7) eq '02'}">selected</c:if>>02</option>
								<option value="03" <c:if test="${fn:substring(Birth,5,7) eq '03'}">selected</c:if>>03</option>
								<option value="04" <c:if test="${fn:substring(Birth,5,7) eq '04'}">selected</c:if>>04</option>
								<option value="05" <c:if test="${fn:substring(Birth,5,7) eq '05'}">selected</c:if>>05</option>
								<option value="06" <c:if test="${fn:substring(Birth,5,7) eq '06'}">selected</c:if>>06</option>
								<option value="07" <c:if test="${fn:substring(Birth,5,7) eq '07'}">selected</c:if>>07</option>
								<option value="08" <c:if test="${fn:substring(Birth,5,7) eq '08'}">selected</c:if>>08</option>
								<option value="09" <c:if test="${fn:substring(Birth,5,7) eq '09'}">selected</c:if>>09</option>
								<option value="10" <c:if test="${fn:substring(Birth,5,7) eq '10'}">selected</c:if>>10</option>
								<option value="11" <c:if test="${fn:substring(Birth,5,7) eq '11'}">selected</c:if>>11</option>
								<option value="12" <c:if test="${fn:substring(Birth,5,7) eq '12'}">selected</c:if>>12</option>
						</select>
						<input type="number" id="day" name="birthDay" value="${fn:substring(Birth,8,10)}" size="10" maxlength="2" placeholder="일" oninput='handleOnInput2(this, 2)'/></td>
				</tr>
				<tr>
					<th>성별</th>
					<td>
						<div class="sex">
							<c:choose>
								<c:when test="${data.SEX == 0}">
									<input type="radio" value="0" name="gender" checked ="checked">남 
			        				<input type="radio" value="1" name="gender">여 
								</c:when>
								<c:otherwise>
									<input type="radio" value="0" name="gender">남 
			        				<input type="radio" value="1" name="gender" checked ="checked">여 
								</c:otherwise>
							</c:choose>
						</div>
					</td>
				</tr>
				<tr>
					<th>휴대폰<br/>번호</th>
					<td>
						<input id="phone" type="number" name="userPhone" value="${data.PHONE_NO}"/>
					</td>
				</tr>
				<tr>
					<th rowspan="2">이메일</th>
					<td>
					<input id="email" type="text" name="userMail"  size="40" maxlength="50" value=${data.MAIL} />
					<input id="emailSend" type="button" value="인증번호 받기">
					</td>
				</tr>
				<tr>
					<td>
						<input id="email3" type="text" name="userMailCheck" disabled="disabled" placeholder="인증번호를 입력해주세요." size="40" maxlength="50"/>
						<!-- <input id="emailCheck" type="button" value="확인"> -->
					</td>
				</tr>
				<tr>
					<th>정보수신<br/>여부</th>
					<td rowspan="2" >서비스 관련 소식 및 프로모션 메일을
						<c:choose>
							<c:when test="${data.EVENT_AGREEMENT == 0}">
								<select name="userEventAgree" class="agree">
									<option value="0" selected="selected">수신합니다.</option>
									<option value="">수신하지 않습니다.</option>
								</select>
							</c:when>
							<c:otherwise>
								<select name="userEventAgree" class="agree">
									<option value="0">수신합니다.</option>
									<option value="" selected="selected">수신하지 않습니다.</option>
								</select>
							</c:otherwise>
						</c:choose>
						
					</td>
				</tr>
			</table>
			<div class="save_cancel">
				<input id="btnSave" type="button" value="저장하기">
				<!-- <input id="btnCancel" type="button" value="취소하기"> -->
			</div>
		</div>
	</div>
	
	<c:import url="footer.jsp"></c:import>
</form>
</body>
</html>