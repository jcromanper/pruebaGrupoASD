/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.grupoasd.prueba.dao;

import com.grupoasd.prueba.conexion.Conexion;
import com.grupoasd.prueba.modelo.TipoCaracteristica;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class TipoCaracteristicaDAO extends AbstractDAO{

    @Override
    public Object getEntityByResultSet(ResultSet resultSet) throws SQLException {
        TipoCaracteristica tipoC = new TipoCaracteristica();
        tipoC.setIdTipoCaracteristica(resultSet.getInt("IDTIPOCARACTERISTICA"));
        tipoC.setNombreTipoCaracteristica(resultSet.getString("NOMBRETIPOCARACTERISTICA"));
        
        return tipoC;
    }
    
    public List<TipoCaracteristica> getAll(){
        List <TipoCaracteristica> tipoCaracteristicas = new ArrayList();
        
        String consulta = "SELECT * FROM TIPOCARACTERISTICA";
        
        
        try {
            this.connection = Conexion.getConexion();
            this.statement = connection.createStatement();
            this.resultSet = statement.executeQuery(consulta);
            
            while(resultSet.next()){
                tipoCaracteristicas.add((TipoCaracteristica) getEntityByResultSet(resultSet));
            }
        } catch (SQLException ex) {
            System.out.println("No se pudo realizar la consulta: "+ex.getMessage());
            return null;            
        }
                
        if(!tipoCaracteristicas.isEmpty()){
            return tipoCaracteristicas;
        }
        return null;
    }
    
}
