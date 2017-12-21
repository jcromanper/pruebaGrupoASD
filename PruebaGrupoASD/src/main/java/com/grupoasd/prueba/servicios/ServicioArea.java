/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.grupoasd.prueba.servicios;

import com.grupoasd.prueba.dao.AreaDAO;
import com.grupoasd.prueba.modelo.Area;
import java.util.List;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
/**
 *
 * @author Santiago
 */
@Path("areas")
public class ServicioArea {
    AreaDAO areaDAO = new AreaDAO();    
    
    @GET
    @Produces({MediaType.APPLICATION_JSON})
    public Object getAreas(){
       System.out.println("GET Areas");
       List<Area> areas = areaDAO.getAreas();
        
        if(areas != null)
            return Response.ok(areas).build();
        else
            return Response.status(Response.Status.NOT_FOUND);
    }
}
