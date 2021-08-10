<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/h/report_manage.css"/>

<style type="text/css">
.highcharts-figure, .highcharts-data-table table {
    min-width: 320px; 
    max-width: 800px;
    width: 800px;
    margin: 1em auto;
    margin-left: 150px;
    display: inline-block;
}

.highcharts-data-table table {
	font-family: Verdana, sans-serif;
	border-collapse: collapse;
	border: 1px solid #EBEBEB;
	margin: 10px auto;
	text-align: center;
	width: 100%;
	max-width: 500px;
}
.highcharts-data-table caption {
    padding: 1em 0;
    font-size: 1.2em;
    color: #555;
}
.highcharts-data-table th {
	font-weight: 600;
    padding: 0.5em;
}
.highcharts-data-table td, .highcharts-data-table th, .highcharts-data-table caption {
    padding: 0.5em;
}
.highcharts-data-table thead tr, .highcharts-data-table tr:nth-child(even) {
    background: #f8f8f8;
}
.highcharts-data-table tr:hover {
    background: #f1f7ff;
}

input[type="number"] {
	min-width: 50px;
}

body {
	overflow-x: hidden;
}

#gallary {
	height: 60px;
    width: 120px;
    background-color: #0C4A60;
    line-height: 60px;
}
</style>
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>
<script type="text/javascript">
$(document).ready(function() {	
	getData();
	
	$(".chart").attr("id", "active");

	
	$("#period").on("change", function(){
		getData();
	});
	
	$("#period").on("click", function(){
		$("#startDate").val("yyyy-MM-dd");
		$("#endDate").val("yyyy-MM-dd");
	});
	
	$("#startDate, #endDate").on("click", function(){
		$("#period").val("0");
	});
	
	$("#searchBtn").on("click", function(){
		getData();
	});
	
	
})


function getData() {
	
	var params =  $("#actionForm").serialize();
	$.ajax({
		type : "post",
		url : "getChartData",
		dataType : "json",
		data : params,
		success : function(result) {
			/* var jsonEncode = JSON.stringify(result);



			var jsonDecode = JSON.parse(jsonEncode);

			console.log(jsonDecode); */
			
			makeChart(result.list);
			
			
		},
		error : function(request,status,error) {
			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
}

function makeChart(list) {
	Highcharts.chart('container', {
		colors: ['#ffb3b3', '#ffffb3', '#99ddff'],
	    chart: {
	        plotBackgroundColor: null,
	        plotBorderWidth: null,
	        plotShadow: false,
	        type: 'pie'
	    },
	    title: {
	        text: '작품 수 통계'
	    },
	    tooltip: {
	        pointFormat: '{series.name}: <b>{point.percentage:.1f}%, {point.y}건</b>'
	    },
	    accessibility: {
	        point: {
	            valueSuffix: '%'
	        }
	    },
	    plotOptions: {
	        pie: {
	            allowPointSelect: true,
	            cursor: 'pointer',
	            dataLabels: {
	                enabled: true,
	                format: '<b>{point.name}</b>: {point.percentage:.1f} %'
	            }
	        }
	    },
	    series: [{
	        name: '작품 수',
	        colorByPoint: true,
	        data: list
	    }]
	});
}

</script>		
</head>
<body>

<div class="main">
	<c:import url="../h/managerSidebar.jsp"></c:import>
	<div class ="ctts">
		<div class ="blank2"></div>
		
		<div class="menu_tab_wrap">
			<div id="gallary" class="tab">작품 수 통계</div>
		</div>
		<div class="menu_txt_wrap">

		</div>
		
		<form action="#" id="actionForm" method="post" >

		<div class ="search_flag_div">
			<div class="search_flag">
				<label>기간</label>
				<select name="period" id="period">
					<option value="0" selected="selected">전체기간</option>
					<option value="1">지난 일주일</option>
					<option value="2">지난 한 달</option>
					<option value="3">지난 일 년</option>
				</select>
				<div class="date_srh">
					<label>날짜분류</label>
						<input type="date" id="startDate" name="startDate">
						<span> ~ </span>
						<input type="date" id="endDate" name="endDate">
						<input type="button" value="검색" id="searchBtn"/>
				</div>
			</div>
		</div>
		<div class="cnt_wrap"></div>	
	</form>
	<figure class="highcharts-figure">
	    <div id="container"></div>
	    <p class="highcharts-description"></p>
	</figure>
	</div>
</div>
</body>
</html>