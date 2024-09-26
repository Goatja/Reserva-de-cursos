<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Curso</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <h2>Editar Curso</h2>
    
    <form action="CursoController?action=actualizar" method="POST">
        <input type="hidden" name="id" value="${curso.idCurso}"> <!-- ID oculto -->
        
        <div class="form-group">
            <label for="nombre">Nombre del Curso</label>
            <input type="text" class="form-control" id="nombre" name="nombre" 
                   value="${curso.nombreCurso}" required>
        </div>
        
        <div class="form-group">
            <label for="duracion">Duración (horas)</label>
            <input type="number" class="form-control" id="duracion" name="duracion" 
                   value="${curso.duracion}" required>
        </div>
        
        <div class="form-group">
            <label for="costo">Costo</label>
            <input type="number" step="0.01" class="form-control" id="costo" name="costo" 
                   value="${curso.costoCurso}" required>
        </div>
        
        <button type="submit" class="btn btn-primary">Actualizar</button>
        <a href="curso.jsp" class="btn btn-secondary">Cancelar</a>
    </form>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
</body>
</html>
