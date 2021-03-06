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
<title>Uuden asiakkaan tiedot</title>
</head>
<body>
<form id="info" accept-charset=UTF-8>
	<table>
		<thead>
			<tr>
			<th colspan="4" class="right"><span id="back">Listaukseen</span></th>
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
			<td><input type="submit" id="save" value="Lis�ys"></td>
			</tr>
		</tbody>
	</table>
</form>
<span id="ilmo"></span>
</body>
<script>
$(document).ready(function(){
	$("#back").click(function() {
		document.location="listaaasiakkaat.jsp";
	});
	
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
			lisaaAs(); 
		}
	});
	$("fName").focus(); 
});
function lisaaAs() {
	var formJsonStr = formDataJsonStr($("#info").serializeArray()); //muutetaan lomakkeen tiedot json-stringiksi
	$.ajax({url:"asiakkaat", data:formJsonStr, type:"POST", dataType:"json", success:function(result) { //result on joko {"response:1"} tai {"response:0"}       
		if(result.response==0){
      	$("#ilmo").html("Asiakasta ei voitu lis�t�.");
      }else if(result.response==1){			
      	$("#ilmo").html("Asiakas lis�tty.");
      	$("#fName", "#lName", "#phone", "#email").val("");
		}
  }});	
	
}




</script>
</html>