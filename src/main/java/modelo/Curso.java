/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

import java.sql.Date;

/**
 *
 * @author Owner
 */
public class Curso {
    private int idCurso;
    private String nombreCurso;
    private int duracion; // Duración en horas
    private double costoCurso;
    private Date fechaInscripcion;

    public Curso() {
    }

    
    public Curso(String nombreCurso, int duracion, double costoCurso) {
        this.nombreCurso = nombreCurso;
        this.duracion = duracion;
        this.costoCurso = costoCurso;
    }
    
    

    public Curso(int idCurso, String nombreCurso, int duracion, double costoCurso) {
        this.idCurso = idCurso;
        this.nombreCurso = nombreCurso;
        this.duracion = duracion;
        this.costoCurso = costoCurso;
    }

    // Getters y Setters
    public int getIdCurso() {
        return idCurso;
    }

    public void setIdCurso(int idCurso) {
        this.idCurso = idCurso;
    }

    public String getNombreCurso() {
        return nombreCurso;
    }

    public void setNombreCurso(String nombreCurso) {
        this.nombreCurso = nombreCurso;
    }

    public int getDuracion() {
        return duracion;
    }

    public void setDuracion(int duracion) {
        this.duracion = duracion;
    }

    public double getCostoCurso() {
        return costoCurso;
    }

    public void setCostoCurso(double costoCurso) {
        this.costoCurso = costoCurso;
    }

      public Date getFechaInscripcion() {
        return fechaInscripcion;
    }

    public void setFechaInscripcion(Date fechaInscripcion) {
        this.fechaInscripcion = fechaInscripcion;
    }
}