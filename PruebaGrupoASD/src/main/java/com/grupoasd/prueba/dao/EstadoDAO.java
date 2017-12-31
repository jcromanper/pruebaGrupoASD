/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.grupoasd.prueba.dao;

import com.grupoasd.prueba.conexion.Conexion;
import com.grupoasd.prueba.modelo.Estado;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Santiago
 */
public class EstadoDAO extends AbstractDAO{

    @Override
    public Object getEntityByResultSet(ResultSet resultSet) throws SQLException {
        Estado estado = new Estado();
        
        estado.setIdEstado(resultSet.getInt("IDESTADO"));
        estado.setNombreEstado(resultSet.getString("NOMBREESTADO"));
        
        return estado;
    }
    
    public List<Estado> getEstados(){
        
        List<Estado> estados = new ArrayList();        
        String consulta = "SELECT * FROM ESTADOACTUAL";
        try {
            this.connection = Conexion.getConexion();
            this.statement = connection.createStatement();
            this.resultSet = statement.executeQuery(consulta);
            
            while(resultSet.next()){
                estados.add((Estado) this.getEntityByResultSet(resultSet));
            }
        } catch (SQLException ex) {
            System.out.println("No se pudo realizar la consulta: "+ex.getMessage());
            return null;
        }        
        if(!estados.isEmpty()){
            return estados;
        }        
        return null;
    
    }
    
}
