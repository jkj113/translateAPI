<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="content">
<table>
<tr>
<td><h3>실시간 검색 결과 순위 : </h3></td>
<td><div id="rank" style="color:red"></div></td>
</tr>
</table> 
<table>
<tr>
<th>번역할 언어</th>
<td>
<select class="_twemoji_box" id="transSource" >
<c:forEach items="${codes}" var="codes">	
		<option value="${codes.codeNum}">${codes.codeLanguage}</option>	
</c:forEach>
</select>
</td>
<th>번역될 언어</th>
<td> 
<select class="_twemoji_box" id="transTarget">
<c:forEach items="${codes}" var="codes">	
		<option value="${codes.codeNum}">${codes.codeLanguage}</option>	
</c:forEach>
</select>
</td>
</tr>
<tr>
<th colspan="2"><textarea rows=10 cols=25 id="transText"></textarea></th>
<th colspan="2"><textarea rows=10 cols=25 id="transResult"></textarea></th>
</tr> 
</table>
<button onclick="trans()" style="width:400px">번역하기</button>
</div>

   <br>
   <table border="1">
      <tr>      
         <th>검색횟수</th>
         <th>번역전</th>
         <th>번역후
         <th>번역전내용</th>
         <th>번역후내용</th>
      </tr>

            <c:forEach var="cl" items="${countList}">
               <tr>
                  
                  <td>${cl.TH_COUNT}</td>
                  <td>${cl.TH_SOURCE}</td>
                  <td>${cl.TH_TARGET}</td>
                  <td>${cl.TH_TEXT}</td>
                  <td>${cl.TH_RESULT}</td>
            </c:forEach>
</table>
<script> 
function trans(){
	var source = document.querySelector('#transSource').value;
	var target = document.querySelector('#transTarget').value; 
	var text = document.querySelector('#transText').value;
	var param = 'transSource='+source+'&transTarget='+target+'&transText='+text;
	var xhr = new XMLHttpRequest();
	xhr.open('POST','/trans');
	xhr.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
	xhr.onreadystatechange = function(){
		if(xhr.readyState==4) {
			if(xhr.status==200){
				var res = xhr.response;
				console.log(res);
				document.querySelector('#transResult').value=res;
			}
		}
	}
	xhr.send(param);
}
window.onload = function(){
	var rank = new Array();
	var ranking = document.querySelector('#rank');
	var xhr = new XMLHttpRequest();
	xhr.open('GET','/rank');
	xhr.onreadystatechange = function(){
		if(xhr.readyState==4) {
			if(xhr.status==200){
				var res = JSON.parse(xhr.responseText);
				var str = '';
				for(var i=0;i<10;i++){
					str = (i+1)+"위 "+res[i].transResult;
					rank[i] = str;
				}
			}
		}
	}
	xhr.send();
	var i=0;
	var interval = setInterval(function(){
		if(i>9){
			i=0;
		}
		ranking.innerHTML = "<h3>"+rank[i]+"<h3>";
		i++;
	},2000);
}
</script>
</body>
</html>