<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="scripts/main.js"></script>
<link rel="stylesheet" type="text/css" href="css/style.css">
<title>Muuta asiakasta</title>
</head>
<body>
<form id="info" accept-charset=UTF-8>
	<table>
		<thead>
			<tr>
			<th colspan="5" class="right"><a id="back" href="listaaasiakkaat.jsp">Listaukseen</a></th>
			</tr>
			<tr>
			<th>Etunimi</th><th>Sukunimi</th><th>Puhelin</th><th colspan="2">Sposti</th>
			</tr>
		</thead>
		<tbody>
			<tr>
			<td><input type="text" name="fName" id="fName"></td>
			<td><input type="text" name="lName" id="lName"></td>
			<td><input type="text" name="phone" id="phone"></td>
			<td><input type="text" name="email" id="email"></td>
			<td><input type="button" id="saves" value="Muuta" onclick="muutaAs()"></td>
			</tr>
		</tbody>
	</table>
	<input type="hidden" name="asiakas_id" id="asiakas_id">
</form>
<span id="ilmo"></span>
</body>
<script>
var tutkiKey = (event) => {
	if(event.keyCode==13){//Enter
		muutaAs();
	}	
}
document.getElementById("fName").focus(); 

var asiakas_id = requestURLParam("asiakas_id"); 
fetch("asiakkaat/getone/"+asiakas_id, {method: 'GET'})
.then( function (response) {
	return response.json()
})
.then(function (responseJson) {
	document.getElementById("fName").value = responseJson.etunimi;
	document.getElementById("lName").value = responseJson.sukunimi;
	document.getElementById("phone").value = responseJson.puhelin;
	document.getElementById("email").value = responseJson.sposti;
	document.getElementById("asiakas_id").value = responseJson.asiakas_id;
}); 

function muutaAs() {//PUT back
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
	console.log(formJsonStr); 
	
	fetch("asiakkaat", {method: 'PUT', body: formJsonStr})
	.then( function (response) {
		return response.json();
	})
	.then( function (responseJson) {
		var vastaus = responseJson.response;		
		if(vastaus==0){
			document.getElementById("ilmo").innerHTML="Asiakasta ei voitu muuttaa.";
      	}else if(vastaus==1){	        	
      		document.getElementById("ilmo").innerHTML="Asiakas muutettu.";			      	
		}
		setTimeout(function(){ document.getElementById("ilmo").innerHTML=""; }, 5000);
	});	
	document.getElementById("info").reset(); 
	
}

</script>
</html>