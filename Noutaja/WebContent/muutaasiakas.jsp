<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="scripts/main.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/style.css">
<title>Insert title here</title>
</head>
<body>
<form id="info" accept-charset=UTF-8>
	<table>
		<thead>
			<tr>
			<th colspan="5" class="right"><span id="back">Listaukseen</span></th>
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
			<td><input type="submit" id="save" value="Muuta"></td>
			</tr>
		</tbody>
	</table>
	<input type="hidden" name="asiakas_id" id="asiakas_id">
</form>
<span id="ilmo"></span>
</body>
<script>
$(document).ready(function(){
	$("#back").click(function() {
		document.location="listaaasiakkaat.jsp";
	});
	
	var asiakas_id = requestURLParam("asiakas_id"); 
	$.ajax({url:"asiakkaat/getone/"+asiakas_id, type:"GET", dataType:"json", success:function(result){	
		$("#asiakas_id").val(result.asiakas_id)
		$("#fName").val(result.etunimi);		
		$("#lName").val(result.sukunimi);	
		$("#phone").val(result.puhelin);
		$("#email").val(result.sposti);
	}});
	
	$("#info").validate({
		rules: {
			fName: {
				required: true,
				minlength: 2
			},
			lName: {
				required: true,
				minlength: 2
			},
			phone: {
				required: true, 
				minlength: 5,
				maxlength: 15
			},
			email: {
				required: true, 
				minlength: 5
			}
		}, 
		messages: {
			fName: {
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			},
			lName: {
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			},
			phone: {
				required: "Puuttuu", 
				minlength: "Liian lyhyt",
				maxlength: "Liian pitk�"
			},
			email: {
				required: "Puuttuu", 
				minlength: "Liian lyhyt"
			}
		}, 
		submitHandler: function(form) {
			muutaAs(); 
		}
	});
}); 

function muutaAs() {//PUT back
	var formJsonStr = formDataJsonStr($("#info").serializeArray()); //muutetaan lomakkeen tiedot json-stringiksi
	$.ajax({url:"asiakkaat", data:formJsonStr, type:"PUT", dataType:"json", success:function(result) { //result on joko {"response:1"} tai {"response:0"}       
		if(result.response==0){
      	$("#ilmo").html("Asiakasta ei voitu p�ivitt��.");
      }else if(result.response==1){			
      	$("#ilmo").html("Asiakas p�ivitetty.");
      	$("#fName", "#lName", "#phone", "#email").val("");
		}
  }});	
	
}

</script>
</html>