/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modeloDAO;

import db.Conexion;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import modelo.Curso;

/**
 *
 * @author Owner
 */
public class CursoDAO {

    private PreparedStatement ps;
    private Connection con;
    private Conexion cn;
    private ResultSet rs;

    public CursoDAO() {
        cn = new Conexion();
    }

    // Método para obtener todos los cursos
    public ArrayList<Curso> consultaGeneral() {
        ArrayList<Curso> consulta = new ArrayList<>();
        String sql = "SELECT * FROM Cursos";

        try {
            ps = cn.getConnection().prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Curso curso = new Curso();
                curso.setIdCurso(rs.getInt("ID_Curso"));
                curso.setNombreCurso(rs.getString("Nombre_Curso"));
                curso.setDuracion(rs.getInt("Duración"));
                curso.setCostoCurso(rs.getDouble("Costo_Curso"));
                consulta.add(curso);
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return consulta;
    }

    // Método para agregar un nuevo curso
    public boolean agregar(Curso curso) throws SQLException {
        try {
            String sql = "INSERT INTO Cursos (Nombre_Curso, Duración, Costo_Curso) VALUES (?, ?, ?)";
            ps = cn.getConnection().prepareStatement(sql);
            ps.setString(1, curso.getNombreCurso());
            ps.setInt(2, curso.getDuracion());
            ps.setDouble(3, curso.getCostoCurso());
            int fila = ps.executeUpdate();

            return fila > 0;
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return false;
    }

    // Método para actualizar un curso existente
    public boolean actualizar(Curso curso) throws SQLException {
        try {
            String sql = "UPDATE Cursos SET Nombre_Curso = ?, Duración = ?, Costo_Curso = ? WHERE ID_Curso = ?";
            ps = cn.getConnection().prepareStatement(sql);
            ps.setString(1, curso.getNombreCurso());
            ps.setInt(2, curso.getDuracion());
            ps.setDouble(3, curso.getCostoCurso());
            ps.setInt(4, curso.getIdCurso());
            int fila = ps.executeUpdate();

            return fila > 0;
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return false;
    }

    // Método para eliminar un curso
    public boolean eliminar(int idCurso) throws SQLException {
        try {
            String sql = "DELETE FROM Cursos WHERE ID_Curso = ?";
            ps = cn.getConnection().prepareStatement(sql);
            ps.setInt(1, idCurso);
            int fila = ps.executeUpdate();

            return fila > 0;
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return false;
    }
    
    
   public ArrayList<Curso> obtenerCursosConInscritos() throws SQLException {
    ArrayList<Curso> cursos = new ArrayList<>();
    
     String sql = "SELECT c.ID_Curso, c.Nombre_Curso, c.Duracion, c.Costo, i.Fecha_Inscripción " +
                 "FROM Cursos c " +
                 "JOIN Inscripciones i ON c.ID_Curso = i.Curso_ID " +
                 "GROUP BY c.ID_Curso, i.Fecha_Inscripción"; // Agrupar también por la fecha de inscripción = ?";
            ps = cn.getConnection().prepareStatement(sql);
            ResultSet rs = ps.executeQuery(sql);
   

    try {
        

        while (rs.next()) {
            Curso curso = new Curso();
            curso.setIdCurso(rs.getInt("ID_Curso"));
            curso.setNombreCurso(rs.getString("Nombre_Curso"));
            curso.setDuracion(rs.getInt("Duracion"));
            curso.setCostoCurso(rs.getDouble("Costo"));
            curso.setFechaInscripcion(rs.getDate("Fecha_Inscripción")); // Asegúrate de que este método exista en tu clase Curso

            cursos.add(curso);
        }
    } catch (SQLException e) {
        e.printStackTrace();
        // Manejo de errores, puedes lanzar una excepción o loguear
    }
    return cursos;
}

}
