<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">

<title>Problema Chevere</title>
</head>
<body>

	<jsp:include page="menu.jsp"></jsp:include>

	<div class="container">

		<h1>MCD y MCM de dos números</h1>

		<!-- Card de datos de entrada -->
		<div class="card">
			<div class="card-header">Datos</div>
			<div class="card-body">
				<form method="post" action="procesarOpcion1">
					<div class="mb-3 row">
						<label for="num1" class="col-sm-2 col-form-label">Número
							1:</label>
						<div class="col-sm-10">
							<input type="number" class="form-control" id="num1" name="num1">
						</div>
					</div>
					<div class="mb-3 row">
						<label for="num2" class="col-sm-2 col-form-label">Número
							2:</label>
						<div class="col-sm-10">
							<input type="number" class="form-control" id="num2" name="num2">
						</div>
					</div>
					<div class="col-auto offset-sm-2">
						<button type="submit" class="btn btn-primary mb-3">Procesar</button>
					</div>
				</form>
			</div>
		</div>

		<!-- Card de resultados -->
		<br/>
		<c:if test="${ ! empty respuesta }">
		<div class="card">
			<div class="card-header">Resultado</div>
			<div class="card-body">
				<form action="">
					<div class="mb-3 row">
						<label class="col-sm-2 col-form-label">Número
							1:</label>
						<div class="col-sm-10">
							<label>${num1}</label>
						</div>
					</div>
					<div class="mb-3 row">
						<label class="col-sm-2 col-form-label">Número
							2:</label>
						<div class="col-sm-10">
							<label>${num2}</label>
						</div>
					</div>
					<div class="mb-3 row">
						<label class="col-sm-2 col-form-label">MCD:</label>
						<div class="col-sm-10">
							<label>${mcd}</label>
						</div>
					</div>
					<div class="mb-3 row">
						<label class="col-sm-2 col-form-label">MCM:</label>
						<div class="col-sm-10">
							<label>${mcm}</label>
						</div>
					</div>
				</form>
			</div>
		</div>
		</c:if>

	</div>

	<!-- Bootstrap Bundle with Popper -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
		crossorigin="anonymous"></script>

</body>
</html>