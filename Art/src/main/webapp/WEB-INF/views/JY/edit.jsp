<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-sacle = 1.0, user-scalable=no" />
<title>작품 수정하기</title>
<link rel="stylesheet" href="resources/css/JY/edit.css">

<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery.form.js"></script>
<script type="text/javascript" src="resources/script/ckeditor/ckeditor.js"></script>

<script type="text/javascript">
function enterValue(){
	
	if(document.getElementsByClassName('badge').length == 5) {
		alert("태그는 5개까지 입력가능합니다.");
		return false;
	} else {
	var tagSpan = document.createElement('span');
	var x = document.createElement('span');	
	var xMark = 'x';
	var result = document.getElementById('tag');
	var input = document.getElementById('tagId');
	tagSpan.className='badge';
	x.className='xClass';

			
	var content = document.getElementById('tagId');
	var string = content.value;
	var string2 = string.trim();
	var string3 = string2.replace("," , "");
	
	
	
	if(string3 !== ""){
		tagSpan.append(string3);  
		x.append(xMark);
		tagSpan.append(x);
		result.append(tagSpan);  			
		input.value = null;		
	}else if(string3 == string){
		
	}
	
	}

}


$(document).ready(function() {
	
	$("#tagId").on("keypress", function(e) {
		if(e.keyCode == 13 && $(".badge").length == 5) {
			alert("태그는 5개까지 입력가능합니다.");
			return false;
		}
	});	
	
	var Tag = $("#tagId2").val().split(',');
	console.log(Tag);
	for(var i = 0; i < Tag.length; i++) {
		var tagSpan = document.createElement('span');
		var x = document.createElement('span');	
		var xMark = 'x';
		var result = document.getElementById('tag');
		var input = document.getElementById('tagId');
		tagSpan.className='badge';
		x.className='xClass';

		tagSpan.append(Tag[i]);  
		x.append(xMark);
		tagSpan.append(x);
		result.append(tagSpan);  			
	}
	

	
	$("#tag").on("click", ".xClass", function() {
		$(this).parent().remove();
	});
	
	CKEDITOR.replace("contentsIn", {
		resize_enabled : false,
		language : "ko",
		enterMode : "2",
		toolbarGroups : [
			{ name: 'basicstyles', groups: ['basicstyles']},
			{ name: 'paragraph', groups: ['align']},
			{ name: 'colors', groups: ['colors']},
			{ name: 'insert', groups: ['insert']}
		],
		removeButtons: 'Subscript,Superscript,Flash,PageBreak,Iframe,Language,BidiRtl,BidiLtr,CreateDiv,ShowBlocks,Save,NewPage,Preview,Templates,Image'
	});
	
	
	$("#upload").on("click", function () {
		$("#postFile").click();
	});
	
	$('#titleInput').each(function() {
		var text = $(this).text();
		$(this).text(text.replace("\"", "&quot;"));
	});
	
	$("#btnCancel").on("click", function () {
		if(confirm("이 페이지를 벗어나면 수정 내용이 저장되지 않습니다.")) {
			history.back();
		} else {
			
		}
	});
	
	$("#btnSave").on("click", function(){
		
		$("#contentsIn").val(CKEDITOR.instances['contentsIn'].getData());
		var Text = $('.badge').text();
		var Tag = Text.split('x');
		$('#tag2').val(Tag);
		console.log($('#tag2').val());
		
		
		// 사진 수정을 안 할 경우
		var filekeep = $('#uploadFile').attr("src").substring(17);
		
		if($('#postFileKeep').val() == filekeep) {
			$('#postFile2').val(filekeep);
		}
		console.log($('#postFile2').val());
		
		if($("#postFile2").val() == "") {
			alert("작품을 올려주세요.");
			$("#upload").focus();
			return false;// ajaxForm 실행 불가
		} else if($('#video').val() == "" && $("#categoryNo").val() == '3') {
			alert("영상 링크를 첨부해주세요.");
			$("#video").focus();
			return false;
		} else if($("#titleInput").val() == "") {
			$("#titleInput").focus();
			return false;
		} else if($("#contentsIn").val() == "") {
			alert("작품을 설명해주세요.");
			$("#contentsIn").focus();
			return false;
		} else {
			
			
			
			var params= $("#updateForm").serialize();
			
			$.ajax({
				url: "edits", // 접속 주소
				type: "post", // 전송 방식: get, post
				dataType: "json", // 받아올 데이터 형태
				data: params, // 보낼 데이터(문자열 형태)
				success: function(res) { // 성공 시 다음 함수 실행
				    if(res.msg == "success") {
				    	alert("정상적으로 작품 수정되었습니다.");
				    	history.go(-2);
				    	
					} else if(res.msg == "failed") {
						alert("작품 수정에 실패하였습니다.");
					} else {
						alert("작성 중 문제가 발생하였습니다.");
					}
				},
				error: function(request, status, error) { // 실패 시 다음 함수 실행
					console.log(error);
				}
			});
	  	}
	    
	});
	

	$("#postFile").on("change", function() {
			
			var fileForm = $("#fileForm");
			
	
			fileForm.ajaxForm({
				beforeSubmit : function() {
				
	
			},
			success : function(res) {
				if(res.result = "SUCCESS") {
					 // 올라간 파일명 저장
					 if(res.fileName.length > 0) {
						 $("#postFile2").val(res.fileName[0]);
					 }
					  
					$("#uploadFile").attr("src", "resources/upload/" + $('#postFile2').val());
		 
					
					} else {
						alert("파일업로드 중 문제 발생");
					}
				},
				error : function() {
					alert("파일업로드 중 문제 발생");
				} 
			}); // ajaxForm End
	
			fileForm.submit();
		});	// postFile click End
});
</script>
</head>
<body>
<form id="fileForm" action="fileUploadAjax" method="post" enctype="multipart/form-data">
		<input type="file" name="postFile" id="postFile" />
</form>
<form action="#" id="updateForm" method="post">
	<input type="hidden" id="tag2" name="tag" value="">
	<input type="hidden" name="page" value="${param.page}" />
	<input type="hidden" id="postNo" name="postNo" value="${param.pNo}" />
	<input type="hidden" id="categoryNo" name="categoryNo" value="${data.CATEGORY_NO}" />
	<input type="hidden" id="tagId2"  value="${data.TAG_NAME}" />
	<c:choose>
		<c:when test="${empty sUserNo}">
			<c:import url="header2.jsp"></c:import>
		</c:when>
		<c:otherwise>
			<c:import url="header.jsp"></c:import>
		</c:otherwise>
	</c:choose>
	<input type="hidden" name="userNo" value="${data.USER_NO}">
	<div class="wrap">
	
	<c:choose>		
			<c:when test="${data.CATEGORY_NO eq '3'}">
					<div class="upload_wrap">
						<img id="uploadFile" src="resources/upload/${data.POST_FILE}" width="400px" height="400px">
						<input type="hidden" id="postFileKeep" value="${data.POST_FILE}"/>  			
						<input type="button" id="upload"/>
						<input type="hidden" name="postFile2" id="postFile2" value=""/>  
					</div>
					<input type="text" id="video" name="postFile3" value='${data.VIDEO_LINK}' placeholder="유튜브 링크를 입력해주세요." />
			</c:when>

			<c:otherwise>
				<div class="upload_wrap">
					<img id="uploadFile" src="resources/upload/${data.POST_FILE}" width="400px" height="400px">
					<input type="hidden" id="postFileKeep" value="${data.POST_FILE}"/>  			
					<input type="button" id="upload"/>
					<input type="hidden" name="postFile2" id="postFile2" value=""/>
					<input type="hidden" id="video" name="postFile3" value="" />
				</div>
			</c:otherwise>	
		</c:choose>
	
			
		<div class="title_input_w"><input name="title" id="titleInput" type="text" value='${data.TITLE}' placeholder="제목을 입력해주세요."></div>
		<div class="contents_in_w"><textarea id="contentsIn" name="explain" cols="80" rows="10" placeholder="작품을 뽐내주세요.">${data.EXPLAIN}</textarea></div>

		<div class="tag_input_w">
			<%-- <c:forEach var="i" items="${array}">
				<input id="tagId" value ="${i}" type="text" placeholder="태그 입력 후 스페이스나 엔터를 눌러주세요."  onkeyup="if(window.event.keyCode==13||window.event.keyCode==32||window.event.keyCode==188){(enterValue())}"/>
			</c:forEach> --%>
			<input id="tagId" value ="" type="text" placeholder="태그 입력 후 엔터키를 눌러주세요." maxlength="5" onkeyup="if(window.event.keyCode==13){(enterValue())}"/>
			<div id="tag" class="tagsinput"></div>
		</div>
		<div class="secret">공개 설정</div>
		
		<div class="public_privacy">
			<c:choose>
				<c:when test="${data.VISIBILITY == 0}">
					<input name="public_privacy" value="0" type="radio" checked="checked" /><label id="public">공개</label>
					<input name="public_privacy" value="1" type="radio" /><label id="privacy">비공개</label>
				</c:when>
				<c:otherwise>
					<input name="public_privacy" value="0" type="radio" /><label id="public">공개</label>
					<input name="public_privacy" value="1" type="radio" checked="checked" /><label id="privacy">비공개</label>
				</c:otherwise>
			</c:choose>
			
		</div>
		<br />
		<div class="save_cancel">
			<input id="btnSave" type="button" value="수정하기">
			<input id="btnCancel" type="button" value="취소하기">
		</div>
	</div>
</form>	
	<c:import url="footer.jsp"></c:import>
</body>
</html>