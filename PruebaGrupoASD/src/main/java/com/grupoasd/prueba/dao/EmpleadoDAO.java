/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.grupoasd.prueba.dao;

import com.grupoasd.prueba.conexion.Conexion;
import com.grupoasd.prueba.modelo.Empleado;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class EmpleadoDAO extends AbstractDAO{

    public List<Empleado> getEmpleados(){
        List<Empleado> empleados = new ArrayList();

        String consulta = "SELECT e.cedula CEDULA , e.nombre NOMBRE, e.apellido APELLIDO ,e.fechanacimiento FECHANACIMIENTO,e.cargo CARGO ,c.nombreCiudad CIUDAD, a.nombrearea AREA FROM EMPLEADO e, CIUDAD c, Area a  WHERE c.idCiudad = e.IDCIUDAD AND a.IDAREA = e.IDAREA AND c.IDCIUDAD = a.IDCIUDAD";

        try {
            this.connection = Conexion.getConexion();
            this.statement = connection.createStatement();
            this.resultSet = statement.executeQuery(consulta);
                       

            while (resultSet.next()){
                empleados.add((Empleado) this.getEntityByResultSet(resultSet));
            }
            statement.close();
        } catch (SQLException ex) {
            System.out.println("No se pudo realizar la consulta: "+ex.getMessage());
            return null;
        } finally {
            Conexion.desconectar();
        }

        if (!empleados.isEmpty()) {
            return empleados;
        } else {
            return null;
        } 
    }
    
    @Override
    public Object getEntityByResultSet(ResultSet resultSet) throws SQLException {
        Empleado e = new Empleado();
        e.setCedula(String.valueOf(resultSet.getInt("CEDULA")));
        e.setNombre(resultSet.getString("NOMBRE"));
        e.setApellido(resultSet.getString("APELLIDO"));
        e.setIdArea(resultSet.getString("AREA"));
        e.setIdCiudad(resultSet.getString("CIUDAD"));
        e.setCargo(resultSet.getString("CARGO"));
        e.setFechaNacimiento(resultSet.getDate("FECHANACIMIENTO"));
        
        return e;
    }
    
}
