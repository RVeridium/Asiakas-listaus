<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="scripts/main.js"></script>
<link rel="stylesheet" type="text/css" href="css/style.css">
<title>Uuden asiakkaan tiedot</title>
</head>
<body>
<form id="info" accept-charset=UTF-8>
	<table>
		<thead>
			<tr>
			<th colspan="4" class="right"><a id="back" href="listaaasiakkaat.jsp">Listaukseen</a></th>
			</tr>
			<tr>
			<th>Etunimi</th><th>Sukunimi</th><th>Puhelin</th><th>Sposti</th>
			</tr>
		</thead>
		<tbody>
			<tr>
			<td><input type="text" name="fName" id="fName"></td>
			<td><input type="text" name="lName" id="lName"></td>
			<td><input type="text" name="phone" id="phone"></td>
			<td><input type="text" name="email" id="email"></td>
			<td><input type="button" name="nap" id="tallennus" value="Lisäys" onclick="lisaaAs()"></td>
			</tr>
		</tbody>
	</table>
</form>
<span id="ilmo"></span>
</body>
<script>
function tutkiKey(event){
	if(event.keyCode==13){
		lisaaAs();
	}		
}

document.getElementById("fName").focus(); 

function lisaaAs() {
	var ilmo=""; 
	if(document.getElementById("fName").value.length<2){
		ilmo="Nimi ei kelpaa!";		
	}else if(document.getElementById("lName").value.length<2){
		ilmo="Nimi ei kelpaa!";		
	}else if(document.getElementById("phone").value.length<5){
		ilmo="Puhelinnumero on liian lyhyt!";		
	}else if(document.getElementById("email").value.length<5){
		ilmo="Email on liian lyhyt!";	
	}
	if(ilmo!=""){
		document.getElementById("ilmo").innerHTML=ilmo;
		setTimeout(function(){ document.getElementById("ilmo").innerHTML=""; }, 3000);
		return;
	}
	
	document.getElementById("fName").value=cleanUp(document.getElementById("fName").value);
	document.getElementById("lName").value=cleanUp(document.getElementById("lName").value);
	document.getElementById("phone").value=cleanUp(document.getElementById("phone").value);
	document.getElementById("email").value=cleanUp(document.getElementById("email").value);	

	var formJsonStr = formDataJsonStr(document.getElementById("info")); 
	
	fetch("asiakkaat", {method: "POST", body: formJsonStr})
	.then( function (response) {	
		return response.json()
	})
	.then( function (responseJson) {
		var vastaus = responseJson.response;		
		if(vastaus==0){
			document.getElementById("ilmo").innerHTML="Asiakasta ei voitu lisätä.";
      	}else if(vastaus==1){	        	
      		document.getElementById("ilmo").innerHTML="Asiakas lisätty.";			      	
		}
		setTimeout(function(){ document.getElementById("ilmo").innerHTML=""; }, 5000);
	});	
	document.getElementById("info").reset(); 
}




</script>
</html>