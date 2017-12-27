<%-- 
    Document   : BuscarTodosActivos
    Created on : 23/12/2017, 07:32:52 PM
    Author     : Santiago
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="Secciones/Head.jsp"  />

<h2>Módulo para listar activos.</h2>

<table id="activo" class="table table-striped" cellspacing="0" width="100%">
    <thead>
        <tr>
            <th>Número Interno</th>
            <th>Serial</th>
            <th>Nombre</th>
            <th>Cédula</th>
            <!--<th>Empleado</th>-->
            <th>Area</th>
            <th>Ciudad</th>            
            <th>Descripcion</th>
            <th>Valor</th>
            <th>Fecha Compra</th>
            <th>Fecha Baja</th>
            <th>Tipo</th>
            <th>Estado</th>     
        </tr>
    </thead>
    <tbody id="activoBody">
    </tbody>
</table>

<input class="btn btn-success" type="button" onclick="listarActivos()" value = "Listar Activos" />
<jsp:include page="Secciones/Footer.jsp"  />


<script>

    function listarActivos() {
        $.ajax({
            type: 'GET',
            url: '${pageContext.request.contextPath}/rest/activo',
            dataType: "json",
            success: function (activos) {
                console.log(activos);
                $("#activoBody").empty();
                for (var activo in activos) {
                    $("#activoBody").append(obtenerFila(activos[activo]));
                }
            },
            error: function (textStatus) {
                console.log(textStatus);

            }
        });
    }

    function obtenerFila(activo) {
        return "<tr>\
                <td>" + activo.numInterno + "</td>\
                <td>" + activo.serial + "</td>\
                <td>" + activo.nombre + "</td>\
                <td>" + activo.cedula + "</td>\
                <td>" + activo.cedula + "</td>\
                <td>" + activo.cedula + "</td>\
                <td>" + activo.descripcion + "</td>\
                <td>" + activo.valor + "</td>\
                <td>" + activo.date + "</td>\
                <td>" + activo.dateBaja + "</td>\
                <td>" + activo.idTipo + "</td>\
                <td>" + activo.estado + "</td>\</tr>"

    }
    

    
</script>