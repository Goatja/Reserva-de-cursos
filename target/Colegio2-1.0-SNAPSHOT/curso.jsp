<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gesti�n de Cursos</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css">
</head>
<body>
<div class="container mt-5">
    <h2>Gesti�n de Cursos</h2>

    <!-- Formulario para agregar un nuevo curso -->
    <form action="CursoController" method="POST" class="mb-4">
        <input type="hidden" name="action" value="agregar">
        <div class="form-row">
            <div class="form-group col-md-4">
                <label for="nombre">Nombre del Curso</label>
                <input type="text" class="form-control" id="nombre" name="nombre" required>
            </div>
            <div class="form-group col-md-4">
                <label for="duracion">Duraci�n (horas)</label>
                <input type="number" class="form-control" id="duracion" name="duracion" required>
            </div>
            <div class="form-group col-md-4">
                <label for="costo">Costo</label>
                <input type="number" step="0.01" class="form-control" id="costo" name="costo" required>
            </div>
        </div>
        <button type="submit" class="btn btn-primary">Agregar Curso</button>
    </form>

    <!-- Botn para ir a Inscribir -->
    <a href="CursoController?action=inscripcion" class="btn btn-success mb-3">Ir a Inscribir Cursos</a>

    <!-- Tabla de cursos -->
    <table id="cursosTable" class="table table-striped">
        <thead>
            <tr>
                <th>ID</th>
                <th>Nombre</th>
                <th>Duraci�n</th>
                <th>Costo</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="curso" items="${lista}">
                <tr>
                    <td>${curso.idCurso}</td>
                    <td>${curso.nombreCurso}</td>
                    <td>${curso.duracion}</td>
                    <td>${curso.costoCurso}</td>
                    <td>
                        <a href="CursoController?action=edit&id=${curso.idCurso}" class="btn btn-warning">Editar</a>
                        <form action="CursoController" method="post" style="display:inline;">
                            <input type="hidden" name="id" value="${curso.idCurso}">
                            <input type="hidden" name="action" value="eliminar">
                            <button type="submit" class="btn btn-danger" onclick="return confirm('�Est� seguro de eliminar este curso?');">Eliminar</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
<script>
    $(document).ready(function() {
        $('#cursosTable').DataTable();
    });
</script>
</body>
</html>
