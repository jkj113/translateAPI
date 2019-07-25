<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>번역기</title>
<link rel="stylesheet" href="/resources/style.css" >
<link rel="stylesheet" href="/resources/bootstrap-3.3.2/css/bootstrap.min.css">

</head>
<body>
	<div id="trans">
		<table id="rankTable">
			<tr>
				<td><h3>실시간 검색 결과 순위 :</h3></td>
				<td><div id="rank">&nbsp;&nbsp;</div></td>
			</tr>
		</table>
		<table id="transTable">
			<tr>
				<th>번역할 언어  </th>
				<td>
				<select id="transSource">
						<c:forEach items="${codes}" var="codes">
							<option value="${codes.codeNum}">${codes.codeLanguage}</option>
						</c:forEach>
				</select>
				</td>
				<th>번역될 언어</th>
				<td>
				<select id="transTarget">
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
		<button type="button" class="btn btn-outline-primary" onclick="trans()"><b>번역하기</b></button>

	</div>
<br><br><br>
<!-- 
 <table class="dataTable">
      <thead>
         <tr>
            <th style="width: 70px;"scope="col">Target</th>
            <th style="width: 70px;"scope="col">Source</th>
            <th style="width: 70px;"" scope="col">번역전</th>
            <th style="width: 70px;" "scope="col">번역후</th>
         </tr>
      </thead>
      <tbody>
         <c:forEach var="tl" items="${transList}">
            <tr>
               <td>${tl.TRANS_SOURCE}</td>
               <td>${tl.TRANS_TARGET}</td>
               <td>${tl.TRANS_TEXT}</td>
               <td>${tl.TRANS_RESULT}</td>
            </tr>
         </c:forEach>
      </tbody>
   </table>
    -->
	<script>
		function trans() {
			var source = document.querySelector('#transSource').value;
			var target = document.querySelector('#transTarget').value;
			var text = document.querySelector('#transText').value;
			var param = 'transSource=' + source + '&transTarget=' + target
					+ '&transText=' + text;
			var xhr = new XMLHttpRequest();
			xhr.open('POST', '/trans');
			xhr.setRequestHeader('Content-Type',
					'application/x-www-form-urlencoded');
			xhr.onreadystatechange = function() {
				if (xhr.readyState == 4) {
					if (xhr.status == 200) {
						var res = xhr.response;
						console.log(res);
						document.querySelector('#transResult').value = res;
					}
				}
			}
			xhr.send(param);
		}
		window.onload = function() {
			var rank = new Array();
			var ranking = document.querySelector('#rank');
			var xhr = new XMLHttpRequest();
			xhr.open('GET', '/rank');
			xhr.onreadystatechange = function() {
				if (xhr.readyState == 4) {
					if (xhr.status == 200) {
						var res = JSON.parse(xhr.responseText);
						var str = '';
						for (var i = 0; i < 10; i++) {
							str = (i + 1) + "위 " + res[i].transResult;
							rank[i] = str;
						}
					}
				}
			}
			xhr.send();
			var i = 0;
			var interval = setInterval(function() {
				if (i > 9) {
					i = 0;
				}
				ranking.innerHTML = "<h3>" + rank[i] + "<h3>";
				i++;
			}, 2000);
		}
	</script>
</body>
</html>