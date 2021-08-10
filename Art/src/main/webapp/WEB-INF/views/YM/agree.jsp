<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-sacle = 1.0, user-scalable=no" />
<title>약관동의</title>
</head>
<style type="text/css">
[type="button"] {
	cursor: pointer;
}

h2 {
	font-size: 4em;
    margin-top: 8vw;
	margin-bottom: 10px;
	text-align: center;
}

*{
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body{

	background-color: #f7f7f7;
}

ul>li{
	
	list-style: none
}

a{

	text-decoration: none;
}

.clear_fix::after{

	content: "";
	display: block;
	clear: both;
}

#agreeForm{
	width: 80%;
	margin: 0 auto;
}

input[type=checkbox] {
	/* -webkit-transform: scale(2); */
	padding: 10px;

}

ul.join_box{
	
	border: 1px solid #ddd;
	background-color: #fff;
}

.checkbox,.checkbox>ul{

	position: relative;
	margin-bottom: 15px;
}

.checkbox>ul>li{
	font-size: 1em;
	float: left;
}

.checkbox>ul>li:first-child{

	width: 85%;
	padding: 15px;
	font-weight: 600;
	color: #888;
}

.checkbox>ul>li:nth-child(2){

	position: absolute;
	top: 50%;
	right: 30px;
	margin-top: -12px;
}

.text{
	width: 96%;
	height: 28vw; 
	margin: 0 auto;
	background-color: #f7f7f7;
	color: #888; 
	border: none;
	padding: 10px;
	overflow: auto; 
}

.button_wrap {
	margin-top: 20px;
	margin-bottom: 50px;
	text-align: center;
	display: inline-block;
	width: 100%;
	font-size: 0.6em;
}

#btnNo {
	width: 50%;
	height: 11vw;
	background-color: #fff;
	color:#888;
	display: inline-block;
	border: none;
	float: left;
	font-size: 3em;
}

#btnOk{
	width: 50%;
	height: 11vw;
	background-color: #ffad33;
	color: #fff;
	display: inline-block;
	border: none;	
	float: left;
	font-size: 3em;
}
</style>
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	$("#checkAll").on("click", function() {
		// is(셀렉터) : 셀렉터에 해당되는가?
		// prop(기준) : 기준 상태를 돌려줌. ex) checked => 체크된 상태인지
		if($(this).is(":checked")) {
		$(".join_box input").prop("checked", true); // prop : 상태를 가져오거나 지정
		} else {
		$(".join_box input").prop("checked", false); // prop : 상태를 가져오거나 지정
		}
		
	});
	
	$("#checkAll").on("click", function() {
		if($("input[name='check']:checked").length == 3) {
		$("#checkAll").prop("checked", true);
		} else {
		$("#checkAll").prop("checked", false);
		}
		
	});

	$(".join_box").on("click", "[type='checkbox']", function() {
		if($(".check_btn [type='checkbox']").length
						== $(".check_btn [type='checkbox']:checked").length) {
			$("#checkAll").prop("checked", true);
		} else {
			$("#checkAll").prop("checked", false);
		}
		
	});
	
	
	$("#btnOk").on("click", function() {
		
		if($("#check1").is(":checked") && $("#check2").is(":checked")) {
			
			$("#agreeForm").submit();
		} else {
			alert("필수약관에 동의해주세요.");
		}
	});
	$("#btnNo").on("click", function() {
			location.href="login";
		
	});
});
</script>
<body>
<form action="signUp" method="post" id="agreeForm">
		<h2>Art</h2>
            <ul class="join_box">
                <li class="checkbox">
                    <ul class="clear_fix">
                        <li>이용약관, 개인정보 수집 및 이용, 프로모션 안내
                            메일 수신(선택)에 모두 동의합니다.</li>
                        <li class="check_all_btn">
                            <input type="checkbox" name="checkAll" id="checkAll" class="check">
                        </li>
                    </ul>
                </li>
                <li class="checkbox">
                    <ul class="clear_fix">
                        <li>이용약관 동의(필수)</li>
                        <li class="check_btn">
                            <input type="checkbox" id="check1" class="check" name="check"> 
                        </li>
                    </ul>
                    <div class="text">
                    	제 1 조 (목적)
                    	<br/>
						1. 본 약관은 Art 사이트가 제공하는 모든 서비스(이하 "서비스")의 이용조건 및 절차, 이용자와 기업마당 사이트의 권리, 의무, 책임사항과 기타 필요한 사항을 규정함을 목적으로 합니다.
						<br/>
						제 2 조 (약관의 효력과 변경)
						<br/>
						1. Art 사이트는 귀하가 본 약관 내용에 동의하는 경우 기업마당 사이트의 서비스 제공 행위 및 귀하의 서비스 사용 행위에 본 약관이 우선적으로 적용됩니다.
						<br/>
						2. Art 사이트는 본 약관을 사전 고지 없이 변경할 수 있고 변경된 약관은 기업마당 사이트 내에 공지하거나 e-mail을 통해 회원에게 공지하며, 공지와 동시에 그 효력이 발생됩니다.
						<br/>
						이용자가 변경된 약관에 동의하지 않는 경우, 이용자는 본인의 회원등록을 취소 (회원탈락)할 수 있으며 계속 사용의 경우는 약관 변경에 대한 동의로 간주 됩니다.
						<br/>
						제 3 조 (약관 외 준칙)
						<br/>
						1. 본 약관에 명시되지 않은 사항은 전기통신기본법, 전기통신사업법, 정보통신윤리위원회심의규정, 정보통신 윤리강령, 프로그램보호법 및 기타 관련 법령의 규정에 의합니다.
                    </div>
                </li>
                <li class="checkbox">
                    <ul class="clear_fix">
                        <li>개인정보 수집 및 이용에 대한 안내(필수)</li>
                        <li class="check_btn">
                            <input type="checkbox" id="check2" class="check" name="check">
                        </li>
                    </ul>
 
                    <div class="text">Art는 「개인정보보호법」 제15조제1항제1호, 제17조제1항제1호, 제23조제1호, 제24조제1항 제1호에 따라 아래와 같이 개인정보의 수집. 이용에 관하여 귀하의 동의를 얻고자 합니다.
                    	<br/>
                    	Art는 이용자의 사전 동의 없이는 이용자의 개인정보를 함부로 공개하지 않으며, 수집된 정보는 아래와 같이 이용하고 있습니다. 이용자가 제공한 모든 정보는 아래의 목적에 필요한 용도 이외로는 사용되지 않으며 이용 목적이 변경될 시에는 이를 알리고 동의를 구할 것입니다.
						<br/>
						개인정보의 수집 및 이용 동의
						<br/>
						1. 개인정보의 수집 및 이용 목적
						<br/>
						가. 서비스 제공에 관한 업무 이행 - 컨텐츠 제공, 특정 맞춤 서비스 제공(마이페이지, 뉴스레터 등), 기업 애로상담
						<br/>
						나. 회원관리
						<br/>
						- 회원제 서비스 이용 및 제한적 본인 확인제에 따른 본인확인, 개인식별, 가입의사 확인, 가입 및 가입횟수 제한, 추후 법정 대리인 본인확인, 분쟁 조정을 위한 기록보존, 불만처리 등 민원처리, 공지사항 전달
						2. 수집하는 개인정보의 항목
						<br/>
						필수항목 : 아이디, 비밀번호, 이름, 핸드폰번호, 이메일, 암호화된 이용자 확인값(CI)
						<br/>
						선택항목 : 이메일 수신여부
						<br/>
						3. 개인정보의 보유 및 이용기간
						<br/>
						Art는 원칙적으로 보유기간의 경과, 개인정보의 수집 및 이용목적의 달성 등 그 개인정보가 불필요하게 되었을 때에는 지체 없이 파기합니다. 다만, 다른 법령에 따라 보존하여야 하는 경우에는 그러하지 않을 수 있습니다. 불필요하게 되었을 때에는 지체 없이 해당 개인정보를 파기합니다.
						<br/>
						회원정보
						<br/>
						-탈퇴 후 지체없이 파기
						<br/>
						4. 동의거부권 및 불이익
						<br/>
						정보주체는 개인정보 수집에 동의를 거부할 권리가 있습니다. 다만, 필수 항목에 대한 동의를 거부할 시 저희가 제공하는 서비스를 이용할 수 없습니다.
                    </div>
                </li>
                <li class="checkbox">
                    <ul class="clear_fix">
                        <li>이벤트 등 프로모션 알림 메일 수신(선택)</li>
                        <li class="check_btn">
                            <input type="checkbox" class="check" name="eventAgree" value="0">
                        </li>
                    </ul>
                 <div class="text">
                 	1. 개인정보의 수집 및 이용 목적
                 	<br/>
					신규 서비스 개발 및 마케팅ㆍ광고에의 활용
					<br/>
					- 신규 서비스 개발, 이벤트 및 광고성 정보 제공 및 참여기회 제공, 접속 빈도 등 회원의 서비스 이용에 대한 통계
					<br/>
					2. 수집하는 개인정보의 항목
					<br/>
					필수항목 : 이름
					<br/>
					선택항목 : 이메일, 연락처(휴대전화번호, 유선전화번호 중 1개 선택)
					<br/>
					3. 개인정보의 보유 및 이용기간
					<br/>
					이용목적의 달성 후 지체없이 파기
					<br/>
					4. 동의거부권 및 불이익
					<br/>
					개인정보의 마케팅/홍보의 수집 및 이용 동의를 거부하시더라도 회원 가입 시 제한은 없습니다. 다만, 마케팅 활용 서비스 안내 및 참여에 제한이 있을 수 있습니다.
				</div>
                </li>
            </ul>
            <div class="button_wrap">
                <input type="button" id="btnNo" value="취소">
                <input type="button" id="btnOk" value="확인"> 
            </div>            
        </form>
     
</body>
</html>