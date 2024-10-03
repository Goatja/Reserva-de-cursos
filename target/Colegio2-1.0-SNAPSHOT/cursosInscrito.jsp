<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cursos Inscritos</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #d1c5c5;
        }

        .tarjeta {
            width: 300px;
            height: 200px;
            border: 2px solid transparent;
            border-radius: 10px;
            position: relative;
            overflow: hidden;
            background-color: white;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1), 0 6px 20px rgba(0, 0, 0, 0.1);
            opacity: 0;
            transform: translateY(50px);
            animation: llegada 1.5s ease-out forwards;
        }

        .tarjeta::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            border: 2px solid red;
            border-radius: 10px;
            box-sizing: border-box;
            animation: correr-borde 3s linear infinite;
        }

        @keyframes correr-borde {
            0% {
                clip-path: inset(0 100% 0 0);
            }
            25% {
                clip-path: inset(0 0 100% 0);
            }
            50% {
                clip-path: inset(0 0 0 100%);
            }
            75% {
                clip-path: inset(100% 0 0 0);
            }
            100% {
                clip-path: inset(0 100% 0 0);
            }
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

        .tarjeta:hover {
            transform: scale(1.05) rotateX(10deg) rotateY(-10deg);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2), 0 12px 30px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
    </style>
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
                <a class="nav-link" href="InscripcionController">Inicio</a>
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
    <h2>Cursos Inscritos</h2>
    
    <c:if test="${not empty cursosInscritos}">
        <div class="row">
            <c:set var="totalGasto" value="0" />
            <c:forEach var="curso" items="${cursosInscritos}">
                <div class="col-md-4 mb-4">
                    <div class="card tarjeta">
                        <div class="card-body">
                            <h5 class="card-title">${curso.nombreCurso}</h5>
                            <p class="card-text">Duración: ${curso.duracion} hrs</p>
                            <p class="card-text">Costo: $${curso.costoCurso}</p>
                            <p class="card-text">Fecha de Inscripción: ${curso.fechaInscripcion}</p>
                        </div>
                    </div>
                </div>
                <!-- Sumar el costo de cada curso al total -->
                <c:set var="totalGasto" value="${totalGasto + curso.costoCurso}" />
            </c:forEach>
        </div>

        <!-- Mostrar el gasto total -->
        <div class="alert alert-info mt-4">
            <strong>Gasto total en cursos inscritos:</strong> $<c:out value="${totalGasto}" />
        </div>
    </c:if>
    
    <c:if test="${empty cursosInscritos}">
        <div class="alert alert-warning" role="alert">
            No hay cursos inscritos.
        </div>
    </c:if>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
