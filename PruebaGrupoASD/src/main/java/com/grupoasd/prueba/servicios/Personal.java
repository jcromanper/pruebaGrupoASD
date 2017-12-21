/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.grupoasd.prueba.servicios;

import com.grupoasd.prueba.dao.EmpleadoDAO;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

/**
 *
 * @author Santiago
 */
@Path("personal")
public class Personal {
    
    EmpleadoDAO empleadoDAO = new EmpleadoDAO();
    
    @GET    
    @Produces({MediaType.APPLICATION_JSON})
    public Response getPersonal(){
        System.out.println("GET Personal");
        return Response.ok(empleadoDAO.getEmpleados()).build();
    }
}
