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
import java.sql.SQLException;
import java.util.ArrayList;
import modelo.Curso;
import modeloDAO.CursoDAO;

/**
 *
 * @author Owner
 */
@WebServlet(name = "CursoController", urlPatterns = {"/CursoController"})
public class CursoController extends HttpServlet {

 
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CursoController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CursoController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
String action = request.getParameter("action");
CursoDAO cursoDAO = new CursoDAO();

if ("edit".equals(action)) {
    int id = Integer.parseInt(request.getParameter("id"));
    
    // Obtén la lista de cursos y busca el curso por ID
    Curso curso = cursoDAO.consultaGeneral().stream()
                    .filter(c -> c.getIdCurso() == id) // Asegúrate de que el método se llama correctamente
                    .findFirst()
                    .orElse(null); // Retorna null si no se encuentra el curso

    request.setAttribute("curso", curso);
    RequestDispatcher dispatcher = request.getRequestDispatcher("editar.jsp");
    dispatcher.forward(request, response);
}else if("inscripcion".equals(action)){
               response.sendRedirect(request.getContextPath() + "/InscripcionController");


} else {
    ArrayList<Curso> lista = cursoDAO.consultaGeneral();
    request.setAttribute("lista", lista);
    RequestDispatcher dispatcher = request.getRequestDispatcher("curso.jsp");
    dispatcher.forward(request, response);
}


        
        //processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
      String action = request.getParameter("action");
        CursoDAO cursoDAO = new CursoDAO();

        try {
            if ("agregar".equals(action)) {
                String nombre = request.getParameter("nombre");
                int duracion = Integer.parseInt(request.getParameter("duracion")); // Convertir a entero
                double costo = Double.parseDouble(request.getParameter("costo")); // Convertir a double

                Curso curso = new Curso();
                curso.setNombreCurso(nombre);
                curso.setDuracion(duracion);
                curso.setCostoCurso(costo);

                cursoDAO.agregar(curso); // Agregar el curso

            } else if ("actualizar".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                String nombre = request.getParameter("nombre");
                int duracion = Integer.parseInt(request.getParameter("duracion")); // Convertir a entero
                double costo = Double.parseDouble(request.getParameter("costo")); // Convertir a double

                Curso curso = new Curso();
                curso.setIdCurso(id);
                curso.setNombreCurso(nombre);
                curso.setDuracion(duracion);
                curso.setCostoCurso(costo);

                cursoDAO.actualizar(curso); // Actualizar el curso

            } else if ("eliminar".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                cursoDAO.eliminar(id); // Eliminar el curso
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }

        //processRequest(request, response);s
        
        doGet(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
