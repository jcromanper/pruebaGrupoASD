/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.grupoasd.prueba.servicios;

import com.grupoasd.prueba.dao.ActivoFijoDAO;
import com.grupoasd.prueba.modelo.ActivoFijo;
import java.util.List;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import org.json.JSONObject;
/**
 *
 * @author Santiago
 */
@Path("activo")
public class ServicioActivoFijo {
    
    ActivoFijoDAO activoDAO = new ActivoFijoDAO();
    
    @POST
    @Path("crear")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response crearActivo(String data){
        JSONObject jsonObj = new JSONObject(data);
        ActivoFijo activo = crearActivo(jsonObj);
        //System.out.println("Datos: "+jsonObj.getString("numInterno"));
        if(activoDAO.crearActivo(activo) == 1){
            return Response.status(Response.Status.CREATED).header("Creado", "El recurso ha sido creado").build();
        }
        return Response.status(Response.Status.BAD_REQUEST).header("Solicitud incorrecta", "El recurso no pudo ser creado").build();       
        
    }
    
    @GET
    @Consumes(MediaType.APPLICATION_JSON)
    public Object getActivos(){
        System.out.println("Get Activos");
        List<ActivoFijo> activos = activoDAO.getAllActivos();
        System.out.println("ActivoDAO: "+activos);
        
        if (activos != null)
            return Response.ok(activos).build();
        else
            return Response.status(Response.Status.NOT_FOUND);                
    }

    private ActivoFijo crearActivo(JSONObject jsonObj) {
        ActivoFijo activo = new ActivoFijo();
        activo.setNumInterno(jsonObj.getInt("numInterno"));
        activo.setSerial(jsonObj.getString("serial"));        
        activo.setNombre(jsonObj.getString("nombre"));
        activo.setDate(jsonObj.getString("fechaCompra"));
        System.out.println(jsonObj.getString("fechaCompra"));        
        activo.setValor(jsonObj.getDouble("valor"));
        activo.setDescripcion(jsonObj.getString("descripcion"));
        activo.setEstado(jsonObj.getInt("idEstado"));
        activo.setIdTipo(jsonObj.getInt("tipo"));
        return activo;
    }
    
}
