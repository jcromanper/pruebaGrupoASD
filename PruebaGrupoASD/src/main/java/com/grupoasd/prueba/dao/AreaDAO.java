/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.grupoasd.prueba.dao;

import com.grupoasd.prueba.conexion.Conexion;
import com.grupoasd.prueba.modelo.Area;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Santiago
 */
public class AreaDAO extends AbstractDAO{

    public List<Area> getAreas(){
        List<Area> areas = new ArrayList();
        String consulta = "SELECT a.idarea IDAREA, a.nombrearea NOMBREAREA, c.nombreciudad NOMBRECIUDAD, a.idCiudad IDCIUDAD FROM AREA a, CIUDAD c WHERE c.idciudad = a.idciudad";
        try {
            this.connection = Conexion.getConexion();
            this.statement = connection.createStatement();
            this.resultSet = statement.executeQuery(consulta);                       

            while (resultSet.next()){
                areas.add((Area) this.getEntityByResultSet(resultSet));
            }
            statement.close();
        } catch (SQLException ex) {
            System.out.println("No se pudo realizar la consulta: "+ex.getMessage());
            return null;
        } finally {
            Conexion.desconectar();
        }

        if (!areas.isEmpty()) {
            return areas;
        } else {
            return null;
        } 
        
    }
    
    @Override
    public Object getEntityByResultSet(ResultSet resultSet) throws SQLException {
        Area area = new Area();
        
        area.setIdArea(resultSet.getInt("IDAREA"));
        area.setNombreArea(resultSet.getString("NOMBREAREA"));
        area.setNombreCiudad(resultSet.getString("NOMBRECIUDAD"));
        area.setIdCiudad(resultSet.getInt("IDCIUDAD"));
        
        return area;
    }
    
}
