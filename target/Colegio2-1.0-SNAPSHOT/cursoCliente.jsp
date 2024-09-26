<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cursos</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css">
    <style>
        body {
            background: linear-gradient(270deg, #ff6f61, #6a82fb);
            background-size: 400% 400%;
            animation: gradient 15s ease infinite;
            color: white;
        }

        @keyframes gradient {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .curso-card {
            margin-bottom: 30px;
            transition: transform 0.3s;
        }

        .curso-card:hover {
            transform: scale(1.05);
        }

        .card {
            background-color: rgba(0, 0, 0, 0.7);
            border-radius: 15px; /* Esquinas redondeadas */
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.5); /* Sombra */
        }

        .card-title, .card-text {
            color: white;
        }

        .navbar {
            background-color: rgba(255, 255, 255, 0.8);
            transition: background-color 0.3s;
        }

        .navbar.scrolled {
            background-color: rgba(0, 0, 0, 0.8);
        }

        .nav-link {
            color: #333 !important;
        }

        .nav-link:hover {
            color: #ff6f61 !important;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-light sticky-top">
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
                <a class="nav-link" href="InscripcionController?action=inscrito">Mis Inscripciones</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="InscripcionController?action=curso">Agregar cursos</a>
            </li>
        </ul>
    </div>
</nav>

<div class="container mt-4">
    <div class="row">
        <div class="col-md-8">
            <h2>Cursos Disponibles</h2>
            <form class="form-inline mb-4" method="get" action="buscadorServlet">
                <input class="form-control mr-2" type="search" placeholder="Buscar cursos" aria-label="Buscar" name="query">
                <button class="btn btn-outline-success" type="submit">Buscar</button>
            </form>

            <div class="row">
                <c:forEach var="curso" items="${cursos}" varStatus="status">
                    <c:if test="${status.index < 10}">
                        <div class="col-md-6 curso-card">
                            <div class="card">
                                <div class="card-head">
                                    <img src="https://resizer.iproimg.com/unsafe/1200x/https://assets.iproup.com/assets/jpg/2020/11/13746.jpg" width="100%" class="card-img-top">
                                </div>
                                <div class="card-body">
                                    <h5 class="card-title">${curso.nombreCurso}</h5>
                                    <p class="card-text">Duración: ${curso.duracion} hrs</p>
                                    <p class="card-text">$ ${curso.costoCurso}</p>
                                    <a href="InscripcionController?action=inscribir&id=${curso.idCurso}" class="btn btn-primary">Inscribirse</a>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </div>

        <div class="col-md-4">
            <h2>Mis Inscripciones</h2>
            <c:if test="${not empty inscripciones}">
                <table class="table table-striped" id="myTable">
                    <thead>
                        <tr>
                            <th>ID Inscripción</th>
                            <th>Fecha de Inscripción</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="inscripcion" items="${inscripciones}">
                            <tr>
                                <td>${inscripcion.idInscripcion}</td>
                                <td>${inscripcion.fechaInscripcion}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
            <c:if test="${empty inscripciones}">
                <div class="alert alert-warning" role="alert" style="margin-top: 0.5rem;">
                    No tienes inscripciones.
                </div>
            </c:if>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
    $(document).ready(function() {
        $('#myTable').DataTable({
            language: {
                url: 'https://cdn.datatables.net/plug-ins/1.10.21/i18n/Spanish.json'
            }
        });

        $(window).scroll(function() {
            if ($(this).scrollTop() > 50) {
                $('.navbar').addClass('scrolled');
            } else {
                $('.navbar').removeClass('scrolled');
            }
        });
    });
</script>
</body>
</html>
