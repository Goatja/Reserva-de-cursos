/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modeloDAO;

import db.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import modelo.Inscripcion;

/**
 *
 * @author Owner
 */public class InscripcionDAO {

    private PreparedStatement ps;
    private Connection con;
    private Conexion cn;
    private ResultSet rs;

    public InscripcionDAO() {
        cn = new Conexion();
    }

    // Método para obtener todas las inscripciones
    public ArrayList<Inscripcion> consultaGeneral() {
        ArrayList<Inscripcion> consulta = new ArrayList<>();
        String sql = "SELECT * FROM Inscripciones";

        try {
            ps = cn.getConnection().prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Inscripcion inscripcion = new Inscripcion();
                inscripcion.setIdInscripcion(rs.getInt("ID_Inscripción"));
                inscripcion.setFechaInscripcion(rs.getDate("Fecha_Inscripción"));
                inscripcion.setCursoId(rs.getInt("Curso_ID"));
                inscripcion.setAlumnoId(rs.getInt("Alumno_ID"));
                consulta.add(inscripcion);
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return consulta;
    }

    // Método para agregar una nueva inscripción
    public boolean agregar(Inscripcion inscripcion) throws SQLException {
        try {
            String sql = "INSERT INTO Inscripciones (Fecha_Inscripción, Curso_ID, Alumno_ID) VALUES (?, ?, ?)";
            ps = cn.getConnection().prepareStatement(sql);
            ps.setDate(1, new java.sql.Date(inscripcion.getFechaInscripcion().getTime()));
            ps.setInt(2, inscripcion.getCursoId());
            ps.setInt(3, inscripcion.getAlumnoId());
            int fila = ps.executeUpdate();

            return fila > 0;
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return false;
    }

    // Método para actualizar una inscripción existente
    public boolean actualizar(Inscripcion inscripcion) throws SQLException {
        try {
            String sql = "UPDATE Inscripciones SET Fecha_Inscripción = ?, Curso_ID = ?, Alumno_ID = ? WHERE ID_Inscripción = ?";
            ps = cn.getConnection().prepareStatement(sql);
            ps.setDate(1, new java.sql.Date(inscripcion.getFechaInscripcion().getTime()));
            ps.setInt(2, inscripcion.getCursoId());
            ps.setInt(3, inscripcion.getAlumnoId());
            ps.setInt(4, inscripcion.getIdInscripcion());
            int fila = ps.executeUpdate();

            return fila > 0;
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return false;
    }

    // Método para eliminar una inscripción
    public boolean eliminar(int idInscripcion) throws SQLException {
        try {
            String sql = "DELETE FROM Inscripciones WHERE ID_Inscripción = ?";
            ps = cn.getConnection().prepareStatement(sql);
            ps.setInt(1, idInscripcion);
            int fila = ps.executeUpdate();

            return fila > 0;
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return false;
    }
}

