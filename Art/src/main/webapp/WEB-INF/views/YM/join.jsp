<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">


h1 {
	text-align: center;
}
.wrap {
	text-align: center;
	width: 600px;	
	margin: 0 auto;
	padding: 0;
	border: 1px solid #e5e5e5;
}

#id {
	font-size: 10pt;
}

.a {
    width:100%;
    height:50px;
    border: 0;
    outline: none;
    font-size: 12pt;
    border-bottom: 2px solid #e5e5e5;
    margin-bottom: 5px;
}

.b {
   width: 80%;
   height:700px;
   text-align:left;
   margin-right:40px;
   margin-left : 35px;
   display: inline-block;
   margin-top: 30px;
}
input {

   height:30px;
   display: inline-block;
}
.b-1{
  position : relative;
  right:6px;
  bottom : 50px;
  margin-left:420px;
  height:40px;
  width: 70px;
  background-color: #ffad33;
  border:none;
  display: inline-block;
  color: #fff;
  font-size: 14px;
  cursor:pointer;
  
}

.b-2{
    width:100%;
    height:50px;
    border: 0;
    outline: none;
    font-size: 14pt;
    border-bottom: 2px solid #e5e5e5;
    margin-bottom: 20px;
   
}
.c { 
  position: relative;
  right:6px;
  bottom : 50px;
  margin-left: 420px;
  width: 70px;
  height: 37px;
  background-color: #ffad33;
  border:none;
  font-size:14px;
  color: #fff;
  cursor:pointer;
}

.d{
    width:100%;
    height:50px;
    border: 0;
    outline: none;
    font-size: 12pt;
    border-bottom: 2px solid #e5e5e5;
    margin-bottom: 5px;
}

.gender{
  width: 300px;
  text-align: left;
  margin-bottom: 20px;
  display: inline-block;
  width: 114px;
  height: 36px;
}
.phone_number{
    width:100%;
    height:50px;
    border: 0;
    outline: none;
    font-size: 12pt;
    border-bottom: 2px solid #e5e5e5;
    margin-bottom: 20px;

}

.birthday {
	width: 100%;
    height: 100px;
	border-bottom: 2px solid #e5e5e5;
}


.sect {
  text-align: center;
  margin-top: 10px;
  height: 40px;
  width: 150px;
  border: none;
}

.s{
 width: 260px;
 height: 30px;
 
}

.q{
	width:100%;
    height:50px;
    border: 0;
    outline: none;
    font-size: 12pt;
    border-bottom: 2px solid #e5e5e5;
    margin-bottom: 5px;
}

.x{
 width: 258px;
 height: 30px;
}


#a {
 width: 180px;

}

.bottom{
	 text-align: center;
	 margin-top: 5px;
}

#join{ 
	width: 150px;
	height: 60px;
	margin-left: 50px;
	background-color: #ffad33;
	border: none;
	font-size: 25px;
	color: #fff;
	border: 0;
	cursor:pointer;
}

#cancel{
	width: 150px;
	height: 60px;
	margin-left: 35px;
	font-size: 25px;
	color: #888;
	border: 0;
	cursor:pointer;
}
</style>

</head>
<body>
	<h1>회원가입</h1>
<div class="wrap">
	<div class="b">
			<span id="id">아이디</span>
	       <input type="text" class="a" placeholder="아이디 입력">
	       <input type="button" class="b-1" value="중복확인">	
	        <span id="id">닉네임</span>
	       <input type="text" class="b-2" placeholder="닉네임">
	<br>    
		   <span id="id">비밀번호</span>  
	       <input type="password" class="b-2" placeholder="비밀번호">
	<br>  
		   <span id="id">비밀번호 재확인</span>
	       <input type="password" class="b-2" placeholder="비밀번호 재확인">
	<br>    
		   <span id="id">이름</span> 
	       <input type="text" class="b-2" placeholder="이름">
	<br>  
		<span id="id">성별</span>
	<br>	 
		 <input type="radio" name="gender" value="남" checked ="checked">남 
         <input type="radio" name="gender" value="여">여 
    <br>  			
		<div class="birthday">
	<br>	
		<span id="id">생년월일</span>
	<br>  		
			<select class="sect">
				<option>-- 선택 --</option>
		      	<option>1940</option>
		      	<option>1941</option>
		      	<option>1942</option>
		      	<option>1943</option>
		      	<option>1944</option>
		      	<option>1945</option>
		      	<option>1946</option>
		      	<option>1947</option>
		      	<option>1948</option>
		      	<option>1949</option>
		      	<option>1950</option>
		      	<option>1951</option>
		      	<option>1952</option>
		      	<option>1953</option>
		      	<option>1954</option>
		      	<option>1955</option>
		      	<option>1956</option>
		      	<option>1957</option>
		      	<option>1958</option>
		      	<option>1959</option>
		      	<option>1960</option>
		      	<option>1961</option>
		      	<option>1962</option>
		      	<option>1963</option>
		      	<option>1964</option>
		      	<option>1965</option>
		      	<option>1966</option>
		      	<option>1967</option>
		      	<option>1968</option>
		      	<option>1969</option>
		      	<option>1970</option>
		      	<option>1971</option>
		      	<option>1972</option>
		      	<option>1973</option>
		      	<option>1974</option>
		      	<option>1975</option>
		      	<option>1976</option>
		      	<option>1977</option>
		      	<option>1978</option>
		      	<option>1979</option>
		      	<option>1980</option>
		      	<option>1981</option>
		      	<option>1982</option>
		      	<option>1983</option>
		      	<option>1984</option>
		      	<option>1985</option>
		      	<option>1986</option>
		      	<option>1987</option>
		      	<option>1988</option>
		      	<option>1989</option>
		      	<option>1990</option>
		      	<option>1991</option>
		      	<option>1992</option>
		      	<option>1993</option>
		      	<option>1994</option>
		      	<option>1995</option>
		      	<option>1996</option>
		      	<option>1997</option>
		      	<option>1998</option>
		      	<option>1999</option>
		      	<option>2000</option>
		      	<option>2001</option>
		      	<option>2002</option>
		      	<option>2003</option>
		      	<option>2004</option>
		      	<option>2005</option>
		      	<option>2006</option>
		      	<option>2007</option>
		      	<option>2008</option>
		      	<option>2009</option>
		      	<option>2010</option>
		      	<option>2011</option>
		      	<option>2012</option>
		      	<option>2013</option>
		      	<option>2014</option>
		      	<option>2015</option>
		      	<option>2016</option>
		      	<option>2017</option>
		      	<option>2018</option>
		      	<option>2019</option>
		      	<option>2020</option>
		      	<option>2021</option>
			</select>
			<select class="sect">
				<option>-- 선택 --</option>
		      	<option>1</option>
		      	<option>2</option>
		      	<option>3</option>
		      	<option>4</option>
		      	<option>5</option>
		      	<option>6</option>
		      	<option>7</option>
		      	<option>8</option>
		      	<option>9</option>
		      	<option>10</option>
		      	<option>11</option>
		      	<option>12</option>
 			</select>
 			<select class="sect">
				<option>-- 선택 --</option>
		      	<option>1</option>
		      	<option>2</option>
		      	<option>3</option>
		      	<option>4</option>
		      	<option>5</option>
		      	<option>6</option>
		      	<option>7</option>
		      	<option>8</option>
		      	<option>9</option>
		      	<option>10</option>
		      	<option>11</option>
		      	<option>12</option>
		      	<option>13</option>
		      	<option>14</option>
		      	<option>15</option>
		      	<option>16</option>
		      	<option>17</option>
		      	<option>18</option>
		      	<option>19</option>
		      	<option>20</option>
		      	<option>21</option>
		      	<option>22</option>
		      	<option>23</option>
		      	<option>24</option>
		      	<option>25</option>
		      	<option>26</option>
		      	<option>27</option>
		      	<option>28</option>
		      	<option>29</option>
		      	<option>30</option>
		      	<option>31</option>
 			</select>
		</div>
	<br>			
		<div class="phone">
		 <span id="id">휴대전화</span>
	<br>		
		<input type="text" class= "phone_number" placeholder="010-****">
	</div>
    <div class="email">
		<span id="id">이메일</span>
		<input type="text" class="d" placeholder="email@gamil.com">			
		<input type="button" class="b-1" value="인증번호 ">
	</div>
		<span id="id">인증번호</span>
		<input type="text" class="q" placeholder="인증번호를 입력하세요">
		<input type="button" class="c" value="확인">
</div>
   <br>
   <br>
</div>
	<div class="bottom">
       <input type="button" id="cancel" value="취소">
       <input type="button" id="join"  value="가입">
	</div>
</body>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<style type="text/css">
h1 {
	text-align: center;
}
.wrap {
	text-align: center;
	width: 600px;	
	height: 100%;
	margin: 0 auto;
	padding: 0;
	border: 1px solid #e5e5e5;
}

#id {
	font-size: 10pt;
}

.a {
    width:100%;
    height:50px;
    border: 0;
    outline: none;
    font-size: 12pt;
    border-bottom: 2px solid #e5e5e5;
    margin-bottom: 5px;
}

.b {
   width: 80%;
   height:700px;
   text-align:left;
   margin-right:40px;
   margin-left : 35px;
   display: inline-block;
   margin-top: 30px;
}
input {

   height:30px;
   display: inline-block;
}
.b-1{
  position : relative;
  right:6px;
  bottom : 50px;
  margin-left:420px;
  height:40px;
  width: 70px;
  background-color: #ffad33;
  border:none;
  display: inline-block;
  color: #fff;
  font-size: 14px;
  border-radius: 15px;
}

.b-2{
    width:100%;
    height:50px;
    border: 0;
    outline: none;
    font-size: 14pt;
    border-bottom: 2px solid #e5e5e5;
    margin-bottom: 20px;
   
}

.c { 
  position: relative;
  right:6px;
  bottom : 50px;
  margin-left: 420px;
  width: 70px;
  height: 37px;
  background-color: #ffad33;
  border:none;
  font-size:14px;
  color: #fff;
  border-radius: 15px;
}

.d{
    width:100%;
    height:50px;
    border: 0;
    outline: none;
    font-size: 12pt;
    border-bottom: 2px solid #e5e5e5;
    margin-bottom: 5px;
}

.gender{
  width: 300px;
  text-align: left;
  margin-bottom: 20px;
  display: inline-block;
  width: 114px;
  height: 36px;
}
.phone_number{
    width:100%;
    height:50px;
    border: 0;
    outline: none;
    font-size: 12pt;
    border-bottom: 2px solid #e5e5e5;
    margin-bottom: 20px;

}

.birthday {
	width: 100%;
    height: 100px;
	border-bottom: 2px solid #e5e5e5;
}


.sect {
  text-align: center;
  margin-top: 10px;
  height: 40px;
  width: 150px;
  border: none;
}

.s{
 width: 260px;
 height: 30px;
 
}

.q{
	width:100%;
    height:50px;
    border: 0;
    outline: none;
    font-size: 12pt;
    border-bottom: 2px solid #e5e5e5;
    margin-bottom: 5px;
}

.x{
 width: 258px;
 height: 30px;
}


#a {
 width: 180px;

}

.bottom{
	 text-align: center;
	 margin-top: 20px;
	 height: 100px;
}

#join{ 
	width: 150px;
	height: 60px;
	margin-left: 50px;
	background-color: #ffad33;
	border: none;
	font-size: 25px;
	color: #fff;
	border: 0;
	border-radius: 20px;
}

#cancel{
	width: 150px;
	height: 60px;
	margin-left: 35px;
	font-size: 25px;
	color: #888;
	border: 0;
	border-radius: 20px;
}

#check2 {
	font-size: 11pt;
}
</style>
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$("#updateBtn").on("click", function() {
		
	});
});

function check_pw(){
	 
    var pw = document.getElementById('pw').value;
    /* var SC = ["!","@","#","$","%"];
    var check_SC = 0; */

    
    if(document.getElementById('pw').value !='' && document.getElementById('pwCheck').value!=''){
        if(document.getElementById('pw').value==document.getElementById('pwCheck').value){
            document.getElementById('check2').innerHTML='비밀번호가 일치합니다.'
            document.getElementById('check2').style.color='green';
        }
        else{
            document.getElementById('check2').innerHTML='비밀번호가 일치하지 않습니다.';
            document.getElementById('check2').style.color='red';
        }
    }
    
    
}
</script>
</head>
<body>
	<h1>Art 회원가입</h1>
<div class="wrap">
	<div class="b">
			<span id="id">아이디</span>
	       <input type="text" class="a" placeholder="아이디 입력">
	       <input type="button" class="b-1" value="중복확인">	
	        <span id="id">닉네임</span>
	       <input type="text" class="b-2" placeholder="닉네임">
	<br>    
		   <span id="id">비밀번호</span>  
	       <input type="password" class="b-2" id="pw" onchange="check_pw()" placeholder="비밀번호"><br/><span id="check1"></span>
	<br>  
		   <span id="id">비밀번호 재확인</span>
	       <input type="password" class="b-2" id="pwCheck" onchange="check_pw()" placeholder="비밀번호 재확인"><span id="check2"></span>
	<br>
		   <span id="id">이름</span> 
	       <input type="text" class="b-2" placeholder="이름">
	<br>  
		<span id="id">성별</span>
	<br>	 
		 <input type="radio" name="gender" value="남" checked ="checked">남 
         <input type="radio" name="gender" value="여">여 
    <br>  			
		<div class="birthday">
	<br>	
		<span id="id">생년월일</span>
	<br>  		
			<select class="sect">
				<option>-- 선택 --</option>
		      	<option>1940</option>
		      	<option>1941</option>
		      	<option>1942</option>
		      	<option>1943</option>
		      	<option>1944</option>
		      	<option>1945</option>
		      	<option>1946</option>
		      	<option>1947</option>
		      	<option>1948</option>
		      	<option>1949</option>
		      	<option>1950</option>
		      	<option>1951</option>
		      	<option>1952</option>
		      	<option>1953</option>
		      	<option>1954</option>
		      	<option>1955</option>
		      	<option>1956</option>
		      	<option>1957</option>
		      	<option>1958</option>
		      	<option>1959</option>
		      	<option>1960</option>
		      	<option>1961</option>
		      	<option>1962</option>
		      	<option>1963</option>
		      	<option>1964</option>
		      	<option>1965</option>
		      	<option>1966</option>
		      	<option>1967</option>
		      	<option>1968</option>
		      	<option>1969</option>
		      	<option>1970</option>
		      	<option>1971</option>
		      	<option>1972</option>
		      	<option>1973</option>
		      	<option>1974</option>
		      	<option>1975</option>
		      	<option>1976</option>
		      	<option>1977</option>
		      	<option>1978</option>
		      	<option>1979</option>
		      	<option>1980</option>
		      	<option>1981</option>
		      	<option>1982</option>
		      	<option>1983</option>
		      	<option>1984</option>
		      	<option>1985</option>
		      	<option>1986</option>
		      	<option>1987</option>
		      	<option>1988</option>
		      	<option>1989</option>
		      	<option>1990</option>
		      	<option>1991</option>
		      	<option>1992</option>
		      	<option>1993</option>
		      	<option>1994</option>
		      	<option>1995</option>
		      	<option>1996</option>
		      	<option>1997</option>
		      	<option>1998</option>
		      	<option>1999</option>
		      	<option>2000</option>
		      	<option>2001</option>
		      	<option>2002</option>
		      	<option>2003</option>
		      	<option>2004</option>
		      	<option>2005</option>
		      	<option>2006</option>
		      	<option>2007</option>
		      	<option>2008</option>
		      	<option>2009</option>
		      	<option>2010</option>
		      	<option>2011</option>
		      	<option>2012</option>
		      	<option>2013</option>
		      	<option>2014</option>
		      	<option>2015</option>
		      	<option>2016</option>
		      	<option>2017</option>
		      	<option>2018</option>
		      	<option>2019</option>
		      	<option>2020</option>
		      	<option>2021</option>
			</select>
			<select class="sect">
				<option>-- 선택 --</option>
		      	<option>1</option>
		      	<option>2</option>
		      	<option>3</option>
		      	<option>4</option>
		      	<option>5</option>
		      	<option>6</option>
		      	<option>7</option>
		      	<option>8</option>
		      	<option>9</option>
		      	<option>10</option>
		      	<option>11</option>
		      	<option>12</option>
 			</select>
 			<select class="sect">
				<option>-- 선택 --</option>
		      	<option>1</option>
		      	<option>2</option>
		      	<option>3</option>
		      	<option>4</option>
		      	<option>5</option>
		      	<option>6</option>
		      	<option>7</option>
		      	<option>8</option>
		      	<option>9</option>
		      	<option>10</option>
		      	<option>11</option>
		      	<option>12</option>
		      	<option>13</option>
		      	<option>14</option>
		      	<option>15</option>
		      	<option>16</option>
		      	<option>17</option>
		      	<option>18</option>
		      	<option>19</option>
		      	<option>20</option>
		      	<option>21</option>
		      	<option>22</option>
		      	<option>23</option>
		      	<option>24</option>
		      	<option>25</option>
		      	<option>26</option>
		      	<option>27</option>
		      	<option>28</option>
		      	<option>29</option>
		      	<option>30</option>
		      	<option>31</option>
 			</select>
		</div>
	<br>			
		<div class="phone">
		 <span id="id">휴대전화</span>
	<br>		
		<input type="text" class= "phone_number" placeholder="010-****-****">
	</div>
    <div class="email">
		<span id="id">이메일</span>
		<input type="text" class="d" placeholder="email@gmail.com">			
		<input type="button" class="b-1" value="인증번호 ">
	</div>
		<span id="id">인증번호</span>
		<input type="text" class="q" placeholder="인증번호를 입력하세요" disabled="disabled">
		<input type="button" class="c" value="확인">
</div>
   <br>
   <br>
</div>
	<div class="bottom">
       <input type="button" id="cancel" value="취소">
       <input type="button" id="join"  value="가입">
	</div>
	<input type="text" id="check" name="check" value="${param.check}" /><br/>
</body>
</html>