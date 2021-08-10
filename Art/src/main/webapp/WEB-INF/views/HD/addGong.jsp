<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>edit</title>
<link rel="stylesheet" href="resources/css/HD/writingManager.css">
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery.form.js"></script>
<script type="text/javascript" src="resources/script/ckeditor/ckeditor.js"></script>

<script type="text/javascript">
$(document).ready(function() {
	CKEDITOR.replace("cttsIn", {
		resize_enabled : false,
		language : "ko",
		enterMode : "2",
		width: "1330",
		height: "500",
	});
	
	
	
	$("#btnCcl").on("click", function () {
		location.href="gong_board";
	});
	
	$("#btnSave").on("click", function () {
		var fileForm = $("#fileForm");

		
		console.log(fileForm);
		
		fileForm.ajaxForm({ 
			beforeSubmit: function (data, frm, opt) { 
				if($.trim($("#titleInput").val()) == ''){
					alert("제목을 작성해주세요.");
				} else if(CKEDITOR.instances.cttsIn.getData().length < 1){
					alert("내용을 입력해주세요");
				}
				/* return true; */ // 처리할거 없으면 beforsSubmit 없애도 된다.
			}, 
			success: function(res){//매개변수로 여러개 받을 수 있다.
				if(res.result =="SUCCESS"){
					if(res.fileName.length >0){
						$("#fileName").val(res.fileName[0]);
					}
					$("#cttsIn").val(CKEDITOR.instances.cttsIn.getData());
					var params = $("#goForm").serialize();
					
					$.ajax({
						url : "addGongs",
						type : "post",
						dataType : "json",
						data : params,
						success: function (res) {
							if(res.msg == "success"){
								location.href = "gong_board"						
							} else if(res.msg == "failed"){
								alert("작성에 실패하였습니다.")
							} else{
								alert("작성중 문제가 발생하였습니다.")
							}
						},
						error : function (request, status, error) {
							console.log(error);
						}
					});
					
					
					
				} else {
					alert("저장실패");
				} 
			}, //ajax error
			error: function(){
				alert("에러발생!!"); 
			}
		});//fileForm done
			fileForm.submit();
	});
	
	$("#fileBtn").on("click", function () {
		$("#att").click();
	});
	
	$("#att").on("change", function () {
		$("#fileNameOnBoard").html($(this).val().substring($(this).val().lastIndexOf("\\")+1));
	});
	
	
	
});
</script>
</head>
<!--여기는 두가지 form이 있다. 1.fileForm(그저 파일에 대한 요소들) 2.goForm(cont  -->
	<body>
	 <form action=fileUploadAjax id=fileForm method=post enctype=multipart/form-data>;
		 	<input style="display:none;" type=file name=att id=att>;
	 </form>;
	<c:choose>
		<c:when test="${empty sUserNo}">
			<c:import url="../JY/header2.jsp"></c:import>
		</c:when>
		<c:otherwise>
			<c:import url="../JY/header.jsp"></c:import>
		</c:otherwise>
	</c:choose>
	<div class="wrap">
		<!-- <div id="editPage">작품올리기</div> -->
		<!-- <div id="glySet">작품관 선택</div>
		<br /> -->
		<form action="#" id="goForm" method="method">
			<input type="hidden" id="fileName" name="fileName" value="">
			<%-- <input type="hidden" id="adminNo"  name="adminNo" value=${sAdminNo }> --%>
			<!-- <div id="title">제목</div> -->
			<div id="titleInputW"><input id="titleInput" name="titleInput" type="text" value="" placeholder="제목을 입력해주세요."></div>
			<!--첨부 파일  -->
				<input id="fileBtn" type="button" value="첨부파일  : ">
				<span id="fileNameOnBoard" style="font-size: 20pt;"> </span>
			<!-- <div id="ctts">작품설명</div> -->
			<div id="cttsInW"><textarea id="cttsIn" name="cttsIn" cols="80" rows="10" placeholder="작품을 뽐내주세요."> </textarea></div>
			 <!-- <div id="tag">태그</div> -->
			<!--<div id="tagInputW"><input  name="tagInput"id="tagInput" type="text" value="" placeholder="태그를 입력해주세요.(예 : #구름)"></div> -->
		</form>
		<br />
		<div class="save_ccl">
			<input id="btnSave" type="button" value="저장하기">
			<input id="btnCcl" type="button" value="취소하기">
		</div>
	</div>
	<div class="ftr">
		<a href="main"><img src="resources/images/JY/art2_w.png" id="btnLogo2" alt="로고" width="70px" height="50px"></a>
		<div class="ftr_pae">You can be an art writer.</div>
		<div id="ftr1"><a href="#">관리방침 안내</a></div>
		<div id="ftr2"><a href="#">도움말 안내</a></div>
		<div id="ftr3"><a href="#">회원가입 및 글게시 안내</a></div>
		<div id="ftr4"><a href="#">홈페이지 서비스 안내</a></div>
	</div>
</body>

</html>