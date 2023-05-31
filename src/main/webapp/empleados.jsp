<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

		<h1>CRUD DE EMPLEADOS</h1>

		<!-- Card de datos de entrada -->
		<div class="card">
			<div class="card-header">Criterios de busqueda</div>
			<div class="card-body">
				<form method="post" action="EmpleadoBuscar">
					<div class="mb-3 row">
						<div class="col-sm-4">
							<input type="text" class="form-control" id="apellido"
								name="apellido" placeholder="Ingrese apellido">
						</div>
						<div class="col-sm-4">
							<input type="text" class="form-control" id="nombre" name="nombre"
								placeholder="Ingrese mombre">
						</div>
						<div class="col-sm-2">
							<button type="submit" class="btn btn-primary mb-3" id="btnBuscar"
								name="btnBuscar">Buscar</button>
						</div>
						<div class="col-sm-2">
							<button type="submit" class="btn btn-primary mb-3" id="btnNuevo"
								name="btnNuevo">Nuevo</button>
						</div>
					</div>
				</form>
			</div>
		</div>

		<!-- Card de resultados -->
		<br />
		<c:if test="${ ! empty listado }">
			<div class="card">
				<div class="card-header">Resultado</div>
				<div class="card-body">
					<table class="table">
						<thead>
							<tr>
								<th>ID</th>
								<th>APELLIDO</th>
								<th>NOMBRE</th>
								<th>DIRECCION</th>
								<th>EMAIL</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="r" items="${listado}">
								<tr>
									<td>${r.id}</td>
									<td>${r.apellido}</td>
									<td>${r.nombre}</td>
									<td>${r.direccion}</td>
									<td>${r.email}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
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