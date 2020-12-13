<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/style.css">
<title>Liikaa asiakkaita</title>
</head>
<body onkeydown="tutkiKey(event)">
<table id="lista">
		<thead>
		<tr>
		<th colspan="5" class="right"><a id="lisaaUusi" href="lisaaAsiakas.jsp">Uusi asiakas</a></th>
		</tr>
		<tr>
			<th class="right" colspan="2">Hakusana:</th>
			<th><input type="text" id="term" size="15em"></th>
			<th class="left" colspan="2"><input type="button" value="Hae" id="nappi"></th>
		</tr>
		<tr class="left">
			<th>Etunimi</th>
			<th>Sukunimi</th>
			<th>Puhelin</th>
			<th colspan="2">Sposti</th>
		</tr>
		</thead>
		<tbody id="tbody">
		</tbody>
	</table>
	<span id='ilmo'></span>

	

<script>
noudaAs();
document.getElementById("term").focus();

function tutkiKey(event){
	if(event.keyCode==13){
		noudaAs();
	}		
}
	
function noudaAs() {
	document.getElementById("tbody").innerHTML = "";
	fetch("asiakkaat/" + document.getElementById("term").value, {method: 'GET'})
	.then(function (response) {//Odotetaan vastausta ja muutetaan JSON-vastaus objektiksi
		return response.json(); 	
	})
	.then(function (responseJson) {
		var asiakkaat = responseJson.asiakkaat; 
		var rowStr = ""; 
		for(var i=0; i<asiakkaat.length; i++) {
			rowStr+="<tr>";
			rowStr+="<td>"+asiakkaat[i].etunimi+"</td>";
			rowStr+="<td>"+asiakkaat[i].sukunimi+"</td>";
			rowStr+="<td>"+asiakkaat[i].puhelin+"</td>";
			rowStr+="<td>"+asiakkaat[i].sposti+"</td>";
			rowStr+="<td><a href='muutaasiakas.jsp?asiakas_id="+asiakkaat[i].asiakas_id+"'>Muuta</a>&nbsp;";
			rowStr+="<span class='delete' onclick=poista("+asiakkaat[i].asiakas_id+",'"+asiakkaat[i].etunimi+"','"+asiakkaat[i].sukunimi+"')>Poista</span></td>";
			rowStr+="</tr>";
		}
		document.getElementById("tbody").innerHTML = rowStr;
	})
	}
	
	function poista(asiakas_id, etunimi, sukunimi) {
		if(confirm("Poista asiakas " + etunimi +" "+ sukunimi + "?")){
			fetch("asiakkaat/"+asiakas_id, {method: 'DELETE'})
			.then(function (response) {
				return response.json()
			})
			.then(function (responseJson) {//Otetaan vastaan objekti responseJson-parametriss�		
			var vastaus = responseJson.response;		
			if(vastaus==0){
				document.getElementById("ilmo").innerHTML= "Asiakasta ei voitu poistaa.";
	        }else if(vastaus==1){	        	
	        	document.getElementById("ilmo").innerHTML="Asiakkaan " + asiakas_id +" poisto onnistui..";
				noudaAs();        	
			}	
			setTimeout(function(){ document.getElementById("ilmo").innerHTML=""; }, 5000);
		})
		}
	}; 
	
</script>

</body>
</html>