/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.grupoasd.prueba.dao;

import com.grupoasd.prueba.conexion.Conexion;
import com.grupoasd.prueba.modelo.TipoActivoFijo;
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
public class TipoActivoFijoDAO extends AbstractDAO{

    
    public List<TipoActivoFijo> getTipos(){
        List<TipoActivoFijo> tipos = new ArrayList();        
        String consulta = "SELECT * FROM TIPOACTIVOFIJO";
        
        try {
            this.connection = Conexion.getConexion();
            this.statement = connection.createStatement();
            this.resultSet = statement.executeQuery(consulta);
            
            while(resultSet.next()){
                tipos.add((TipoActivoFijo)getEntityByResultSet(resultSet));
            }
        } catch (SQLException ex) {
            System.out.println("No se pudo realizar la consulta: "+ex.getMessage());
            return null;
        }   
        
        if(!tipos.isEmpty()){
            return tipos;
        }else{
            return null;
        }
    }
    
    @Override
    public Object getEntityByResultSet(ResultSet resultSet) throws SQLException {
        TipoActivoFijo tipo = new TipoActivoFijo();
        tipo.setTipoActivoFijo(resultSet.getInt("IDTIPOACTIVOFIJO"));
        tipo.setNombreTipo(resultSet.getString("NOMBRETIPO"));
        return tipo;
    }
    
}
