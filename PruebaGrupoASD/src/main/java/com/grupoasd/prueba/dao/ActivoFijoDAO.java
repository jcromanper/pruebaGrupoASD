/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.grupoasd.prueba.dao;

import com.grupoasd.prueba.conexion.Conexion;
import com.grupoasd.prueba.modelo.ActivoFijo;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Santiago
 */
public class ActivoFijoDAO extends AbstractDAO {

    public int crearActivo(ActivoFijo activo) {

        String insert = "INSERT INTO ACTIVOFIJO (NUMINTERNOINVENTARIO,SERIAL,IDTIPOACTIVOFIJO,IDESTADO,NOMBREACTIVO,FECHACOMPRA,VALOR,DESCRIPCION) VALUES (" + activo.getNumInterno() + ",'" + activo.getSerial() + "',"+activo.getIdTipo()+","+activo.getEstado()+",'"+activo.getNombre()+"',STR_TO_DATE('"+activo.getDate()+"','%Y-%m-%d'),"+activo.getValor()+",'"+activo.getDescripcion()+"')";        
        int r;
        System.out.println(insert);
        try {
            
            this.connection = Conexion.getConexion();
            this.statement = connection.createStatement();
            r = this.statement.executeUpdate(insert);

            statement.close();

        } catch (SQLException ex) {
            System.out.println("No se pudo realizar la consulta: " + ex.getMessage());
            return 0;
        } finally {
            Conexion.desconectar();
        }
        return r;
    }

    @Override
    public Object getEntityByResultSet(ResultSet resultSet) throws SQLException {
        ActivoFijo activo = new ActivoFijo();
        
        activo.setNumInterno(resultSet.getInt("NUMINTERNOINVENTARIO"));
        activo.setSerial(resultSet.getString("SERIAL"));
        activo.setIdTipo(resultSet.getInt("IDTIPOACTIVOFIJO"));        
        activo.setEstado(resultSet.getInt("IDESTADO"));  
        activo.setCedula(resultSet.getString("CEDULA"));
        //activo.setEmpleadoAsignado(resultSet.getString("NOMBREEMPLEADO"));
        //activo.setArea(resultSet.getString("NOMBREAREA"));
        //activo.setCiudad(resultSet.getString("NOMBRECIUDAD"));
        activo.setNombre(resultSet.getString("NOMBREACTIVO"));
        activo.setDate(resultSet.getString("FECHACOMPRA"));
        activo.setDateBaja(resultSet.getString("FECHABAJA"));        
        activo.setValor(resultSet.getDouble("VALOR"));
        activo.setDescripcion(resultSet.getString("DESCRIPCION"));
        
        
        return activo;
    }
    
    public List<ActivoFijo> getActivosByTipo(String tipo){
        List<ActivoFijo> activos = new ArrayList();
        
        String consulta = "SELECT * FROM ACTIVOFIJO WHERE IDTIPOACTIVOFIJO="+tipo;
        
        try {
            this.connection = Conexion.getConexion();
            this.statement = connection.createStatement();
            this.resultSet = statement.executeQuery(consulta);
            
            while(resultSet.next()){
                activos.add((ActivoFijo) getEntityByResultSet(resultSet));
            }
        } catch (SQLException ex) {
            System.out.println("No se pudo realizar la consulta: " + ex.getMessage());
            return null;
        }
        
         if(!activos.isEmpty()){
            return activos;
        }
        return null;
        
    }
    public List<ActivoFijo> getActivosByFecha(String fecha){
        List<ActivoFijo> activos = new ArrayList();
        
        String consulta = "SELECT * FROM ACTIVOFIJO WHERE FECHACOMPRA='"+fecha+"'";
        
        try {
            this.connection = Conexion.getConexion();
            this.statement = connection.createStatement();
            this.resultSet = statement.executeQuery(consulta);
            
            while(resultSet.next()){
                activos.add((ActivoFijo) getEntityByResultSet(resultSet));
            }
        } catch (SQLException ex) {
            System.out.println("No se pudo realizar la consulta: " + ex.getMessage());
            return null;
        }
        
         if(!activos.isEmpty()){
            return activos;
        }
        return null;
        
    }
    public List<ActivoFijo> getActivosBySerial(String serial){
        List<ActivoFijo> activos = new ArrayList();
        
        String consulta = "SELECT * FROM ACTIVOFIJO WHERE SERIAL='"+serial+"'";
        
        try {
            this.connection = Conexion.getConexion();
            this.statement = connection.createStatement();
            this.resultSet = statement.executeQuery(consulta);
            
            while(resultSet.next()){
                activos.add((ActivoFijo) getEntityByResultSet(resultSet));
            }
        } catch (SQLException ex) {
            System.out.println("No se pudo realizar la consulta: " + ex.getMessage());
            return null;
        }
        
        
         if(!activos.isEmpty()){
            return activos;
        }
        return null;
        
    }

    public List<ActivoFijo> getAllActivos() {
        List<ActivoFijo> activos = new ArrayList();
        
        String consulta = "SELECT * FROM ACTIVOFIJO";
        try {
            this.connection = Conexion.getConexion();
            this.statement = connection.createStatement();
            this.resultSet = statement.executeQuery(consulta);
            
            while(resultSet.next()){
                activos.add((ActivoFijo) getEntityByResultSet(resultSet));
            }
        } catch (SQLException ex) {
            System.out.println("No se pudo realizar la consulta: " + ex.getMessage());
            return null;
        }
        
        if(!activos.isEmpty()){
            return activos;
        }
        return null;
    }

}
