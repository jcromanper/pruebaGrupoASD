/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.grupoasd.prueba.conexion;

import java.sql.Connection;
import java.sql.DriverManager;
/**
 *
 * @author Santiago Collazos
 */
public class Conexion {

    private static Connection connection = null;
    private static final String urlbd = "jdbc:mysql://localhost:3306/pruebaASD";
    private static final String user = "grupoASD";
    private static final String password = "PWgrupoASD";

    public static Connection getConexion(){
        if (connection == null) {
            conectar();
        }
        return connection;
    }

    public static void desconectar() {
        connection = null;
    }

    private static void conectar() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(urlbd, user, password);
            if (connection != null) {
                System.out.println("Conexion exitosa a esquema " + user);
            } else {
                System.out.println("Conexion fallida");
            }
        } catch (Exception e) {
            connection = null;
            System.out.println("Error: "+e.getMessage());
        }
    }
}
