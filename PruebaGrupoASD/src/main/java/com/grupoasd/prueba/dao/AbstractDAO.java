package com.grupoasd.prueba.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import com.grupoasd.prueba.conexion.Conexion;
import java.sql.SQLException;

public abstract class AbstractDAO {

    protected Statement statement;
    protected ResultSet resultSet;
    protected Connection connection;
    
    public AbstractDAO(){
        connection = Conexion.getConexion();
    }
    abstract public Object getEntityByResultSet(ResultSet resultSet) throws SQLException;
}
