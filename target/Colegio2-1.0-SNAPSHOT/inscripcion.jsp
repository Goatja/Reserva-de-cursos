<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inscripción al Curso</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="#">Mi Plataforma</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav">
            <li class="nav-item">
                <a class="nav-link" href="#">Inicio</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">Cursos</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">Contacto</a>
            </li>
        </ul>
    </div>
</nav>

<div class="container mt-4">
    <h2>Inscripción al Curso</h2>

    <c:if test="${not empty curso}">
        <h5>Curso: ${curso.nombreCurso}</h5>
        <p>Duración: ${curso.duracion} hrs</p>
        <p>Costo: $${curso.costoCurso}</p>

        <form action="InscripcionController" method="post">
            <input type="hidden" name="cursoId" value="${curso.idCurso}">
            <input type="hidden" name="fechaInscripcion" value="<%= new SimpleDateFormat("yyyy-MM-dd").format(new Date()) %>"> <!-- Fecha actual en formato adecuado -->
            
           
            <button type="submit" class="btn btn-primary">Inscribirse</button>
        </form>
    </c:if>

    <c:if test="${empty curso}">
        <div class="alert alert-danger" role="alert">
            No se pudo encontrar información del curso.
        </div>
    </c:if>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
