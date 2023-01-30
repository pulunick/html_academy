<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cpath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ex04 - 시도별 실시간 평균정보 조회</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="${cpath }/resources/js/function.js"></script>
</head>
<body>

<h1>ex04 - 시도별 실시간 평균정보 조회</h1>
<h3>한국환경공단_에어코리아_대기오염통계 현황 (공공데이터포털)</h3>
<hr>

<div id="root">
	<canvas id="myChart"></canvas>
</div>

<script>
	const url = '${cpath}/air'
	fetch(url)
	.then(resp => resp.json())
	.then(json => {
		const arr = json.response.body.items.map(e => {
			return {'서울': e.seoul, '부산': e.busan, '날짜': e.dataTime}
		})
		console.log(arr)
		arr.sort((a, b) => a.날짜 > b.날짜 ? 1 : -1 )
		
		const context = document.getElementById('myChart')
		const labels = arr.map(e => e.날짜)
		const data = {
			labels: labels,
			datasets: [
				{
					label: '서울',
					data: arr.map(e => e.서울),
					backgroundColor: 'skyblue',
				},
				{
					label: '부산',
					data: arr.map(e => e.부산),
					backgroundColor: 'hotpink',
				}
			]
		}
		const config = {
			type: 'bar',
			data: data,
		}
		const myChart = new Chart(context, config)
		
	})
</script>

</body>
</html>