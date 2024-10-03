/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import modelo.Curso;
import modelo.Inscripcion;
import modeloDAO.CursoDAO;
import modeloDAO.InscripcionDAO;

/**
 *
 * @author Owner
 */
@WebServlet(name = "InscripcionController", urlPatterns = {"/InscripcionController"})
public class InscripcionController extends HttpServlet {

   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet InscripcionController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet InscripcionController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
       // HttpSession session = request.getSession();
       if ("mostrar".equals(action)){
           
        InscripcionDAO inscripcionDAO = new InscripcionDAO();
        ArrayList<Inscripcion> inscripcion  = inscripcionDAO.consultaGeneral();
        request.setAttribute("inscripcion", inscripcion);
        RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
        dispatcher.forward(request, response);
        
       }else if ("inscribir".equals(action)){
          int id = Integer.parseInt(request.getParameter("id"));
    CursoDAO cursoDAO = new CursoDAO();

    // Obtén el curso por ID
    Curso curso = cursoDAO.consultaGeneral().stream()
            .filter(c -> c.getIdCurso() == id) // Asegúrate de que el método se llame correctamente
            .findFirst()
            .orElse(null);
    
    // Establece el curso en el request
    request.setAttribute("curso", curso);
    RequestDispatcher dispatcher = request.getRequestDispatcher("inscripcion.jsp");
    dispatcher.forward(request, response);

       }else if ("inscrito".equals(action)){
          CursoDAO cursoDAO = new CursoDAO();
        
        // Obtener la lista de cursos inscritos
        ArrayList<Curso> cursosInscritos;
        try {
            cursosInscritos = cursoDAO.obtenerCursosConInscritos();
            
            // Establecer la lista de cursos como atributo
            request.setAttribute("cursosInscritos", cursosInscritos);
            
            if(cursosInscritos.isEmpty()){
                System.out.println("esta vacio");
            }else{
                System.out.println(cursosInscritos);
            }
            
            // Redirigir a la JSP que muestra los cursos inscritos
            RequestDispatcher dispatcher = request.getRequestDispatcher("cursosInscrito.jsp");
            dispatcher.forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(InscripcionController.class.getName()).log(Level.SEVERE, null, ex);
            // Manejo de errores, puedes redirigir a una página de error
            request.setAttribute("errorMessage", "Error al obtener los cursos inscritos.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
            dispatcher.forward(request, response);
        }
       }else if ("curso".equals(action)){
           response.sendRedirect(request.getContextPath() + "/CursoController");
       
       }else if ("verInscritos".equals(action)){
           CursoDAO cursoDAO = new CursoDAO();
                InscripcionDAO inscripcionDAO = new InscripcionDAO();

                // Obtener la lista de inscripciones y cursos
                ArrayList<Inscripcion> inscritos = inscripcionDAO.consultaGeneral();
                ArrayList<Curso> cursos = cursoDAO.consultaGeneral();

                // Establecer los atributos en el request
                request.setAttribute("inscritos", inscritos); 
                

                // Redirigir a la JSP correspondiente
                RequestDispatcher dispatcher = request.getRequestDispatcher("verInscritos.jsp");
                dispatcher.forward(request, response);
           
       }else{
                CursoDAO cursoDAO = new CursoDAO();
                InscripcionDAO inscripcionDAO = new InscripcionDAO();

                // Obtener la lista de inscripciones y cursos
                ArrayList<Inscripcion> inscripciones = inscripcionDAO.consultaGeneral();
                ArrayList<Curso> cursos = cursoDAO.consultaGeneral();

                // Establecer los atributos en el request
                request.setAttribute("inscripciones", inscripciones); 
                request.setAttribute("cursos", cursos);

                // Redirigir a la JSP correspondiente
                RequestDispatcher dispatcher = request.getRequestDispatcher("cursoCliente.jsp");
                dispatcher.forward(request, response);


       }
        
        
        //processRequest(request, response);
    }

   
   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
         try {
            // Obtener los parámetros del formulario
          
            int cursoId = Integer.parseInt(request.getParameter("cursoId"));
          //  Integer alumnoId = request.getParameter("alumnoId") != null && !request.getParameter("alumnoId").isEmpty() 
                               //? Integer.parseInt(request.getParameter("alumnoId")) 
                               //: null; // Permitir nulo si no se proporciona

            // Obtener la fecha de inscripción
            String fechaInscripcionStr = request.getParameter("fechaInscripcion");
            Date fechaInscripcion = Date.valueOf(fechaInscripcionStr); // Convierte a java.sql.Date

            // Crear objeto Inscripcion
            Inscripcion inscripcion = new Inscripcion();
            inscripcion.setFechaInscripcion(fechaInscripcion);
            inscripcion.setCursoId(cursoId);
            //inscripcion.setAlumnoId(alumnoId); // Puede ser nulo

            // Insertar en la base de datos
            InscripcionDAO inscripcionDAO = new InscripcionDAO();
            inscripcionDAO.agregar(inscripcion);

            // Redirigir a una página de éxito
            doGet(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            // Manejo de errores
            response.sendRedirect("error.jsp");
        }
         
         
    }
       // processRequest(request, response);
    

   
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
