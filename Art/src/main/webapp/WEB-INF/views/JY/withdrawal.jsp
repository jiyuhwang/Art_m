<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>탈퇴하기</title>
<link rel="stylesheet" href="resources/css/JY/withdrawal.css">
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">

$(document).ready(function() {
	$('.background').hide();
	$('.main').hide();
	
	
	$('.profile_manage').on("click", function() {
		location.href = "profile";
	});
	
	$('.privacy').on("click", function() {
		location.href = "set";
	});
	
	$('.stop').on("click", function() {
		location.href = "withdrawal";
	});
	
	$(".report").on("click", function() {
		location.href = "myreport";
	});
	
	
	$('.background').on("click", function() {
		$('.background').hide();
		$('.main').hide();
		$('#pwCheck').val("");
	});
	
	$(".stopbtn").on("click", function() {
		

		if($('#out').is(":checked") == false){
			alert("위 항목에 동의해주세요.")
		} else {
			$('.background').show();
			$('.main').show();
		}		
	});
	
	$('.a1').on("click", function() {
		$('.background').hide();
		$('.main').hide();
		$('#pwCheck').val("");
	});
	
	$(".a2").on("click", function() {
		if($('#pwCheck').val() == "") {
			alert("비밀번호를 입력해주세요.");
			return false;
		}
		
		$("#userPw2").val($("#pwCheck").val());
		var params = $("#pwForm").serialize();

		
		$.ajax({
			url: "pwCheck",
			type: "post",
			dataType: "json",
			data: params,
			success: function(res){
				if(res.msg == "exist") {
					alert("탈퇴되었습니다. 그동안 이용해주셔서 감사합니다.");
					
					var params= $("#outForm").serialize();
					
					$.ajax({
						url: "withdrawals", // 접속 주소
						type: "post", // 전송 방식: get, post
						dataType: "json", // 받아올 데이터 형태
						data: params, // 보낼 데이터(문자열 형태)
						success: function(res) { // 성공 시 다음 함수 실행
							if(res.msg == "success") {
								location.href = "main";
							} else if(res.msg == "failed") {
								alert("탈퇴에 실패하였습니다.");
							} else {
								alert("탈퇴 중 문제가 발생하였습니다.")
							}
						},
						error: function(request, status, error) { // 실패 시 다음 함수 실행
							console.log(error);
						}
					});
				} else if(res.msg == "none") {
					$("#pwCheck").val("");
					alert("비밀번호가 일치하지 않습니다.");
				} else {
					alert("문제가 발생하였습니다.")
				}
				
			}, error: function(request, status, error){
				console.log(error);
			}
		});
	});

});
</script>
</head>
<body>
<form action="#" id="outForm" method="post">
	<input type="hidden" id="userNo" name="userNo" value="${sUserNo}"> 
</form>

<form action="#" id="pwForm" method="post">
	<input type="hidden" name="userNo" value="${sUserNo}">
	<input type="hidden" id="userPw2" name="userPw2" value="">
</form>
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
		<div class="btn_menu">
			<div class="set">마이페이지</div>
			<div class="report">나의 신고목록</div>
			<div class="profile_manage">프로필관리</div>
			<div class="privacy">개인정보관리</div>
			<div class="stop">탈퇴하기</div>
		</div>
		<div class="contents">
			<div class="title">탈퇴하기</div>
			<div class="box">
				 <div class="desc">
					 탈퇴하시면 이용 중인 아트가 폐쇄되며
					 <br>
					 <b>모든 데이터는 복구가 불가능합니다.</b>
					 <br>
					  아래 사항을 확인하신 후에 신중하게 결정해 주세요.
				 </div>
				 <span class="ico_dot"> 작성한 글, 작품 모든 정보가 삭제됩니다.<br>작성한 댓글은 사라지지 않으니 미리 확인하시기 바랍니다.</span><br>
				  <div class="screen_out">
				   <label > 안내사항을 모두 확인하였으며, 이에 동의합니다.</label><input type="checkbox" id="out" name="out" value="0">
				  <br><br>
				   <input type="button" class="stopbtn" value="탈퇴하기">
				  </div>
			</div>
		</div>
	</div>
	
	<div class = "background"></div>
	<div class = "main">
		<div class = "topBlank"></div>
			<div class = "middleBlank">
				<div class = "title2">비밀번호를 입력해주세요.</div>
				<input type="password" id="pwCheck" value=""/>
				<button class ="a1">cancel</button>
				<button class ="a2">ok</button>
			</div>
	</div>
	
	<c:import url="footer.jsp"></c:import>
</body>
</html>