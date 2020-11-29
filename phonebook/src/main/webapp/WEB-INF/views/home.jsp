<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cpath">${pageContext.request.contextPath }</c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${cpath }/css/style.css">
</head>
<body>
<header>
<div style="display: inline-block; width: 700px; margin: 0">
	<h1>ITBANK PhoneBook</h1>
</div>



<div style="width: 600px; margin-top: 10px; display: inline-block; float: right;">
	<div class="menu" onclick="insert()"><p><a href="#">신규등록<br>(POST, insert)</a></p></div>
	<div class="menu" onclick="select()"><p><a href="#">검색하기<br>(GET, select)</a></p></div>
	<div class="menu" onclick="update()"><p><a href="#">수정하기<br>(PUT, update)</a></p></div>
	<div class="menu" onclick="del()"><p><a href="#">삭제하기<br>(DELETE, delete)</a></p></div>	
</div>
</header>
<hr>
<section id="section">
	
</section>

<div class="down" id="phonebook">
	<table border="1" cellpadding= "7" cellspacing="0" align="center" id="phonediv">
	<tr name="origintr">
		<th>No</th><th>이름</th><th>전화번호</th><th>성별</th>
	</tr>

	</table>
</div>

<script type="text/javascript">
	
	let origintr = document.querySelector('#phonediv tr[name="origintr"]');
	var AllList = null;
	
	window.onload = function() {
		AllList = ${list };
		trcreate();
		console.log('시작 리스트 : ', AllList);
	}

	function trcreate() {
		let phonediv = document.getElementById('phonediv');
		phonediv.innerHTML = '';
	
 		console.log('보여주기 : ', AllList);
 		console.log('길이 : ', AllList.length);
 		phonediv.appendChild(origintr.cloneNode(true));
 		console.log('phondiv : ', phonediv);
		for(i = 0; i < AllList.length; i++) {
			let tr = document.createElement('tr');
			let tdcount = document.createElement('td');
			tdcount.innerHTML = i + 1;
			tr.appendChild(tdcount);
			let tdname = document.createElement('td');
			tdname.innerHTML = AllList[i].name;
			tr.appendChild(tdname);
			let tdpnum = document.createElement('td');
			tdpnum.innerHTML = AllList[i].pnumber;
			tr.appendChild(tdpnum);
			let tdfav = document.createElement('td');
			if(AllList[i].favorite == 0)
				tdfav.innerHTML = '남자';
			else
				tdfav.innerHTML = '여자';			
			
			tr.appendChild(tdfav);
			phonediv.appendChild(tr);
		}
		
	}
	
	function insert() {
		section = document.getElementById('section');
		
		html = '<h3>신규등록</h3>';
		html += '<div class="insertdiv">';
		html += '<div class="insertformdiv" align="center">';
		html += '<form method="POST" id="joinForm">';
		html += '<input type="text" placeholder="이름을 입력하세요" name="name" id="name">';
		html += '<input type="text" placeholder="전화번호를 입력하세요" name="pnum" id="pnum">';
		html += '<input type="radio" name="gender" value="0">남자';
		html += '<input type="radio" name="gender" value="1">여자';
		html += '<input type="button" onclick="join()" value="신규등록">';
		html += '</form>';
		html += '</div>';
		html += '</div>';
		
		section.innerHTML = html;
	}
	
	function changeList(obj) {
		AllList = JSON.parse(obj);
		trcreate();
	}
	
	function join() {
			form = document.getElementById("joinForm");
			gender = document.getElementsByName("gender");
			gendervalue = null;
			for(i = 0; i < gender.length; i++) {
				if (gender[i].checked == true) {
					gendervalue = gender[i].value;
				}
				console.log(i + "번 체크확인 : " + gender[i].checked);
				console.log(i + "번 값 확인: " + gender[i].value);
			}
			ob = {
					name : form.children[0].value,
					pnumber : form.children[1].value,
					favorite : gendervalue,
			}
			
			data = JSON.stringify(ob);
			console.log("JSON.stringify(form) 자료형 : " + typeof data);
			
			const request = new XMLHttpRequest(); // xhr
			request.open("POST", "${cpath}/Ajax/", true); // 비동기식으로 실행할지 말지 -> true
			request.setRequestHeader('Content-type','application/json; charset=UTF-8');

			request.send(data);
			
			request.onreadystatechange = function() {
				if (request.readyState == 4 && request.status == 200) {
					response = request.response;	
					console.log('response란???' + response);
					changeList(response);
				}
			}
	}
	

	
	function select() {
		section = document.getElementById('section');
		
		html = '<h3>검색하기</h3>';
		html += '<div class="sharediv" align="center">';
		html += '<input type="text" placeholder="이름을 입력하세요" name="name" id="name">';
		html += '<input type="button" onclick="search()" value="검색">';
		html += '</div>';
		html += '</div>';
		
		section.innerHTML = html;
	}
	
	function search() {
		div = document.getElementById("phonebook");
		pvtable = document.getElementsByTagName("table");
		if (pvtable !== null) {	div.removeChild(pvtable[0]); console.log('삭제삭제삭제삭제'); }
		name = document.getElementById("name").value;
				
		const request = new XMLHttpRequest(); // xhr
		request.open("GET", "${cpath}/Ajax/" + name + "/", true); // 비동기식으로 실행할지 말지 -> true
		request.setRequestHeader('Content-type','text; charset=UTF-8');

		request.onreadystatechange = function() {
		if (request.readyState == 4 && request.status == 200) {
				
			response = request.response;		
			console.log("response란?? " + response);
			if (response !== '' && name !=='') {
					const result = JSON.parse(response);
					
					newtable = document.createElement('table');
					tr1 = document.createElement('tr');
					tr2 = document.createElement('tr');
					
					for (key in result) {
						th = document.createElement('th');
						th.style.border = '1px solid black';
						th.innerText = key;
						tr1.appendChild(th);
						
						td = document.createElement('td');
						td.innerText = result[key];
						if (result[key] == 0) { td.innerText = "남자"; }
						else if (result[key] == 1) { td.innerText = "여자"; }		
						td.style.border = '1px solid black';
						tr2.appendChild(td);
					}
					
					newtable.appendChild(tr1);
					newtable.appendChild(tr2);
					newtable.style.border = '1px solid black';
					newtable.style.collapse = 'collapse';
					div.appendChild(newtable);
					
					newtable.align = 'center';
				}

			else {
					newtable = document.createElement('table');
					h2 = document.createElement('h2');
					h2.innerText = '검색 결과가 없습니다';
					newtable.appendChild(h2);
					newtable.align = 'center';
					div.appendChild(newtable);
				}				 		
			}			
		}
		request.send();
	
	}
	
	
	function update() {
		section = document.getElementById('section');
		
		html = '<h3>업데이트</h3>';
		html += '<div class="sharediv" align="center">';
		html += '<form method="POST" id="deleteForm">';
		html += '<input type="text" placeholder="이름을 입력하세요" name="name" id="name">';
		html += '<input type="text" placeholder="변경하려는 이름은?" name="chagne" id="change">';
		html += '<input type="button" onclick="put()" value="변경">';
		html += '</form>';
		html += '</div>';
		
		section.innerHTML = html;
	}
	
	function put() {
		
		name = document.getElementById('name').value;
		changename = document.getElementById('change').value;
		console.log("name : " + name);
		console.log('changename : ' + changename);
		
		ob = {
				name : name,
				changename : changename,
		}
		
		data = JSON.stringify(ob);
		console.log("JSON.stringify(form) 자료형 : " + typeof data);
		console.log("JSON.stringify(ob) : " + data);
		console.log("ob : " + ob);
		
		
		const request = new XMLHttpRequest(); // xhr
		request.open("PUT", "${cpath}/Ajax/", true); // 비동기식으로 실행할지 말지 -> true
		request.setRequestHeader('Content-type','application/json; charset=UTF-8');
	
		request.onreadystatechange = function() {
			if (request.readyState == 4 && request.status == 200) {
					response = request.response;
					changeList(response);
				}			
			else {
				}				 		
			}
		
		request.send(data);
	}
	
	function del() {
		section = document.getElementById('section');
		
		html = '<h3>삭제하기</h3>';
		html += '<div class="sharediv" align="center">';
		html += '<form method="POST" id="deleteForm">';
		html += '<input type="text" placeholder="이름을 입력하세요" name="name" id="name">';
		html += '<input type="button" onclick="delDB()" value="삭제하기">';
		html += '</form>';
		html += '</div>';
		
		section.innerHTML = html;
	}
	
	function delDB() {
		if (delalert()) {
			name = document.getElementById("name").value;
			const request = new XMLHttpRequest(); // xhr
			request.open("DELETE", "${cpath}/Ajax/" + name + "/", true); // 비동기식으로 실행할지 말지 -> true
			request.setRequestHeader('Content-type','text; charset=UTF-8');
		
			request.send();
			
			request.onreadystatechange = function() {
				if (request.readyState == 4 && request.status == 200) {
					response = request.response;	
					changeList(response);
					if (response !== '') {
						console.log("계정이 삭제되었습니다");
					}
					else { console.log("찾으시는 계정이 없습니다"); }
				}
			}
		}
		else { alert("삭제 취소"); trcreate(); }	
	}
	
	function delalert() {
		 if (confirm("정말 삭제하시겠습니까??") == true){
		     return true;
		 }else{
		     return false;
		 }
	}
	
</script>
</body>
</html>