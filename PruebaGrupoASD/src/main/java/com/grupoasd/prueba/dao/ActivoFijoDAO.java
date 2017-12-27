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

/**
 *
 * @author Santiago
 */
public class ActivoFijoDAO extends AbstractDAO {

    public int crearActivo(ActivoFijo activo, ArrayList<String> caracteristica) {

        String insert = "INSERT INTO ACTIVOFIJO (NUMINTERNOINVENTARIO,SERIAL,IDTIPOACTIVOFIJO,IDESTADO,NOMBREACTIVO,FECHACOMPRA,VALOR,DESCRIPCION) VALUES (" + activo.getNumInterno() + ",'" + activo.getSerial() + "',"+activo.getIdTipo()+","+activo.getEstado()+",'"+activo.getNombre()+"',STR_TO_DATE('"+activo.getDate()+"','%Y-%m-%d'),"+activo.getValor()+",'"+activo.getDescripcion()+"')";        
        int r;
        System.out.println(insert);
        try {
            
            this.connection = Conexion.getConexion();
            this.statement = connection.createStatement();
            r = this.statement.executeUpdate(insert);
            
            if(r == 1){
                int contTipoC = 1;
                for (String car : caracteristica) {
                    insert = "INSERT INTO CARACTERISTICA (IDCARACTERISTICA,DETALLECARACTERISTICA) VALUES (null,'"+car+"')";
                    this.statement.executeUpdate(insert);
                    insert = "INSERT INTO ACTIVOFIJO_CARACTERISTICA(IDTIPOCARACTERISTICA,IDCARACTERISTICA,NUMINTERNOINVENTARIO,SERIAL) VALUES ("+contTipoC+",(SELECT IDCARACTERISTICA FROM CARACTERISTICA ORDER BY IDCARACTERISTICA DESC LIMIT 1),"+activo.getNumInterno()+",'"+activo.getSerial()+"')";
                    this.statement.executeUpdate(insert);
                    contTipoC++;                    
                }                
            }

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
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}

/*;*/
