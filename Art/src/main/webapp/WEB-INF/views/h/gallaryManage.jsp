<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><!--EL Tag 확장기능  --> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 관리</title>
<style type="text/css">
tbody tr:hover {
	background-color: #f2f2f2;
}


@charset "UTF-8";

.background2 {
	width: 100%;
	height: 100%;
	position: absolute;
	background-color: #000000;
	opacity:0.3;
	z-index: 100;
}


.wrap2 {
	position: absolute;
	width: 1330PX;
	height: 800px;
	top: 50%;
	left: 50%;
	margin-top: -410px;
	margin-left: -660px;
	background-color: #ffffff;
	padding: 16px;
	z-index: 1000;
	overflow-y: scroll;
    overflow-x: hidden;
    border-radius: 16px;
}

#BtnSave {
	right: 74px;
}

</style>

<link rel="stylesheet" href="resources/css/h/gallary_manage.css"/>
<!-- Popup CSS -->
<link rel="stylesheet" href="resources/css/h/detail_popup.css">
<script type="text/javascript"
	src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery.form.js"></script>
<script type="text/javascript" src="resources/script/ckeditor/ckeditor.js"></script>
<script type="text/javascript">

function enterValue(){
	
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
$(document).ready(function(){

	
	
	//---------------------------------------데이터 가져오기
	$("#page").val(1);
	loadPostList();
	
	$("#actionForm").on("keypress", "input", function(event){
		if(event.keyCode == 13){
			return false;
		}
	});
	
	
	//사이드바, 탭 고정시키기
	$(".gallary").attr("id", "active");
	$(".menu_tab_wrap div:first-child").attr("class", "tab_selected");
	
	//menuTab클릭했을 때 
	$(".menu_tab_wrap").on("click", "div", function(){
		
		$(".menu_tab_wrap div").attr("class", "tab");
		$(this).attr("class", "tab_selected");
		
 		if($(this).attr("id") == "entire"){
 			$("#menuTabFlag").val(0);
 			$("#page").val(1);
			
		} else if($(this).attr("id") == "picture"){
			$("#menuTabFlag").val(1);
			$("#page").val(1);
			
		} else if($(this).attr("id") == "drawing"){
			$("#menuTabFlag").val(2);
			$("#page").val(1);
			
		} else{
			$("#menuTabFlag").val(3);
			$("#page").val(1);
		}	 
		loadPostList();
		
	});
	
	//상세보기
	$("tbody").on("dblclick", "tr", function(){
		$("#postNo").val($(this).attr("name"));
		drawPopup();
	});
	
	
	//검색버튼 누르면 준비중입니다 알람
	$(".btn_notyet").on("click", function(){
		alert("준비중입니다.");
	});
	
	//검색시
	$("#searchBtn").on("click", function(){
		$("#page").val(1);
		$("#searchOldTxt").val($("#searchTxt").val());
		loadPostList();
	});//예전 검색어 다시 확인하기 flag들 확인하기
	
	//삭제된,삭제제외,삭제포함 버튼 클릭시
	$("#BtnWith").off("click");
	$("#BtnWith").on("click", function(){
		$("#delFlag").val("");
		$("#page").val(1);
		console.log($("#delFlag").val());
		loadPostList();
	});

	$("#BtnWithDel").off("click");
	$("#BtnWithDel").on("click", function(){
		$("#delFlag").val("0");
		$("#page").val(1);
		loadPostList();
	});
	
	$("#BtnWithoutDel").off("click");
	$("#BtnWithoutDel").on("click", function(){
		$("#delFlag").val("1");
		$("#page").val(1);
		loadPostList();
	});
	
	//삭제버튼 클릭시
	$("#BtnDelete").on("click", function(){
		var confirmFlag = confirm("삭제 하시겠습니까?");
					
		if(confirmFlag){
			var checkCnt = $("tbody [name=checkbox]:checked").length;
			
			if(checkCnt == 0){
				alert("선택된 작품이 없습니다.");
			} else {
			
				var checkArr = new Array();
			
				$("tbody [name=checkbox]:checked").each(function() {
					checkArr.push($(this).val());//item이 this라서 this로 많이쓴다나~
				});
								
				$("#checkedArr").val(checkArr);					
				deleteChecked();
				
			}//else
		}	
	});//delete btn click
	
	//복원버튼 클릭시
	$("#BtnReturn").on("click", function(){
		var confirmFlag = confirm("복원 하시겠습니까?");
					
		if(confirmFlag){
			var checkCnt = $("tbody [name=checkbox]:checked").length;
			
			if(checkCnt == 0){
				alert("선택된 작품이 없습니다.");
			} else {
			
				var checkArr = new Array();
			
				$("tbody [name=checkbox]:checked").each(function() {
					checkArr.push($(this).val());//item이 this라서 this로 많이쓴다나~
				});
								
				$("#checkedArr").val(checkArr);					
				returnChecked();
				
			}//else
		}	
	});//return btn click
	

	
	
	//전체체크하면 전체적으로 체크되게 하기
	$("#checkAll").on("click", function(){
		if($(this).is(":checked")){
			$(".result_table input").prop("checked", true);
		} else {
			$(".result_table input").prop("checked", false);
		}
	});
	
	//하나라도 체크 풀면 전체체크박스 해제되기
	$(".result_table").on("click", "[type='checkbox']", function(){
		if($(".table_tr [type='checkbox']").length
				== $(".table_tr [type='checkbox']:checked").length){
			$("#checkAll").prop("checked", true);
		} else {
			$("#checkAll").prop("checked", false);
		}

		//console.log($(".result_table [type='checkbox']").length);
		//console.log($("#tableTr [type='checkbox']:checked").length);
	});

	
	
	
	
	
	
	
/* 	//클릭시 색상 변하기.............미완성
	$(".result_table").on("click", "tr", function(){
		if( $(this).attr("id") == "c"){
			$("#c [type='checkbox']").prop("checked", false);
			$(this).attr("id", "");
			
		} else {
			$(this).attr("id", "c");
			$("#c [type='checkbox']").prop("checked", true);
		}
			
	}); */

	
	
	
	
	


	

	//페이징 버튼 클릭시 새로 list 가져오기
	$("#pagingWrap").on("click", "span", function(){
		$("#page").val($(this).attr("name"));	
		$("#searchTxt").val($("#searchOldTxt").val());
		loadPostList();
	});
	
	
	
	
	//-------------------------------------------------------ajax실행
	function loadPostList(){
		var params = $("#actionForm").serialize();
		$.ajax({
			url: "entireList",
			type: "post",
			dataType: "json",
			data: params,
			success: function(result){
				
				drawList(result.list);
				drawPaging(result.pb);
				showCnt(result.cnt);
				
			}, error: function(request, status, error){
				console.log(error);
			}
		});
	}

	
	//-------------------------------------------------------목록그리기
	function drawList(list){
		var html = "";
		var no = 0;
		
		if(list.length == 0 && $("#page").val() == 1) {
			html += "<tr>";
			html += "<td colspan=\"50\">등록된 글이 없습니다.</td>";
			html += "</tr>";
		} else {
			for(var d of list){
				++no;
				html +="<tr name=\"" + d.POST_NO + "\" class=\"table_tr\">";
				html +="<td><input type=\"checkbox\" name=\"checkbox\" value=\"" + d.POST_NO + "\"></td>";
				html +="<td>" + no + "</td>";
				html +="<td>" + d.POST_NO + "</td>";
				html +="<td>" + d.CATEGORY_NAME + "</td>";
				html +="<td>" + d.TITLE + "</td>";
				html +="<td>" + d.NAME + "</td>";
				html +="<td>" + d.NICKNAME +"(" + d.USER_ID + ")</td>";
				html +="<td>" + d.REGISTER_DATE + "</td>";
				html +="<td>" + d.VIEWS + "</td>";
				html +="<td>" + d.LIKE_CNT + "</td>";
				html +="</tr>";
			}
		}
		
		$("tbody").html(html);
		
	}
	
	
	
	
	//-------------------------------------------체크된 테이블 행을 삭제하는 아작스
	function deleteChecked(){
		var params = $("#actionForm").serialize();
		
		$.ajax({
			url: "deleteGallary",
			type: "post",
			dataType: "json",
			data: params,
			success: function(res){ 
				
				if(res.msg == "success"){
					$("#checkAll").prop("checked", false);
					loadPostList();	
				} else if(res.msg == "failed"){
					alert("삭제에 실패하였습니다.");
				} else {
					alert("삭제 중 문제가 발생하였습니다.");
				}						
			},
			error: function(request, status, error){
				console.log(error);
				
			}
		
		});			
	}
	
	//-------------------------------------------삭제된거 복구하는 아작스
	function returnChecked(){
		var params = $("#actionForm").serialize();
		
		$.ajax({
			url: "returnDel",
			type: "post",
			dataType: "json",
			data: params,
			success: function(res){ 
				
				if(res.msg == "success"){
					$("#checkAll").prop("checked", false);
					location.href = "gallaryManage";	
				} else if(res.msg == "failed"){
					alert("복원에 실패하였습니다.");
				} else {
					alert("복원 중 문제가 발생하였습니다.");
				}						
			},
			error: function(request, status, error){
				console.log(error);
				
			}
		
		});			
	}
	
	//-------------------------------------------------------상세보기그리기
	function drawPopup(){
		var params = $("#actionForm").serialize();
		
		$.ajax({
			url: "drawUserPopup",
			type: "post",
			dataType: "json",
			data: params,
			success: function(result){
				
				var html = "";
                
				html +="	<div class=\"background\"></div>";
				html +="	<div class=\"wrap\">";
				html += "		<form id=\"detailForm\">";
				html += "		<input type=\"hidden\" name=\"postNo\" value=\"" + result.data.POST_NO + "\" />";
				html +="	<div class=\"popup_title\">관리자용 상세보기</div>";
				html +="	<div class=\"close_btn_wrap\">";
				html +="	<input type=\"button\" id=\"BtnUpdate\" value=\"수정\"/>";
				html +="	<input type=\"button\" id=\"BtnClose\" value=\"닫기\"/>";
				html +="	</div>";
				html +="	<div class=\"contents_wrap\">";
				
				
				
				if(result.data.CATEGORY_NAME == '영상작품관') {
					html += result.data.VIDEO_LINK;
				} else {
					if(result.data.POST_FILE != null && result.data.POST_FILE != "") {
						html +=" <a><img class=\"contents_img\" src=\"resources/upload/"+ result.data.POST_FILE
									+"\" alt=\"작품이미지\" download=\""+ result.data.POST_UFILE +"\"></a>";
					} else {
						html +=" <img class=\"contents_img\" src=\"resources/images/JY/짱구1.jpg\" alt=\"사랑스런짱구\">";
					}
				}

				html +="	</div>";
				html +="	<div class=\"category\">"+ result.data.CATEGORY_NAME +"</div>";
				html +="	<div class=\"title\">"+ result.data.TITLE +"</div>";
				html +="	<div class=\"contents_date\"> 작성시간: "+ result.data.REGISTER_DATE +"&nbsp;&nbsp;";					
				html +="조회수: "+ result.data.VIEWS +"&nbsp;&nbsp;좋아요수: "+ result.data.LIKE_CNT +"&nbsp;&nbsp;";					
					
				var checkV = result.data.VISIBILITY;
					
					if(checkV == "0"){
						 html +="	공개</div><br/><br/>";						
					} else {
						 html +="	비공개</div><br/><br/>";
					}
				
				html +="	<div class=\"contents\">"+ result.data.EXPLAIN +"</div>";				
				html +="	<div class=\"tag_wrap\">";

				if(result.data.TAGS != null && result.data.TAGS != "") {
					
					var tagSplit = (result.data.TAGS).split(",");
					
					for(var t of tagSplit){
						html +="<i class=\"small_tag\"># "+ t +"</i>";
					}
				}
				     
				html +="	<div class=\"comment_wrap\">";
				html +="	<img class=\"comment_img\" src=\"resources/images/JY/comment.png\" alt=\"댓글아이콘\">";
				html +="	<div class=\"comment\">댓글 "+ result.data.COMMENT_CNT+"개</div>";
				html +="	</div></div><br/>";
				html +="	<div class=\"mini_profile_wrap\">";
				html +="	<div class=\"mini_profile\">";
				
				if(result.data.PROFILE_IMG_PATH != null && result.data.PROFILE_IMG_PATH != "") {
					html +=" <a><img class=\"profile_img2\" src=\"resources/upload/"+ result.data.PROFILE_IMG_PATH
								+"\" alt=\"프로필이미지\" download=\""+ result.data.PROFILE_IMG_UPATH+"\"></a>";
				} else {
					html +=" <img class=\"profile_img2\" src=\"resources/images/JY/who.png\" alt=\"기본프로필\">";
				}
				
				html +="	</div><div class=\"mini_profile_name\">"+ result.data.USER_NICKNAME +"</div>";
				html +="	<div class=\"profile_introduce\">"+ result.data.INTRODUCE +"</div>";
				html +="	</div>";
				html +="	</div>";
				html +="	</form>";
				
				$("body").prepend(html);
				
				$(".background").hide();
				$(".wrap").hide();				
				$(".background").fadeIn();
				$(".wrap").fadeIn();
				
				$("#BtnClose").off("click");
				$("#BtnClose").on("click", function(){
					closePopup();
				});
				
				$(".background").off("click");
				$(".background").on("click", function(){
					closePopup();
				});
				
				/*----------------------------------------------수정버튼 클릭할 때  */
				$("#BtnUpdate").off("click");
				$("#BtnUpdate").on("click", function(){
					closePopup();
					drawEdit();

				});
				
				
				
			}, error: function(request, status, error){
				console.log(error);
			}
		});
	}
	
	
	

	//상세팝업닫기
	function closePopup() {
		$(".background").fadeOut(function(){
			$(".background").remove();
		});
		
		$(".wrap").fadeOut(function(){
			$(".wrap").remove();
		});
		
		$(".background2").fadeOut(function(){
			$(".background2").remove();
		});
		
		$(".wrap2").fadeOut(function(){
			$(".wrap2").remove();
		});
	}
			
			
//-------------------------------------------------------------------수정하기해보자
	function drawEdit(){
		var params = $("#actionForm").serialize();
	
		$.ajax({
			url: "drawUserPopup",
			type: "post",
			dataType: "json",
			data: params,
			success: function(result){
				
				var html = "";
				html += "<form id=\"fileForm\" action=\"fileUploadAjax\" method=\"post\" enctype=\"multipart/form-data\">";
				html += "<input type=\"file\" name=\"postFile\" id=\"postFile\" />";
				html += "</form>";
				html +="	<div class=\"background2\"></div>";
				html +="	<div class=\"wrap2\">";
				html += "		<form id=\"actionForm\">";
				html +="<input type=\"hidden\" id=\"tag2\" name=\"tag\">"
				html += "		<input type=\"hidden\" name=\"postNo\" value=\"" + result.data.POST_NO + "\" />";
				html +="	<div class=\"popup_title\">관리자용 상세보기</div>";
				html +="	<div class=\"save_btn_wrap\">";
				html +="	<input type=\"button\" id=\"BtnSave\" value=\"저장\"/>";
				html +="	<input type=\"button\" id=\"BtnClose2\" value=\"닫기\"/>";
				html +="	</div>";
				html +="	<div class=\"contents_wrap\">";
				
				if(result.data.POST_FILE != null && result.data.POST_FILE != "") {
					/* html +=" <img class=\"contents_img\" src=\"resources/upload/"+ result.data.POST_FILE
								+"\" alt=\"작품이미지\" download=\""+ result.data.POST_UFILE +"\">"; */
					if(result.data.CATEGORY_NAME == '영상작품관') {
						html += "<div class=\"upload_wrap\">";
						html += "<img id=\"uploadFile\" src=\"resources/upload/" + result.data.POST_FILE + "\" width=\"400px\" height=\"400px\">";
						html += "<input type=\"hidden\" id=\"postFileKeep\" value=\"" + result.data.POST_FILE + "\"/>";  			
						html += "<input type=\"button\" id=\"upload\"/>";
						html += "<input type=\"hidden\" name=\"postFile2\" id=\"postFile2\"/>";
						html += "</div>";
						html += "<input type=\"text\" id=\"video\" name=\"postFile3\" value=\'" + result.data.VIDEO_LINK + "\' maxlength=\"150\" placeholder=\"유투브 링크를 입력해주세요.\" />";
					} else {
						html += "<div class=\"upload_wrap\">";
						html += "<img id=\"uploadFile\" src=\"resources/upload/" + result.data.POST_FILE + "\" width=\"400px\" height=\"400px\">";
						html += "<input type=\"hidden\" id=\"postFileKeep\" value=\"" + result.data.POST_FILE + "\"/>";  			
						html += "<input type=\"button\" id=\"upload\"/>";
						html += "<input type=\"hidden\" name=\"postFile2\" id=\"postFile2\"/>";
						html += "<input type=\"hidden\" id=\"video\" name=\"postFile3\" value=\"\" />";
						html += "</div>";
					}
				} else {
					html +=" <img class=\"contents_img\" src=\"resources/images/JY/짱구1.jpg\" alt=\"사랑스런짱구\">";
				}

				html +="	</div>";
				html +="	<div class=\"category\">"+ result.data.CATEGORY_NAME +"</div>";
				html +="	<div class=\"title\"><input type=\"text\"class=\"title_input\" size=\"78\" name=\"title\" id=\"title\" value=\"" + result.data.TITLE + "\" /></div>";
				html +="	<div class=\"contents_date\"> 작성시간: "+ result.data.REGISTER_DATE +"&nbsp;&nbsp;"							
				html +="조회수: "+ result.data.VIEWS +"&nbsp;&nbsp;좋아요수: "+ result.data.LIKE_CNT +"&nbsp;&nbsp;";					
					
				/* var checkV = result.data.VISIBILITY;
					
					if(checkV == "0"){
						 html +="	공개</div><br/><br/>";						
					} else {
						 html +="	비공개</div><br/><br/>";
					} */
				
				html +="	<div class=\"contents\">";
				html +="	<textarea id=\"explainCK\" name=\"explain\" cols=\"50\" rows=\"10\" placeholder=\"작품을 뽐내주세요.\">" + result.data.EXPLAIN +"</textarea></div>";
				
				/* html +="	<div class=\"tag_wrap\">";

				if(result.data.TAGS != null && result.data.TAGS != "") {
					
					var tagSplit = (result.data.TAGS).split(",");
					
					for(var t of tagSplit){
						html +="<i class=\"small_tag\"># "+ t +"</i>";
					}
				} */
				html +="<div class=\"secret\">공개 설정</div>";
				html +="<div class=\"public_privacy\">";
				if(result.data.VISIBILITY == 0) {
					html +="<input name=\"public_privacy\" value=\"0\" type=\"radio\" checked=\"checked\" /><label id=\"public\">공개</label>";
					html +="<input name=\"public_privacy\" value=\"1\" type=\"radio\" /><label id=\"privacy\">비공개</label>";
				} else {
					html +="<input name=\"public_privacy\" value=\"0\" type=\"radio\"/><label id=\"public\">공개</label>";
					html +="<input name=\"public_privacy\" value=\"1\" type=\"radio\" checked=\"checked\" /><label id=\"privacy\">비공개</label>";
				}
				html +="</div>"
				html +="<div class=\"tag_wrap\">"
				
				if(result.data.TAGS == null || result.data.TAGS == ''){
					html +="<input id=\"tagId\" type=\"text\" placeholder=\"태그 입력 후 스페이스나 엔터를 눌러주세요.\"  onkeyup=\"if(window.event.keyCode==13||window.event.keyCode==32||window.event.keyCode==188){(enterValue())}\"/>"
				} else {
					html +="<input id=\"tagId\" value =\"" + result.data.TAGS + "\" type=\"text\" placeholder=\"태그 입력 후 스페이스나 엔터를 눌러주세요.\"  onkeyup=\"if(window.event.keyCode==13||window.event.keyCode==32||window.event.keyCode==188){(enterValue())}\"/>"					
				}
				
				html +="<div id=\"tag\" class=\"tagsinput\"></div>"
				html +="</div>"
				html +="	<div class=\"comment_wrap\">";
				html +="	<img class=\"comment_img\" src=\"resources/images/JY/comment.png\" alt=\"댓글아이콘\">";
				html +="	<div class=\"comment\">댓글 "+ result.data.COMMENT_CNT+"개</div>";
				html +="	</div><br/>";
				html +="	<div class=\"mini_profile_wrap\">";
				html +="	<div class=\"mini_profile\">";
				
				if(result.data.PROFILE_IMG_PATH != null && result.data.PROFILE_IMG_PATH != "") {
					html +=" <img class=\"profile_img2\" src=\"resources/upload/"+ result.data.PROFILE_IMG_PATH
								+"\" alt=\"프로필이미지\" download=\""+ result.data.PROFILE_IMG_UPATH+"\">";
				} else {
					html +=" <img class=\"profile_img2\" src=\"resources/images/JY/who.png\" alt=\"기본프로필\">";
				}
				
				html +="	</div><div class=\"mini_profile_name\">"+ result.data.USER_NICKNAME +"</div>";
				html +="	<div class=\"profile_introduce\">"+ result.data.INTRODUCE +"</div>";
				html +="	</div>";
				html +="	</div>";
				html +="	</form>";
				
				$("body").prepend(html);
				
				$(".background2").hide();
				$(".wrap2").hide();				
				$(".background2").fadeIn();
				$(".wrap2").fadeIn();
				
				$("#BtnClose2").off("click");
				$("#BtnClose2").on("click", function(){
					closePopup();
				});
				
				$("#tag").on("click", ".xClass", function() {
					$(this).parent().remove();
				});
				
				$(".background2").off("click");
				$(".background2").on("click", function(){
					closePopup();
				});
				
				/*----------------------------------------------저장 클릭할 때  */
				$("#BtnSave").off("click");
				
				CKEDITOR.replace("explainCK", {
					resize_enabled : false,
					language : "ko",
					enterMode : "2",
					width: "1330",
					height: "500",
					removeButtons: 'Subscript,Superscript,Flash,PageBreak,Iframe,Language,BidiRtl,BidiLtr,CreateDiv,ShowBlocks,Save,NewPage,Preview,Templates,Image'
				});
				
				$("#upload").on("click", function () {
					$("#postFile").click();
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
				});
								
				
				$("#BtnSave").on("click", function(){
					$("#explainCK").val(CKEDITOR.instances['explainCK'].getData());			
										
					var Text = $('.badge').text();
					var Tag = Text.split('x');
					$('#tag2').val(Tag);
					
					var filekeep = $('#uploadFile').attr("src").substring(17);
					
					if($('#postFileKeep').val() == filekeep) {
						$('#postFile2').val(filekeep);
					}
					
					
					if($.trim($("#title").val()) == ""){
						alert("제목을 입력해주세요.");
						$("#title").focus();
						return false;
					}else if($("#explainCK").val() == ""){
						alert("작품을 설명해주세요.");
						$("#explainCK").focus();
						return false;
					}else {
						//글 수정하기
						var params = $("#actionForm").serialize();
						
						$.ajax({
							url: "drawEdits",
							type: "post",
							dataType: "json",
							data: params,
							success: function(result){
								
								if(result.msg == "success"){
									$("#actionForm").attr("action", "gallaryManage");
									$("#actionForm").submit();
									alert("정상적으로 작품 수정되었습니다.");
								} else if(result.msg == "failed"){
									alert("수정에 실패하였습니다.");
								} else {
									alert("수정 중 문제가 발생하였습니다.");
								}
								
							}, error: function(request, status, error){
								console.log(error);
							}
							
						});
					}
					
				});
				
				
				
			}, error: function(request, status, error){
				console.log(error);
			}
		});
	}
	
	
	
	
	
	
	
	
	//총 tr 개수 가져오기
	function showCnt(cnt){
		var html = "";		
		
		html += "<div class=\"result_cnt\">결과: " + cnt +"개</div>";
		html += "<div class=\"button_wrap\">";
		html += "</div>";
		
		$(".cnt_wrap").html(html);
		
	}//SHOWCNT end
	
	
	//-------------------------------------------------------페이징 그리기
	function drawPaging(pb){
		var html = "";
		
		html += "<span name=\"1\">처음</span>";
		
		if($("#page").val()== "1"){
			html += "<span name=\"1\">이전</span>";
			
		} else {
			html += "<span name=\"" + ($("#page").val() - 1) + "\">이전</span>";	
		}
		
		for(var i = pb.startPcount; i<= pb.endPcount; i++){
			if($("#page").val() == i){
				html += "<span name=\"" + i + "\"><b>" + i + "</b></span>";
				
			} else {
				html += "<span name=\"" + i + "\">" + i + "</span>";
			}
		}
		
		if($("#page").val() == pb.maxPcount){
			html += "<span name=\"" + pb.maxPcount + "\">다음</span>";
			
		} else {
			html += "<span name=\"" + ($("#page").val() * 1 + 1) + "\">다음</span>";
		}
			
		html += "<span name=\"" + pb.maxPcount + "\">마지막</span>";
		
		$("#pagingWrap").html(html);
	}	
	
	
	
	

	
});//ready


</script>
</head>
<body>
<div class="main">
	<c:import url="managerSidebar.jsp"></c:import>
	<div class ="ctts">
<!------------------------------게시글 신고 관리  -->
		<div class ="blank2"></div>
		
		<div class="menu_tab_wrap">
			<div id="entire" class="tab">전체목록</div>
			<div id="picture" class="tab">사진</div>
			<div id="drawing" class="tab">그림</div>
			<div id="movie" class="tab">영상</div>
		</div>
		<div class="menu_txt_wrap">
			<div class="menu_txt">
				<span><span class="font-red">검색어를 입력</span>하여 검색할 수 있습니다.</span><br/>
				<span><span class="font-red">제목</span>을 연속으로 두 번 클릭하시면 수정페이지로 이동합니다.</span><br/>
				<span><span class="font-red">데이터가 많은 경우</span> 느려질 수 있습니다.</span>
			</div>
		</div>
<!-----------------------------------------------데이터 전송  -->
<form action="#" id="actionForm" method="post" >
	<input type="hidden" id="postNo" name="postNo"/>
	<input type="hidden" id="delFlag" name="delFlag" value="-1"/>
	<input type="hidden" id="page" name="page" value="${page}"/>
	<input type="hidden" id="checkedArr" name="checkedArr"/>
	<input type="hidden" id="menuTabFlag" name="menuTabFlag" value="0"/>
	
		<div class ="search_flag_div">
			<div class="search_flag">
				<label>작품분류</label>
				<select name="srhYearFlag" id="srhYearFlag">
					<option value="0"> 올해작품</option>
					<option value="1"> 작년작품</option>
					<option value="2" selected="selected"> 전체작품</option>
				</select>
				<label>검색분류</label>
				<select name="searchFlag" id="searchFlag">
					<option value="2" selected="selected">제목</option>
					<option value="3">내용</option>
					<option value="4">작성자</option>
					<option value="5">번호</option>
					<option value="7">제목+내용</option>
				</select>
				<input type="hidden" id="searchOldTxt" value="${param.searchTxt}"/>
				<input type="text" name="searchTxt" id="searchTxt" value="${param.searchTxt}" placeholder="검색어를 입력해주세요."/>
				<div class="date_srh">
					<label>날짜분류</label>
						<input type="date" id="startFlag" name="startFlag">
						<span> ~ </span>
						<input type="date" id="endFlag" name="endFlag" min="2021-01-01">
						<input type="button" value="검색" id="searchBtn"/>
						<input type="button" value="삭제된" id="BtnWithDel"/>
						<input type="button" value="삭제안된" id="BtnWithoutDel"/>
						<input type="button" value="삭제포함" id="BtnWith"/>
				</div>
			</div>
		</div>
		<div class="del_wrap">
			<input type="button"  id="BtnReturn" value="복원"/>
			<input type="button" id="BtnDelete" value="삭제"/>		
		</div>
		<div class="cnt_wrap"></div>
</form>
		<!-----------------------------------------------------------테이블 -->
		
		
		<div class="result_table" id="tabResult1">
			<table class="table1">
				<colgroup>
						<col width="50px"/>
						<col width="50px"/>
						<col width="100px"/>
						<col width="150px"/>
						<col width="900px"/>
						<col width="100px"/>
						<col width="300px"/>
						<col width="100px"/>
						<col width="100px"/>
						<col width="100px"/>
					</colgroup>
				<thead>	
				<tr id="tableTh">
					<th>
					<input type="checkbox" id="checkAll"> 
					</th>
					<th>번호</th>
					<th>글번호</th>
					<th>카테고리</th>
					<th>제목</th>
					<th>작성자</th>
					<th>닉네임(아이디)</th>
					<th>작성일</th>
					<th>조회수</th>
					<th>좋아요수</th>
				</tr>
				</thead>
				<tbody></tbody>
			</table>
		</div>
		<div id="pagingWrap"></div>
	</div>
</div>
</body>
</html>