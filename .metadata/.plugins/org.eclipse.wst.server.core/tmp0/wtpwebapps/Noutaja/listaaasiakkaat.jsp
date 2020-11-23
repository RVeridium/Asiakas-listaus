<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/style.css">
<title>Liikaa asiakkaita</title>
</head>
<body>
<table id="lista">
		<thead>
		<tr>
		<th colspan="5" class="right"><span id="lisaaUusi">Uusi asiakas</span></th>
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
		<tbody>
		</tbody>
	</table>
	<span id='ilmo'></span>

	

<script>
	$(document).ready(function(){
		$("#lisaaUusi").click(function() {
			document.location="lisaaAsiakas.jsp";
		});
		noudaAs(); 
		$("#nappi").click(function(){		
			noudaAs();
		});
		$(document.body).on("keydown", function(event){
			  if(event.which==13){
				  noudaAs();
			  }
		});
		$("#term").focus();
	});
	
	function noudaAs() {
		$("#lista tbody").empty(); 
		$.ajax({url:"asiakkaat/"+$("#term").val(), type:"GET", dataType:"json", success:function(result) {
			$.each(result.asiakkaat, function(i, field) {
				var rowStr; 
				rowStr+="<tr id='rivi_"+field.asiakas_id+"'>";
				rowStr+="<td>"+field.etunimi+"</td>";
				rowStr+="<td>"+field.sukunimi+"</td>";
				rowStr+="<td>"+field.puhelin+"</td>";
				rowStr+="<td>"+field.sposti+"</td>";
				rowStr+="<td><span class='delete' onclick=poista('"+field.asiakas_id+"')>Poista</span></td>";
				rowStr+="</tr>";
				$("#lista tbody").append(rowStr); 
			});
		}});
	};
	
	function poista(asiakas_id) {
		if(confirm("Poista asiakas " + asiakas_id +"?")){
			$.ajax({url:"asiakkaat/"+asiakas_id, type:"DELETE", dataType:"json", success:function(result) { //result on joko {"response:1"} tai {"response:0"}
		        if(result.response==0){
		        	$("#ilmo").html("Asiakasta ei voitu poistaa.");
		        }else if(result.response==1){
		        	$("#rivi_"+asiakas_id).css("background-color", "red"); 
		        	alert("Asiakkaan " + asiakas_id +" poisto onnistui.");
					noudaAs();        	
				}
		    }});
		}
		
	};
	
</script>

</body>
</html>