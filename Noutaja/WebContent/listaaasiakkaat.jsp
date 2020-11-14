<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<title>Liikaa asiakkaita</title>
<style>
.right{text-align: right;}
.left{text-align: left;} 
table{width: 30%;}
th{height: 3em; background-color: #6495ED}
tr{padding: 5px;}
tr:nth-child(odd) {background-color: #f2f2f2;}


</style>
</head>
<body>
<table id="lista">
		<thead>
		<tr>
			<th class="right" colspan="2">Hakusana:</th>
			<th><input type="text" id="term" size="15em"></th>
			<th class="left"><input type="button" value="Hae" id="nappi"></th>
		</tr>
		<tr class="left">
			<th>Etunimi</th>
			<th>Sukunimi</th>
			<th>Puhelin</th>
			<th>Sposti</th>
		</tr>
		</thead>
		<tbody>
		</tbody>
	</table>

	

<script>
	$(document).ready(function(){
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
				rowStr+="<tr>";
				rowStr+="<td>"+field.etunimi+"</td>";
				rowStr+="<td>"+field.sukunimi+"</td>";
				rowStr+="<td>"+field.puhelin+"</td>";
				rowStr+="<td>"+field.sposti+"</td>";
				rowStr+="</tr>";
				$("#lista tbody").append(rowStr); 
			});
		}});
	}
	
</script>

</body>
</html>