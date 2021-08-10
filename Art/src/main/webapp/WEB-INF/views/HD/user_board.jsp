<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원관리 페이지</title>
<link rel="stylesheet" href="resources/css/HD/user_board.css"/>
<link rel="stylesheet" href="resources/css/HD/login.css"/>
<link rel="stylesheet" href="resources/css/HD/user_detail(byBoard).css">
<link rel="stylesheet" href="resources/css/HD/email.css"/>
<link rel="stylesheet" href="resources/css/HD/memo.css"/>
<!-- <link rel="stylesheet" href="resources/css/HD/managerSide.css"/> -->


<script type="text/javascript"
	src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript"
		src="resources/script/jquery/jquery.form.js"></script>

<script type="text/javascript">
$(document).ready( function () {
	 if("${param.searchType}" != "" || "${param.searchGbn}" != ""){
		$("#searchType").val("${param.searchType}");
		$("#searchGbn").val("${param.searchGbn}");
	}
	 $("#allUserList").attr("class","bigClassActive");
	 
	 $("#allUserList").on("click", function () {
		 if($("#allUserList").attr("class") != "bigClassActive" ){
		  	$("#allUserList").attr("class","bigClassActive");
			$("#userForm").submit();
		 }
	});
		
/* 	if("${param.searchGbn}" != ""){
		$("#searchGbn").val("${param.searchGbn}");
	} */
		 
	 $(".delete_btn").on("click", function () {
		 $(".PmainL, .PbackgroundL").show();
		
		$("#cancel_btn").on("click", function () {
			$(".PbackgroundL, .PmainL").hide();
		}); 
	});//deletbtn end
	
	
	//----------------------------------------------이메일 띄우기
		$("#emailBtn").on("click", function () {
			var list = new Array();
			$(".main3-table [name=userNo]:checked").each(function(index,item) {
				list.push($(item).val());
			});
			
			$("#userNo").val(list);
			
			
			if($("#userNo").val() == null || $("#userNo").val() == "" ){
				alert("메일 대상자를 선택해주세요");
			}else{
					$(".PmainM, .PbackgroundM").show();
					loadEmailList();
					$("input[type=checkbox]").prop("checked",false);
					
					$("#canel_btnM").on("click", function () {
						$(".PmainM, .PbackgroundM").hide();
						
					});
				
	//--------------------------------------------------------이메일 폼 누르기
				
				$(".PmainM #fileBtn").on("click", function () {
					console.log("실행 여부");
					$("#attMail").click();
				});
				
				$(".PmainM #attMail").on("change", function () {
					$("#fileNameForMail").val($(this).val().substring($(this).val().lastIndexOf("\\")+1));
					$("#fileFormM").val($("#fileNameForMail").val());
					var d = $("#fileNameForMail").val()
					$("#fileNameForMail").val(d.substr(20))
					
					
				});
				
				$("#sendBtnM").on("click", function () {
					
					$("#titleForm").val($("#title").val());
					$("#contentsForm").val($("#contents").val());
					
					var list = new Array();
					$(".PmainM [class=mail]").each(function(index,item) {
						list.push($(this).attr("name"));
					});
					
					console.log(list);
					
					$("#emailForm").val(list);
					
					
					var params = $("#mailForm").serialize();
					
					$.ajax({
						url : "sendMail",
						type : "post",
						dataType : "json",
						data : params,
						success: function (res) {
							$("#titleForm").val("");
							$("#contentsForm").val("");
							$("#fileFormM").val("");
							$("#emailForm").val("");
							$(".PmainM, .PbackgroundM").hide();
						},
						error : function (request, status, error) {
							console.log(error);
						}
					});
					
				});
			}
	});//end email_btn
	
	
	
	//---------------------------------------------------검색 기능
	
	
	$("#searchBtn").on("click", function () {
		if($("#outUserList").attr("class") =="bigClassActive")	{
			$("#outUserList").attr("class","bigClassActive");
			$("#allUserList").attr("class","bigClass-1");
			$(".main3-table tbody").empty();
			$("#pagingWrap").empty();
			drawOutList()
		}else{
			$("#page").val(1);
			if($("#searchGbn").val() == 4){
				if($("#searchTxt").val() == "남"){
					$("#searchTxt").val("0");
				}else{
					$("#searchTxt").val("1");
				}
			}
			$("#userForm").submit();
			
		}
	});
	
	
	$("#resetBtn").on("click", function () {
		$("input[name='searchTxt']").val("");
		$("#searchType option:eq(0)").prop("selected",true);
		$("#searchGbn option:eq(0)").prop("selected",true);
		$("#startDate").val("");
		$("#endDate").val("");
		
	});
	
	
	//-----------------------------------------side 클릭시 변경 script
	var now ='${now}';
	$('.'+now).attr("id","active");
	
	$(".side").on("click","div", function () {
		if($(this).attr("id") != "active"){
			$('.'+ now).attr("id","");
			if($(this).attr("class") == "member"){
				location.href = "user_board";
				$(".member").attr("id","active");
			}else if($(this).attr("class") == "tag"){
				location.href = "tag_board";
				$(".tag").attr("id","active");
			}else if($(this).attr("class") == "product"){
				location.href = "product_board";
				$(".product").attr("id","active");
			}else if($(this).attr("class") == "warning"){
				location.href = "warning_board";
				$(".warning").attr("id","active");
			}else if($(this).attr("class") == "gong"){
				location.href = "gong_board";
				$(".gong").attr("id","active");
			}
		}
		
	});
	//------------------------------------------side 클릭시 변경 script
	$("#pagingWrap").on("click","span", function () {
		$("#page").val($(this).attr("name"));
		$("#userForm").submit();
	});
	
	//---------------------------------------paging 이벤트
	$(".Pmain #pagingWrap").on("click",".Pmain span", function () {
		$(".Pmain #page").val($(this).attr("name"));
		$(".Pmain #userForm").submit();
	});
	
	//---------------------------------Ajax 상세페이지 그리기, 더블 클릭 상세보기
	$("tbody").on("dblclick","tr", function () {
		/* $(".Pmain, .background").show();*/
		$("#userNo").val($(this).attr("name"));
		drawPopup();
		
	
	

	});//end dblclick
		
	$("body").on("click",".background", function () {
		$(".popupWrap").empty(); // 함수 empty() 해당 객체 안에 있는 것들을 비운다.
	});
	
	//---------------------------------- 팝업 페이지 안에 있는 기능 수행하기
	/* $(document).on("click", ".Pmain #searchBtnDP", function () {
		console.log(" 상세페이지 검색 버튼 작동한다.");
		$(".Pmain .boxForBoard").empty();
		drawPopup();
		
	}); */
	
	//---------------------------------------업데이트
	$(".main3-table tbody").on("click", ".update_btn" ,function () {
		$("#PmainDP .topBar").show();
		$("#userNo").val($(this).parent().parent().attr("name"));
		
		drawUpdatePopup();
	});
	
	
	
	
	//메모 작품 버튼들
	 $(document).on("click",".Pmain #insideMiddle2", function () {
		if($(".Pmain #insideMiddle2").attr("class") != "insideMiddle1"){
			$(".Pmain #insideMiddle2").attr("class","insideMiddle1")
			$(".Pmain #insideMiddle1").attr("class","insideMiddle2")
		}else{
			$(".Pmain #insideMiddle2").attr("class","insideMiddle1")
			$(".Pmain #insideMiddle1").attr("class","insideMiddle2")
		}
	});
	$(document).on("click",".Pmain #insideMiddle1", function () {
		if($(".Pmain #insideMiddle1").attr("class") != "insideMiddle1"){
			$(".Pmain #insideMiddle1").attr("class","insideMiddle1")
			$(".Pmain #insideMiddle2").attr("class","insideMiddle2")
		}else{
			$(".Pmain #insideMiddle1").attr("class","insideMiddle1")
			$(".Pmain #insideMiddle2").attr("class","insideMiddle2")
		}
	});
	
	$("#outUserList").on("click", function () {
		$("#outUserList").attr("class","bigClassActive");
		$("#allUserList").attr("class","bigClass-1");
		$(".main3-table tbody").empty();
		$("#pagingWrap").empty();
		drawOutList();
	});
	$(".main3-table tbody").on("click", ".delete_btn" ,function () {
		$("#userNo").val($(this).parent().parent().attr("name"));
		delOneRow();
	});
	
	//----------------------------------------------------전체 선택 
	$("#all_check").on("click", function () {
		if($(this).is(":checked")){
			$("input[type=checkbox]").prop("checked",true);
		}else{
			$("input[type=checkbox]").prop("checked",false);
		}
	});
	
	
	
	// 선택 삭제 버튼 클릭시
	$("#selectDelBtn").on("click", function () {
		var list = new Array();
		$(".main3-table [name=userNo]:checked").each(function(index,item) {
			list.push($(item).val());
		});
		
		$("#userNo").val(list);
		delOneRow(list); 
		
	});
	
	$("#addBtn").on("click", function () {
			alert("준비중입니다.");
	});
	
	/* $(".update_btn").on("click", function () {
		alert("준비중입니다.");
	}); */
	
	$(document).on("click", ".Pmain #deleteBtnDM",function () {
		$("#memoNo").val($(this).parent().parent().attr("name"));
		$("#userNoMemo").val($("#userNo").val());
		
		var params = $("#memoForm").serialize();
		
		$.ajax({
			url : "delReportMemo",
			type : "post",
			dataType : "json",
			data : params,
			success: function (res) {
				if(res.msg == "success"){
					$(".Pmain table").empty();
					$(".topOfBox .topBar").empty();
					listDM(res.list,1);
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
	});
	
	$(document).on("click", ".Pmain #searchBtnDP",function () {
		$("#userNoMemoS").val($("#userNo").val());
		var params = $(".Pmain #searchForm").serialize();
		
		$.ajax({
			/* url:"user_update", */
			url:"getMemoList",
			type:"post",
			dataType :"json",
			data:params,
			success : function (res) {
					listDM(res.list,1);			
			},
			error: function (request, status, error) {
				console.log(error);
			}
	});
		
		
	});
	
	
});
//document end
//----------------------------------------- 상세페이지 팝업 그려주는 함수 
function drawPopup() {
	$("#searchGbnDP").val($("#PsearchGbnDP").val());
	$("#searchTxtDP").val($("#PsearchTxtDP").val());
	
	var params = $("#detailForm").serialize();
	
	$.ajax({
		url:"user_datailP",
		type:"post",
		dataType :"json",
		data:params,
		success : function (res) {
			console.log(res.user);
			console.log(res.list);
			console.log(res.listM);
			
			drawPopUpDP(res.user);
			
			
			listDP(res.list);
			
		/* 	$(".Pmain #searchBtnDP").on("click", function () {
				console.log(" 상세페이지 검색 버튼 작동한다.");
				$(".Pmain .boxForBoard").empty();
				listDP(res.list)
			});
			 */
			
			$("#insideMiddle1").on("click", function () {
				if($("#insideMiddle1").attr("class") != 'insideMiddle1'){
				console.log("이거 찍히는데 뭐냐");
				$(".topOfBox .topBar").empty();
					$(".Pmain table").empty();
					listDP(res.list)
				}
			});
			 $("#insideMiddle2").on("click", function () {
				if($("#insideMiddle2").attr("class") != 'insideMiddle1'){
					/* $(".Pmain table").empty();
					$(".topOfBox .topBar").empty();
					listDM(res.listM,0); */
					//0은 수정 삭제 없이, 1은 수정 삭제 있이
					$("#memoWrap").empty();
					listDM(res.listM,1);
				}
			}); 
		},
		error: function (request, status, error) {
			console.log(error);
		}
});
}
//--------------------------------------------- 상세페이지 수정
function drawUpdatePopup() {
	
	var params = $("#detailForm").serialize();
	
	$.ajax({
		/* url:"user_update", */
		url:"user_datailP",
		type:"post",
		dataType :"json",
		data:params,
		success : function (res) {
			
			drawUpdateDP(res.user);
			listDP(res.list);
			$("#insideMiddle1").on("click", function () {
				if($("#insideMiddle1").attr("class") != 'insideMiddle1'){
				console.log("이거 찍히는데 뭐냐");
				$(".topOfBox .topBar").empty();
					$(".Pmain table").empty();
					listDP(res.list)
				}
			});
			
			 $("#insideMiddle2").on("click", function () {
				if($("#insideMiddle2").attr("class") != 'insideMiddle1'){
					$(".Pmain table").empty();
					listDM(res.listM,1);
					
				}
			});
			 
			 
			
		},
		error: function (request, status, error) {
			console.log(error);
		}
});
	
}
//------------------------------------수정 버튼 클릭하기
function userUpdate() {
	
	var params = $("#updateForm").serialize();
	console.log("this is params >>>>" + params);
	$.ajax({
		url:"user_update",
		type:"post",
		dataType :"json",
		data:params,
		success : function (res) {
			
			if(res.msg == "success"){
				alert("업데이트 되었습니다.");
			}else{
				alert("작성 중 문제가 발생하였습니다.");
			}
			
		},
		error: function (request, status, error) {
			console.log(error);
		}
});
//----------------------------------------- 상세페이지 팝업 그려주는 함수 
}
function delOneRow() {
	var params = $("#detailForm").serialize();
	
	$.ajax({
		url:"delOneRow",
		type:"post",
		dataType :"json",
		data:params,
		success : function (res) {
			alert("탈퇴/복구되었습니다.");
			location.href="user_board";
		},
		error: function (request, status, error) {
			console.log(error);
		}
});
}
//--------------------------------------- 탈퇴회원 리스트 그리는 함수
function drawOutList() {
	var params = $("#userForm").serialize();
	
	$.ajax({
		url:"out_user_list",
		type:"post",
		dataType :"json",
		data:params,
		success : function (res) {
			var what = "pagingWrapOut"
			outList(res.list);
			pagingDraw(res.pb, what);
		},
		error: function (request, status, error) {
			console.log(error);
		}
});
}

 function drawPopUpDP(user) {
	var html="";
				html +=	"  <div class= \"background\" id=\"PbackgroundDP\"></div>";
				html +=	"  <div class =\"Pmain\" id=\"PmainDP\">";
				html +=	"  <div class =\"topBar\">";
				html +=	"	<div class =\"blank\"></div>";
				html +=	"  </div>";
				html +=	"  <div class = \"profile\">";
				html +=	"  	  <div class =\"pBox\">";
				
				if(user.PROFILE_IMG_PATH != null && user.PROFILE_IMG_PATH != ""){
					html +=	"		  <img class =\"img\" alt=\"프로필사진\" src=\"resources/upload/"+ user.PROFILE_IMG_PATH +"\">";
				}else{
					html +=	"			  <img class =\"img\" alt=\"프로필사진\" src=\"resources/images/HD/profile.png\">";
				}
				
				html +=	"		  <div class =\"cButtonB\"></div>";
				html +=	"		  <div class =\"cButtonc\">";
				html +=	"			  <img class =\"cButtonI\" alt=\"취소버튼\" src=\"resources/images/HD/cancel.png\">";
				html +=	"		  </div>";
				html +=	"	  </div>";
				html +=	"	  <input class =\"pName\" type =\"text\" placeholder=\"" +user.USER_NICKNAME + "\" readonly=\"readonly\">";
				html +=	"  </div>";
				html +=	"  <div class =\"writeBox\" >";
				html +=	"	  <div class = \"blank_cancelPop\">";
				html +=	"	  <img class=\"closeBtn\" src=\"resources/images/HD/close.png\">";
				html +=	"	  </div>";
				html +=	"	  <div class = \"blank1\">회원상세정보</div>";
				html +=	"		  <div class = \"smallBox\">";
				html +=	"			  <div class =\"MsmallBox\">";
				html +=	"				  <div class=\"informing\">이름</div>";
				html +=	"				  <div class=\"content_box\">" + user.NAME + "</div>";
				html +=	"			  </div>";
				html +=	"			  <div class =\"MsmallBox\">";
				html +=	"				  <div class=\"informing\">회원번호</div>";
				html +=	"				  <div class=\"content_box\">" + user.USER_NO + "</div>";
				html +=	"			  </div>";
				html +=	"			  <div class =\"MsmallBox\">";
				html +=	"				  <div class=\"informing\">전화번호</div>";
				html +=	"				  <div class=\"content_box\">" + user.PHONE_NO + "</div>";
				html +=	"			  </div>";
			
				html +=	"		  </div>";
				html +=	"		  <div class = \"smallBox\">";
				html +=	"			  <div class =\"MsmallBox\">";
				html +=	"				  <div class=\"informing\">성별</div>";
				html +=	"				  <div class=\"content_box\">" + user.SEX + "</div>";
				html +=	"			  </div>";
				html +=	"			  <div class =\"MsmallBox\">";
				html +=	"				  <div class=\"informing\">생년월일</div>";
				html +=	"				  <div class=\"content_box\">" +user.BIRTHDAY + "</div>";
				html +=	"			  </div>";
				html +=	"			  <div class =\"MsmallBox\">";
				html +=	"				  <div class=\"informing\">이메일</div>";
				html +=	"				  <div class=\"content_box\">" +user.MAIL + "</div>";
				html +=	"			  </div>";
				html +=	"		  </div>";
				
				html +=	"		  <div class=\"introduce_box\">";
				html +=	"			  <div class=\"sogea\"><b>소개</b></div>";
				html +=	"			  <div class=\"sogea_box\">";
				html +=	"			  " +user.INTRODUCE + "";
				html +=	"			  </div>";
				html +=	"		  </div>";
				html +=	"     </div>";
			
				html +=	"     <div class =\"middleSection\">";
				html +=	"	     <div class = \"brick\"></div>";
				html +=	"	     <input type=\"button\" class =\"insideMiddle1\" id=\"insideMiddle1\" value=\"작품\">";
				html +=	"	     <input type=\"button\" class =\"insideMiddle2\" id=\"insideMiddle2\" value=\"메모\">";
				html +=	"	     <div class = \"underLine\"></div>";
				html +=	"     </div>";
				html +=	"     <div class =\"boxForB\">";
				html +=	"	  <div class =\"topOfBox\">";
				html +=	"		  <div class =\"topBar\"></div>";
				html +=	"	  </div>";
				html +=	"	  <div class =\"boxForBoard\">";
				html +=	"	  <table>";
						//list 공간
				                                                                                                                                                 
				html +=	"		</table>";
				html +=	"		</div>";
				html +=	"	</div>";

				html +=	"  </div>";
	$(".popupWrap").prepend(html);
	
	//위의 html을 그린 이후의 위의 html기반(id or class)의기능들은 여기서 부터 시작 됨으로 이 안에 적용시켜야한다. 안에 들어가 있어야한다.
	
	$(".cButtonI").hide();
	
	$(".Pmain .closeBtn").on("click", function () {
		$(".popupWrap").empty();
	});
	
 	  
}  
 
 function drawUpdateDP(user) {
	var html="";
				html += "<form action=\"fileUploadAjax\" id=\"fileForm\" method=\"post\" enctype=\"multipart/form-data\"> ";
				html += 	"<input type=\"file\" name=\"att\" id=\"att\" style=\"display:none;\">";
				html += "</form>";
				html +=	"  <div class= \"background\" id=\"PbackgroundDP\"></div>";
				html +=	"  <div class =\"Pmain\" id=\"PmainDP\">";
				html +=	"  <div class =\"topBar\">";
				html +=	"	<div class =\"blank\"></div>";
				html +=	"  </div>";
				html += "<form action=\"user_board\" id=\"updateForm\" method=\"psot\">";
				html += " <input type=\"hidden\" name=\"fileName\" id=\"fileName\" value=\""+ user.PROFILE_IMG_PATH +"\">";
				html += "<input type=\"hidden\" name=\"userNo\" value=\""+ user.USER_NO +"\">";
				html +=	"  <div class = \"profile\">";
				html +=	"  	  <div class =\"pBox\">";
				if(user.PROFILE_IMG_PATH != null && user.PROFILE_IMG_PATH != ""){
					html +=	"		  <img class =\"img\" alt=\"프로필사진\" src=\"resources/upload/"+ user.PROFILE_IMG_PATH +"\">";
				}else{
					html +=	"			  <img class =\"img\" alt=\"프로필사진\" src=\"resources/images/HD/profile.png\">";
				}
				
				html +=	"		  <div class =\"cButtonB\"></div>";
				html +=	"		  <div class =\"cButtonc\">";
				html +=	"			  <img class =\"cButtonI\" alt=\"취소버튼\" src=\"resources/images/HD/cancel.png\">";
				html +=	"		  </div>";
				html +=	"	  </div>";
				html +=	"	  <input class =\"pName\"id=\"userNickName\" name=\"userNick\" type =\"text\" value=\"" +user.USER_NICKNAME + "\">";
				html += "<input type=\"button\" value=\"수정하기\" class=\"decideBtn\" id=\"decideBtn\" style=\"width: 100px; height : 40px; margin-top:10px;\">";
				html +=	"  </div>";
				html +=	"  <div class =\"writeBox\" >";
				html +=	"	  <div class = \"blank_cancelPop\">";
				html +=	"	  <img class=\"closeBtn\" src=\"resources/images/HD/close.png\">";
				html +=	"	  </div>";
				html +=	"	  <div class = \"blank1\">회원상세정보</div>";
				html +=	"		  <div class = \"smallBox\">";
				html +=	"			  <div class =\"MsmallBox\">";
				html +=	"				  <div class=\"informing\">이름</div>";
				html +=	"				  <div class=\"content_box\">" + user.NAME + "</div>";
				html +=	"			  </div>";
				html +=	"			  <div class =\"MsmallBox\">";
				html +=	"				  <div class=\"informing\">회원번호</div>";
				html +=	"				  <div class=\"content_box\" name=\"userNo\" value=\""+ user.USER_NO +"\">" + user.USER_NO + "</div>";
				html +=	"			  </div>";
				html +=	"			  <div class =\"MsmallBox\">";
				html +=	"				  <div class=\"informing\">*전화번호</div>";
				html +=	"				  <div class=\"content_box\" ><input type =\"text\" id=\"phone_no\" value=\""+ user.PHONE_NO+ "\" name=\"phon_no\"></div>";
				html +=	"			  </div>";
			
				html +=	"		  </div>";
				html +=	"		  <div class = \"smallBox\">";
				html +=	"			  <div class =\"MsmallBox\">";
				html +=	"				  <div class=\"informing\">성별</div>";
				html +=	"				  <div class=\"content_box\">" + user.SEX + "</div>";
				html +=	"			  </div>";
				html +=	"			  <div class =\"MsmallBox\">";
				html +=	"				  <div class=\"informing\">생년월일</div>";
				html +=	"				  <div class=\"content_box\">" +user.BIRTHDAY + "</div>";
				html +=	"			  </div>";
				html +=	"			  <div class =\"MsmallBox\">";
				html +=	"				  <div class=\"informing\">*이메일</div>";
				html +=	"				  <div class=\"content_box\"><input type =\"text\" id=\"email\"  value=\""+ user.MAIL +"\" name=\"email\"></div>";
				html +=	"			  </div>";
				html +=	"		  </div>";
				
				html +=	"		  <div class=\"introduce_box\">";
				html +=	"			  <div class=\"sogea\"><b>*소개</b></div>";
				html +=	"			  <div class=\"sogea_box\">";
				html +=	"			  <textarea id=\"sogeaTxt\" name=\"sogeaTxt\" style=\"width:100%;height:100%;overflow:hidden;\" >" +user.INTRODUCE + "</textarea>";
				html +=	"			  </div>";
				html +=	"		  </div>";
				html +=	"     </div>";
				html += "		</form>";	
				html +=	"     <div class =\"middleSection\">";
				html +=	"	     <div class = \"brick\"></div>";
				html +=	"	     <input type=\"button\" class =\"insideMiddle1\" id=\"insideMiddle1\" value=\"작품\">";
				html +=	"	     <input type=\"button\" class =\"insideMiddle2\" id=\"insideMiddle2\" value=\"메모\">";
				html +=	"	     <div class = \"underLine\"></div>";
				html +=	"     </div>";
				html +=	"     <div class =\"boxForB\">";
				html +=	"	  <div class =\"topOfBox\">";
				html +=	"		  <div class =\"topBar\"></div>";
				/* html +=	"		  <div class =\"searchBox\">";
				html +=	"			  <select id=\"PsearchGbnDP\">";
				html +=	"				  <option value=\"0\">선택없음</option>";
				html +=	"				  <option value=\"1\">제목</option>";
				html +=	"				  <option value=\"2\">태그</option>";
				html +=	"			  </select>";
				html +=	"			  <input type=\"text\" placeholder=\"검색어를 입력하세요\" style=\"font-size:10pt;\" id=\"PsearchTxtDP\" class=\"searchTxt\">";
				html +=	"			  <input type=\"button\" value=\"검색\" class=\"btnDP\" id=\"searchBtnDP\">";
				html +=	"			  <div class = \"blank2\"></div>";
				html +=	"			  <input type=\"button\" value=\"수정\" class=\"btnDP\" id=\"updateBtnDP\">";
				html +=	"			  <input type=\"button\" value=\"삭제\" class=\"btnDP\" id=\"deleteBtnDP\">";
				html +=	"		  </div>"; */
				html +=	"	  </div>";
				html +=	"	  <div class =\"boxForBoard\">";
				html +=	"	  <table>";
						//list 공간
				                                                                                                                                                 
				html +=	"		</table>";
				html +=	"		</div>";
				html +=	"	</div>";

				html +=	"  </div>";
	$(".popupWrap").prepend(html);
	
	$(".Pmain .cButtonc").css("cursor", "pointer");
	//위의 html을 그린 이후의 위의 html기반(id or class)의기능들은 여기서 부터 시작 됨으로 이 안에 적용시켜야한다. 안에 들어가 있어야한다.
	$(".Pmain .closeBtn").on("click", function () {
		$(".popupWrap").empty();
	});
	
	$(".Pmain .img").on("click", function () {
		$("#att").click();
	});
	
	
	$(".popupWrap #att").on("change", function () {
		console.log("작동중");
		$("#fileName").val($(this).val().substring($(this).val().lastIndexOf("\\")+1));
		$(".img").attr("src","resources/upload/" + $(this).val().substring($(this).val().lastIndexOf("\\")+1));
		
	});
	
	
 	
	 $(".Pmain #decideBtn").on("click",function () {
		 
		var fileForm = $("#fileForm");
		console.log(fileForm);
		
		fileForm.ajaxForm({
			beforeSubmit : function () {
				console.log("서밋 전이야!!");
				if($.trim($("#phone_no").val()) == ""){
					alert("번호을 입력해주세요.")
					return false;
				} else if($.trim($("#email").val()) == ""){
					alert("메일을 입력해주세요.");
					return false;
				} else if($.trim($("#sogeaTxt").val()) == ""){
					alert("소개란을 입력해 주세요");
					return false;
				} else if($.trim($("#userNickName").val()) == ""){
					alert("닉네임을 입력해 주세요");
					return false;
				}
		},
		
		success : function (res) {
			if(res.result=="SUCCESS"){
				// 올라간 파일명 저장 폼에 저장
				if(res.fileName.length >0){
					$("#fileName").val(res.fileName[0]);
				console.log($("#fileName").val());
				}
				//글저장
				var params = $("#updateForm").serialize();
				
				$.ajax({
					url : "user_update",
					type : "post",
					dataType : "json",
					data : params,
					success: function (res) {
						if(res.msg == "success"){
							location.href = "user_board"						
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
			}else{
				alert("업로드 실패");
			}
		},
		error : function () {
			alert("파일업로드 중 문제 발생")
		}
		});
		fileForm.submit();
	}); 
  
 
}  
 function listDM(listM,gbn) {
	var html="";
			html +=" <form id=\"memoForm\" method=\"post\" action=\"#\">";
			html +="	<input type=\"hidden\" id=\"userNoMemo\" name=\"userNo\">";
			html +="	<input type=\"hidden\" id=\"accurDateForm\" name=\"occur\">";
			html +="	<input type=\"hidden\" id=\"accurTimeForm\" name=\"accurTime\">";
			html +="	<input type=\"hidden\" id=\"memoWriterForm\" name=\"admin\">";
			html +="	<input type=\"hidden\" id=\"contentsForm\" name=\"contents\">";
			html +="	<input type=\"hidden\" id=\"importantForm\" name=\"marking\">";
			html +="	<input type=\"hidden\" id=\"memoNo\" name=\"mNo\">";
			html +=" </form>";
			html +=" <form id=\"searchForm\" method=\"post\" action=\"#\">";
			html +="	<input type=\"hidden\" id=\"userNoMemoS\" name=\"userNo\">";
			html +=	"		  <div class =\"searchBox\">";
			html +=	"			  <select id=\"PsearchGbnDP\" name=\"searchGbn\">";
			html +=	"				  <option value=\"0\">선택없음</option>";
			html +=	"				  <option value=\"1\">중요도</option>";
			html +=	"				  <option value=\"2\">메모내용</option>";
			html +=	"			  </select>"; 
			html +=	"			  <input type=\"text\" placeholder=\"검색어를 입력하세요\" style=\"font-size:10pt;\" id=\"PsearchTxtDP\" class=\"searchTxt\" name=\"searchTxt\">";
			html +=	"			  <input type=\"button\" value=\"검색\" class=\"btnDP\" id=\"searchBtnDP\">"; 
			html +=	"			  <div class = \"blank2\"></div>";
			html +=	"			  <input type=\"button\" value=\"작성\" class=\"btnDP\" id=\"addBtnDP\">";
			html +=" </form>";
			
	
	$(".topOfBox .topBar").html(html);
	
	var html="";
					
					html += "	<colgroup>";
					/* html += "		<col width=\"5%\"/>"; */
					html += "		<col width=\"10%\"/>";
					html += "		<col width=\"5%\"/>";
					html += "		<col width=\"10%\"/>";
					html += "		<col width=\"10%\"/>";
					if(gbn ==1){
							html += "		<col width=\"15%\"/>";
					}
					html += "		<col width=\"25%\"/>";
					html += "	</colgroup>";
					html += "	<tr>";
					/* html += "	<th>";
					html += "	<input class = \"check\" type=\"checkbox\" id=\"ex_chk\">   ";
					html += "	</th>"; */
					html += "	<th> no</th>";
					html += "	<th> 중요도</th>";
					html += "	<th> 발생일자</th>";
					html += "	<th> 등록일자</th>";
					if(gbn == 1){
						html += "	<th> 수정/삭제</th>";
					}
					html += "	<th> 메모내용</th>";
					html += "	</tr>";
					
					for( var d of listM){
						html += "	<tr name=\""+ d.MEMO_NO +"\">";
						/* html += "	<td>";
						html += "	<input class = \"check\" type=\"checkbox\" id=\"ex_chk\">";
						html += "	</td>"; */
						html += "	<td>"+ d.MEMO_NO +"</td>";
						if(d.MARKING == "1"){
							html += "	<td><img class=\"star_table_img\" id=\"starIconYellow\" alt=\"중요별\" src=\"resources/images/yellow_star_icon.png\"></td>";
						}else{
							html += "	<td></td>";
						}
						
						html += "	<td>"+ d.ACCUR_DATE +"</td>";
						html += "	<td>"+ d.REGI_DATE +"</td>";
						if(gbn == 1){
							html += "	<td>";
								html +=	"			  <input type=\"button\" value=\"수정\" class=\"btnDP\" id=\"updateBtnDM\">";
								html +=	"			  <input type=\"button\" value=\"삭제\" class=\"btnDP\" id=\"deleteBtnDM\">"; 
							html += "	</td>"; 
						}else{
							
						}
						html += "	<td>"+ d.CONTENTS +"</td>";
						html += "	</tr>";
					}
					
	$(".Pmain table").html(html);
	
	
	
	
	
	$("#addBtnDP").on("click", function () {
		 addMemoPop();
	});
	
	//--------------------------------------------------- 더블 클릭 상세보기
	$(".Pmain table").on("dblclick","tr", function () {
		var list;
		for(var d of listM){
			if(d.MEMO_NO == $(this).attr("name")){
				/* list.push(d);//그냥 오브젝트 담아버리기 혁명 */
				list=d;
			}
		}
		console.log(list);
		MemoPop(list);
		
	});
	
	//------------------------------------------------------- 메모 수정을 위한 데이터를 가져와 팝업창에 뿌려주고 보여준다.
	$(".Pmain table").on("click","#updateBtnDM", function () {
		/* console.log("이거 누름");
		
		var list;
		for(var d of listM){
			if(d.MEMO_NO == $(this).parent().parent().attr("name")){
				 list.push(d);//그냥 오브젝트 담아버리기 혁명  
				list=d;
			}
		}
		console.log("이거 리스트임"+list);
		updateMemoPop(list);  */
		$("#memoNo").val($(this).parent().parent().attr("name"));
		 var params = $("#memoForm").serialize();
		console.log()
		$.ajax({
			url : "reportMemo",
			type : "post",
			dataType : "json",
			data : params,
			success: function (res) {
				if(res.msg == "success"){
					updateMemoPop(res.memo);
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
		
		
	});
	
};


function MemoPop(list) {
	console.log("실행된다.");
	var html ="";
	
			html += "		<div class =\"memoBackground\"></div>                                                  ";
			html += "		<div class=\"popMemo\">                                                                ";
			html += "			<div class=\"blank\"></div>                                                        ";
			html += "			<div class=\"title\">메모등록</div>                                                ";
			html += "			<div class=\"blank\"></div>                                                        ";
			html += "			<div class=\"ctt_box\">                                                            ";
			html += "				<div class=\"what\">내용</div>                                                 ";
			html += "				<div class=\"ctt\">                                                            ";
			html += "					<div id=\"cttBox\">" + list.CONTENTS + "</div>                                                  ";
			html += "				</div>                                                                         ";
			html += "				<div class=\"blank\"></div>                                                    ";
			html += "				<div class=\"date_box\">                                                       ";
			html += "				<div class=\"what1\">작성자</div>                                              ";
			html += "				<div class=\"what1\">" + list.NAME + "</div>                                              ";
			html += "				                                                                               ";
			html += "				</div>                                                                         ";
			html += "				<div class=\"date_box\">                                                       ";
			html += "					<div class=\"what1\">발생일</div>                                          ";
			html += "					<div class=\"what1\">" + list.ACCUR_DATE + "</div>                                          ";
			html += "				</div>                                                                         ";
			html += "				<div class=\"date_box\">                                                       ";
			html += "					<div class=\"what1\">중요 </div>                                           ";
			html += "					<input type=\"checkbox\" id=\"check_test_box\" />                          ";
			html += "					<label for=\"check_test_box\"> <span></span> 체크박스입니다</label>        ";
			html += "				</div>                                                                         ";
			html += "				<div class=\"last_box\">                                                       ";
			html += "					<div class=\"last_box_blank\"></div>                                       ";
			html += "					<input type=\"button\" value=\"취소\" class=\"btn\">                       ";
			html += "				</div>                                                                         ";
			html += "			</div>                                                                             ";
			html += "		</div>                                                                                 ";
	
			 $("#memoWrap").html(html);
			
			 
			if(list.MARKING == "1"){
				console.log("실행함");
				$("#memoWrap input:checkbox[id='check_test_box']").prop("checked","true");
				$("#memoWrap #check_test_box").attr("disabled","true");
			}else{
				$("#memoWrap #check_test_box").attr("disabled","true");
			}
			$("#memoWrap .last_box .btn").on("click", function () {
				console.log("취소버튼 실행 ");
				$("#memoWrap").empty();
			});
			
			
}
//---------------------------------------------------------------------메모 수정 팝업 
function updateMemoPop(list) {
	console.log(list);
	var html ="";
	
				html +="<div class =\"memoBackground\"></div>";
				html +="			<div class=\"popMemo\">";
				html +="			<div class=\"blank\"></div>";
				html +="			<div class=\"title\">메모등록</div>";
				html +="			<div class=\"blank\"></div>";
				html +="			<div class=\"ctt_box\">";
				html +="				<div class=\"what\">내용</div>";
				html +="				<div class=\"ctt\">";
				html +="					<textarea class=\"text\">" + list.CONTENTS + "</textarea>";
				html +="				</div>";
				html +="				<div class=\"blank\"></div>";
				html +="				<div class=\"date_box\">";
				html +="				<div class=\"what1\" >작성자</div>";
				html +="				<input type=\"text\" id=\"memoWriter\" value=\""+ list.ADMIN_NAME  +"\" placeholder=\""+ list.ADMIN_NAME + "\">";
				html +="				</div>";
				html +="				<div class=\"date_box\">";
				html +="					<div class=\"what1\">발생일</div>";
				html +="					<input type=\"date\" class=\"date1\" value=\"" + list.ACCUR_DATE + "\">";
				html +="				</div>";
				html +="				<div class=\"date_box\">";
				html +="					<div class=\"what1\">중요 </div>";
				html +="					<input type=\"checkbox\" id=\"check_test_box\" />";
				html +="					<label for=\"check_test_box\"> <span></span> 체크박스입니다</label>  ";
				html +="				</div>";
				html +="				<div class=\"last_box\">";
				html +="					<div class=\"last_box_blank\"></div>";
				html +="					<input type=\"button\" value=\"취소\" class=\"btn\" id=\"cancelBtn\">";
				html +="					<input type=\"button\" value=\"수정\" class=\"btn\" id=\"updateBtnDMD\">";
				html +="				</div>";
				html +="			</div>";
				html +="		</div>";

			 $("#memoWrap").html(html);
			 
			 $(".date1").val(list.ACCUR_DATE);
			
			 
			if(list.MARKING == "1"){
				console.log("실행함");
				$("#memoWrap input:checkbox[id='check_test_box']").prop("checked","true");
			}
			
			$("#memoWrap .last_box .btn").on("click", function () {
				console.log("취소버튼 실행 ");
				$("#memoWrap").empty();
			});
			
		
			$("#userNoMemo").val($("#userNo").val());
			$("#accurDateForm").val(list.ACCUR_DATE);
			$("#contentsForm").val(list.CONTENTS);
			$("#importantForm").val(list.MARKING);
			
			$(".text").on("change", function () {
				$("#contentsForm").val($(".text").val());
			});
			$(".date1").on("change", function () {
				$("#accurDateForm").val($(".date1").val());
			});
			
			$(".popMemo input[type=checkbox]").on("change", function () {
				console.log($(".popMemo input[type=checkbox]").is(":checked"));
				if($(".popMemo input[type=checkbox]").is(":checked") == true){
					$("#importantForm").val("1");
				}else{
					$("#importantForm").val("0");
				}
			});
			
			 $(".popMemo #updateBtnDMD").on("click", function () {
				
				var params = $("#memoForm").serialize();
				
				$.ajax({
					url : "updateMemo",
					type : "post",
					dataType : "json",
					data : params,
					success: function (res) {
							console.log("아작스 성공");
							$(".topOfBox .topBar").empty();
							$(".Pmain table").empty();						
							listDM(res.list,1);
							$("#contentsForm").val("");
							$("#accurDateForm").val("");
							
					},
					error : function (request, status, error) {
						console.log(error);
					}
					});
				}); 
			
}


//---------------------------------------------------------------메모 작성 팝업 띄우기
function addMemoPop() {
	console.log("${sName}");
	console.log("${sAdminNo}");
	var html="";
			
			
			html +="<div class =\"memoBackground\"></div>";
			html +="			<div class=\"popMemo\">";
			html +="			<div class=\"blank\"></div>";
			html +="			<div class=\"title\">메모등록</div>";
			html +="			<div class=\"blank\"></div>";
			html +="			<div class=\"ctt_box\">";
			html +="				<div class=\"what\">내용</div>";
			html +="				<div class=\"ctt\">";
			html +="					<textarea class=\"text\"></textarea>";
			html +="				</div>";
			html +="				<div class=\"blank\"></div>";
			html +="				<div class=\"date_box\">";
			html +="				<div class=\"what1\" >작성자</div>";
			html +="				<input type=\"text\" id=\"memoWriter\" value=\""+ "${sName}"  +"\" placeholder=\""+ "${sName}" + "\">";
			html +="				</div>";
			html +="				<div class=\"date_box\">";
			html +="					<div class=\"what1\">발생일</div>";
			html +="					<input type=\"date\" class=\"date1\">";
			html +="				</div>";
			html +="				<div class=\"date_box\">";
			html +="					<div class=\"what1\">중요 </div>";
			html +="					<input type=\"checkbox\" id=\"check_test_box\" />";
			html +="					<label for=\"check_test_box\"> <span></span> 체크박스입니다</label>  ";
			html +="				</div>";
			html +="				<div class=\"last_box\">";
			html +="					<div class=\"last_box_blank\"></div>";
			html +="					<input type=\"button\" value=\"취소\" class=\"btn\" id=\"cancelBtn\">";
			html +="					<input type=\"button\" value=\"등록\" class=\"btn\" id=\"addBtn\">";
			html +="				</div>";
			html +="			</div>";
			html +="		</div>";
		
			
		$("#memoWrap").html(html);
		
		
		$("#userNoMemo").val($("#userNo").val());
		var adminNo = "${sAdminNo}"
		$("#memoWriterForm").val(adminNo);
		
		
		$(".popMemo #cancelBtn").on("click", function () {
			$("#memoWrap").empty();
		});
		
		
		$(".popMemo #addBtn").on("click", function () {
			if($(".popMemo input[type=checkbox]").is(":checked") == true){
				$("#importantForm").val("1");
			}else{
				$("#importantForm").val("0");
			}
			
			$("#accurDateForm").val($(".date1").val());
			$("#accurTimeForm").val($(".time").val());
			$("#contentsForm").val($(".text").val());
			
			if($(".text").val().trim() ==""){
				alert("내용을 입력해주세요");
			}else if($(".date1").val().trim() ==""){
				alert("발생일을 입력해주세요.");
			}else{
				var params = $("#memoForm").serialize();
				
				$.ajax({
					url : "add_memo",
					type : "post",
					dataType : "json",
					data : params,
					success: function (res) {
						if(res.msg == "success"){
							$(".topOfBox .topBar").empty();
							$(".Pmain table").empty();		
							listDM(res.list,1);
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
			}
		});
}


 
 function listDP(list) {
	var html="";
				html += "				<colgroup>                  ";
				/* html += "					<col width=\"5%\"/>     "; */
				html += "					<col width=\"5%\"/>     ";
				html += "					<col width=\"10%\"/>     ";
				html += "					<col width=\"10%\"/>     ";
				html += "					<col width=\"10%\"/>     ";
				html += "					<col width=\"15%\"/>     ";
				html += "					<col width=\"5%\"/>     ";
				html += "					<col width=\"45%\"/>     ";
				html += "				</colgroup>                 ";
				html +=	"	  <thead>";
				html +=	"		  <tr>";
				/* html +=	"		  	  <th>";
				html +=	"			  <input class = \"check\" type=\"checkbox\" id=\"ex_chk\">";
				html +=	"			  </th>"; */
				html +=	"			  <th> no</th>";
				html +=	"			  <th> 제목</th>";
				html +=	"			  <th> 좋아요</th>";
				html +=	"			  <th> 댓글</th>";
				html +=	"			  <th> 태그</th>";
				html +=	"			  <th> 신고</th>";
				html +=	"			  <th> 설명</th>";
				html +=	"		  </tr>";
				html +=	"	  </thead>";
				html +=	"	  <tbody>";
				
		for(var d of list){
				html+= "	<tr name=\"" + d.POST_NO +"\">";
				/* html+= "		<td>";
				html+= "		<input class = \"check\" type=\"checkbox\" id=\"ex_chk\">"; 
				html+= "		</td>"; */
				html+= "		<td> " + d.POST_NO +"</td>";
				html+= "		<td>  "+ d.TITLE +"</td>";
				html+= "		<td>  "+ d.LIKE_CNT +"</td>";
				html+= "		<td>  "+ d.COMMENT_CNT +"</td>";
				html+= "		<td>  "+ d.TAG_NAMES +"</td>";
				html+= "		<td>  "+ d.REPORT_CNT +"</td>";
				html+= "		<td>  "+ d.EXPLAIN +"</td>";
				html+= "	</tr>";
		}                     
				html +=	"	</tbody>";
	$(".Pmain table").html(html);
	
	
	$(".Pmain table").on("dblclick","tr", function () {
		console.log("도니?");
		$("#postNo").val($(this).attr("name"));
		$("#pNo").val($(this).attr("name"));
		$("#userNoForPost").val($("#userNo").val());
		$("#postForm").submit();
	});
	
	
}
 
 function outList(list) {
	var html="";
	
	console.log(list);
	
	for(var e of list){
		html+= "	<tr name=\"" + e.USER_NO  + "\">";
		html+= "		<td><input type=\"checkbox\" name =\"userNo\" value =\"" + e.USER_NO  + "\"> </td>";
		html+= "		<td>" + e.RNUM  + "</td>";
		html+= "		<td>" + e.USER_NO  + "</td>";
		html+= "		<td>" + e.NAME  + "</td>";
		html+= "		<td>" + e.USER_ID  + "</td>";
		html+= "		<td>" + e.USER_NICKNAME  + "</td>";
		html+= "		<td>" + e.SEX + "</td>";
		html+= "		<td>" + e.BIRTHDAY + "</td>";
		html+= "		<td>" + e.PHONE_NO + "</td>";
		html+= "		<td>" + e.MAIL + "</td>";
		html+= "		<td>" + e.OUT_DATE + "</td>";
		html+= "		<td><input type=\"button\" value=\"수정\" class=\"update_btn\" id=\"update_btn\"/>";
		html+= "			<input type=\"button\" value=\"복구\" class=\"delete_btn\" id=\"delete_btn\"/>";
		html+= "		</td>";
		html+= "	</tr>";
	}
	
	$(".main3-table tbody").html(html);
	
}
 
 
 
 function pagingDraw(pb,what) {
	 
		var html ="";
		
		console.log(pb);
		console.log(what);
			html += "<span name=\"1\">처음</span>";
			/* <!-- 이전 페이지  --> */
			if($("#page") == "1"){
					html +=		"<span name=\"1\">이전</span>";
			}else{
					html +=	    "<span name=\"" + ($("#page").val()*1 -1) + "\">이전 </span>";
			}
			/* <!-- 페이징   --> */
			for( var i = pb.startPcount ; i <= pb.endPcount; i++){
				if($("#page").val() ==i){
					html +=	"<span name=" + i + " ><b>" + i +  "</b></span>";
				}else{
					html +=	"<span name=" + i + " >" + i +  "</span>";
				}
			}
			/* 다음이랑 마지막 페이지  */
			if($("#page").val() == pb.maxPcount){
					html +=	"<span name=" + pb.maxPcount + ">다음</span>";
			}else{
					html += "<span name=" + ($("#page").val()*1 + 1) + ">다음</span>";
			}
			
		    html +=	"<span name="+ pb.maxPcount+">마지막</span>";
		
		 $("#" + what).html(html);
}
 
//------------------------------------------------------------------------------------------이메일 리스트 로드하기
function loadEmailList() {
	var params = $("#detailForm").serialize();
	
	$.ajax({
		url : "mailList",
		type : "post",
		dataType : "json",
		data : params,
		success: function (res) {
				drawEamilList(res.list)	;			
		},
		error : function (request, status, error) {
			console.log(error);
		}
	});
		
}

function drawEamilList(list) {
	
	var html="";
	
	console.log(list);
	
	if(list == null){
		
		html = "<tr><td style=\"width: 200px;display: inline-block; border: none; margin-left: 120px;\">선택된 회원이 업습니다.</td></tr>";
	
	}else{
		
		for(var d of list){
				html+="		<tr class=\"mail\" name=\"" + d.MAIL + "\">";
				html+="			<td> " + d.USER_NO + "</td>";
				html+="			<td> " + d.NAME + "</td>";
				html+="			<td> " + d.MAIL + "</td>";
				html+="			<td> " + d.PHONE_NO + "</td>";
				html+="		</tr>";
			}
		
	}
	
	$(".PmainM tbody").html(html);
	
}

</script>
</head>
<body>
<form action="detail" id="postForm" method="post">
	<input type="hidden" id="pNo" name="pNo">
	<input type="hidden" id="postNo" name="postNo">
	<input type="hidden" id="userNoForPost" name="userNo">
</form>

<form action="user_board" id="detailForm" method="post">
	<input type="hidden" id="userNo" name="userNo">
	<input type="hidden" id="searchGbnDP" name="searchGbnDP">
	<input type="hidden" id="searchTxtDP" name="searchTxtDP">
</form>

<div class="header">

</div>
<div class="content">
	<c:import url="managerSide.jsp"></c:import>
<div class ="main">
		
<form action="user_board" id="userForm" method="post" >
		<input type="hidden" id="page" name="page" value= ${ page}>
		<div class ="blank2"></div>
		
		<div class ="bigClass">
			<div class ="bigClass-1" id="allUserList">전체회원</div>
			<div class ="bigClass-2" id="outUserList">탈퇴회원</div>
		</div>
		<div class="main1">
			<div class="main1-1">
				<span><span class="font-red">검색어를 입력</span>하여 검색할 수 있습니다.</span><br/>
				<span><span class="font-red">수정버튼</span>을 클릭하시면 수정할 수 있습니다.</span><br/>
				<span><span class="font-red">데이터가 많은 경우</span> 느려질 수 있습니다.</span>
			</div>
		</div>
		<div class ="main2">
			<div class="main2-1">
				<label>회원분류</label>
				<select name="searchType" id="searchType">
					<option value="0"> 전체회원</option>
					<option value="1"> 올해회원</option>
					<option value="2"> 작년회원</option>
				</select>
				<label>검색분류</label>
				<select name="searchGbn" id="searchGbn">
					<option value="0">회원번호</option>
					<option value="1">이름</option>
					<option value="2">아이디</option>
					<option value="3">전화번호</option>
					<option value="4">성별</option>
					<option value="5">나이</option>
				</select>
					     <input type="text" id="searchTxt" name="searchTxt" placeholder="검색어를 입력해주세요." value="${param.searchTxt }">
				<div class="date_search">
					<label>날짜분류</label>
						<input type="date" name="startDate" id="startDate" value="${param.startDate }">
						<span> ~ </span>
						<input type="date" name="endDate" id="endDate" value="${param.endDate }">
				</div>
				<input type="button" id="searchBtn" value="검색">
				<input type="button" id="resetBtn" value="초기화">
			</div>
</form>		
		</div>
		<div class="main3">
			<input type="button" value="선택 삭제/복구" id="selectDelBtn"/>
			<input type="button" value="이메일" id="emailBtn"/>
		</div>
		<div class="main3-table">
			<table>
				<colgroup>
						<col width="2%"/>
						<col width="5%"/>
						<col width="5%"/>
						<col width="5%"/>
						<col width="8%"/>
						<col width="8%"/>
						<col width="5%"/>
						<col width="8%"/>
						<col width="13%"/>
						<col width="13%"/>
						<col width="10%"/>
						<col width="10%"/>
					</colgroup>
			<thead>
				<tr>
					<th>
					<input type="checkbox" id="all_check"> 
					</th>
					<th>번호</th>
					<th>회원번호</th>
					<th>이름</th>
					<th>아이디</th>
					<th>닉네임(아이디)</th>
					<th>성별</th>
					<th>생년월일(나이)</th>
					<th>전화번호</th><!--신고자 닉네임(아이디)  -->
					<th>이메일</th>
					<th>가입일/탈퇴일</th>
					<th>수정/삭제</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="data" items="${list}">
					<tr name="${data.USER_NO}">
						<td><input type="checkbox" name ="userNo" value ="${data.USER_NO}"> </td>
						<td>${data.RNUM}</td>
						<td>${data.USER_NO}</td>
						<td>${data.NAME}</td>
						<td>${data.USER_ID}</td>
						<td>${data.USER_NICKNAME}</td>
						<c:choose>
							<c:when test="${data.SEX eq 0}">
							<td>남</td>
							</c:when>
							<c:when test="${data.SEX eq 1}">
							<td>여</td>
							</c:when>
						</c:choose>
	
						<td>${data.BIRTHDAY}(만${data.OLD}세)</td>
						<td>${data.PHONE_NO}</td>
						<td>${data.MAIL}</td>
						<td>${data.JOIN_DATE}</td>
						<td><input type="button" value="수정" class="update_btn"/>
							<input type="button" value="삭제" class="delete_btn"/>
						</td>
					</tr>
				</c:forEach>
				
			</tbody>
			</table>
		</div>
		<div class ="status"> 전체 : ${cnt}명</div>
<div id="pagingWrap" class="pagingWrap">
<span name="1">처음</span>
<!-- 이전 페이지  -->
<c:choose>
	<c:when test="${page eq 1}">
		<span name="1">이전</span>
	</c:when>
	<c:otherwise>
		<span  name="${page-1 }">이전 </span>
	</c:otherwise>
</c:choose>

<!-- 페이징   -->
<c:forEach var="i" begin="${pb.startPcount}" end="${pb.endPcount}" step="1">
	<c:choose>
		<c:when test="${i eq page}">
			<span name="${i}"><b>${i}</b></span>
		</c:when>
		<c:otherwise>
			<span name="${i}">${i}</span>
		</c:otherwise>
	</c:choose>
</c:forEach>

<!--다음페이지  -->
<c:choose>
	<c:when test="${page eq pb.maxPcount}">
		<span name="${pb.maxPcount}">다음</span>
	</c:when>
	<c:otherwise>
		<span name="${page+1}">다음</span>
	</c:otherwise>
</c:choose>
<span name="${pb.maxPcount}">마지막</span>
</div>
<div id="pagingWrapOut" class="pagingWrap"></div>
	</div>
</div>
<div class="popupWrap">
</div>
<div id="eamilWrapUserBoard">
	<c:import url="email(send).jsp"></c:import>
</div>
<div id="memoWrap"></div>
</body>
</html>