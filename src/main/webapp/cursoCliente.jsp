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
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.5);
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

        .tarjeta {
            animation: llegada 1.5s ease-out forwards;
        }

        @keyframes llegada {
            0% {
                opacity: 0;
                transform: translateY(50px);
            }
            100% {
                opacity: 1;
                transform: translateY(0);
            }
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
            <form class="form-inline mb-4" method="get" action="">
                <input class="form-control mr-2" type="search" placeholder="Buscar cursos" aria-label="Buscar" name="query">
                <button class="btn btn-outline-success" type="submit">Buscar</button>
            </form>

            <div class="row">
                <c:forEach var="curso" items="${cursos}" varStatus="status">
                    <c:if test="${status.index < 10}">
                        <div class="col-md-6 curso-card">
                            <div class="card tarjeta">
                                <div class="card-head">
                                    <img src="https://resizer.iproimg.com/unsafe/1200x/https://assets.iproup.com/assets/jpg/2020/11/13746.jpg" width="100%" class="card-img-top">
                                </div>
                                <div class="card-body">
                                    <h5 class="card-title">${curso.nombreCurso}</h5>
                                    <p class="card-text">Duración: ${curso.duracion} hrs</p>
                                    <p class="card-text">$ ${curso.costoCurso}</p>

                                    <div class="container" style="display: flex; padding: auto;">

                                    <a href="#" class="btn btn-info btnDetalles" 
                                       data-nombre="${curso.nombreCurso}" 
                                       data-duracion="${curso.duracion} hrs" 
                                       data-costo="$ ${curso.costoCurso}" 
                                       data-imagen="https://resizer.iproimg.com/unsafe/1200x/https://assets.iproup.com/assets/jpg/2020/11/13746.jpg"
                                       data-id="${curso.idCurso}">
                                       Inscribirse
                                    </a>
                                    <!--boton para ver los inscritos a este curso-->
                                    <a href="InscripcioController?action=verInscritos&id=${curso.idCurso}" class="btn btn-secondary btnInscritos"
                                    data-id="${curso.idCurso}"
                                    data-nombre="${curso.nombreCurso}"
                                    style="margin-left: 4px;"
                                   
                                   >Ver inscritos</a>
                                   </div>


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

<!-- Modal para mostrar detalles del curso -->
<div class="modal fade" id="cursoModal" tabindex="-1" role="dialog" aria-labelledby="cursoModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="cursoModalLabel">Detalles del Curso</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <!-- Aquí irán los detalles del curso -->
        <h5 id="modalNombreCurso"></h5>
        <p id="modalDuracionCurso"></p>
        <p id="modalCostoCurso"></p>
        <img id="modalImagenCurso" src="" alt="Imagen del curso" class="img-fluid">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
        <a href="#" id="modalLinkInscribir" class="btn btn-primary">Inscribirse</a>
      </div>
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

        // Mostrar detalles del curso en el modal
        $('.btnDetalles').on('click', function() {
            var nombreCurso = $(this).data('nombre');
            var duracionCurso = $(this).data('duracion');
            var costoCurso = $(this).data('costo');
            var imagenCurso = $(this).data('imagen');
            var idCurso = $(this).data('id');

            // Asignar valores al modal
            $('#modalNombreCurso').text(nombreCurso);
            $('#modalDuracionCurso').text(duracionCurso);
            $('#modalCostoCurso').text(costoCurso);
            $('#modalImagenCurso').attr('src', imagenCurso);
            $('#modalLinkInscribir').attr('href', 'InscripcionController?action=inscribir&id=' + idCurso);

            // Mostrar el modal
            $('#cursoModal').modal('show');
        });
    });
</script>

</body>
</html>
