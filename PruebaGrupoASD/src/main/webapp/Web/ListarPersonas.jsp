<%-- 
    Document   : index
    Created on : 18/12/2017, 09:35:16 PM
    Author     : Santiago
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="Secciones/Head.jsp" />

        <h2>Módulo para listar empleados.</h2>
        
        <table id="empleados" class="table table-striped" cellspacing="0" width="100%">
            <thead>
                <tr>
                    <th>Cedula</th>
                    <th>Nombre</th>
                    <th>Apellido</th>
                    <th>Fecha de Nacimiento</th>                    
                    <th>Ciudad</th>
                    <th>Area</th>
                    <th>Cargo</th>                    
                </tr>
            </thead>
            <tbody id="empleadosBody">
            </tbody>
        </table>
        
        <input class="btn btn-success" type="button" onclick="listarPersonas()" value = "Listar Personas" />
    
                

        
<jsp:include page="Secciones/Footer.jsp" />
<script>
    
    function listarPersonas(){        
        $.ajax({
            type: 'GET',
            url: '${pageContext.request.contextPath}/rest/personal',
            dataType: "json", 
            success: function(empleados){
                console.log(empleados);
                $("#empleadosBody").empty();
                for(var empleado in empleados){
                    $("#empleadosBody").append(obtenerFila(empleados[empleado]));
                }
            },
            error: function(textStatus){
                console.log(textStatus);
                
            }
        });
    }
    
    function obtenerFila(empleado){
        return "<tr>\
                <td>" + empleado.cedula + "</td>\
                <td>" + empleado.nombre + "</td>\
                <td>" + empleado.apellido + "</td>\
                <td>" + empleado.fechaNacimiento + "</td>\
                <td>" + empleado.idArea+ "</td>\
                <td>" + empleado.idCiudad+ "</td>\
                <td>" + empleado.cargo + "</td></tr>"                
            
    }
</script>
    


