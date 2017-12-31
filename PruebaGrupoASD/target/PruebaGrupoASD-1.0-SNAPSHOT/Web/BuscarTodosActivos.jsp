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
            <th>Acciones</th>
        </tr>
    </thead>
    <tbody id="activoBody">
    </tbody>
</table>

<input class="btn btn-success" type="button" onclick="listarActivos()" value = "Listar Activos" />

<!-- Modal Detalles-->
<div class="modal fade" id="myModalDetalles" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Detalles Activo Fijo</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">

                <table id="detallesActivo" class="table table-striped" cellspacing="0" width="100%">
                    <thead id="detallesHead">
                        
                    </thead>
                    <tbody id="detallesBody">
                        
                    </tbody>
                </table>


            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>
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
                <td>" + activo.area + "</td>\
                <td>" + activo.ciudad + "</td>\
                <td>" + activo.descripcion + "</td>\
                <td>" + activo.valor + "</td>\
                <td>" + activo.date + "</td>\
                <td>" + activo.dateBaja + "</td>\
                <td>" + activo.idTipo + "</td>\
                <td>" + activo.estado + "</td>\
                <td><button type='button' class='btn btn-primary' data-toggle='modal' data-target='#myModalDetalles' onclick = 'buscarDetalles(" + JSON.stringify(activo) + ")'>Detalles</button></td></tr>";

    }
    
    function buscarDetalles(activo) {
        console.log("Buscar Detalles");
        $.ajax({
            type: 'GET',
            url: '${pageContext.request.contextPath}/rest/activo/buscar/detalles/' + activo.serial+'/'+activo.numInterno,
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            },
            success: function (detalles) {
                console.log(detalles);
                $('#detallesHead').empty();
                $('#detallesBody').empty();
                
                $('#detallesHead').append(obtenerCabeceraDetalles(Object.keys(detalles)));
                $('#detallesBody').append(obtenerCuerpoDetalles(detalles));
                
            },
            error: function (textStatus) {
                console.log(textStatus);

            }
        });
    }
    
    function obtenerCabeceraDetalles(cabeceras){
        var text = "<tr>";
        for (var cabecera in cabeceras) {
            text +="<th>"+cabeceras[cabecera]+"</th>";
        }
        text+="</tr>";        
        return text;
    }
    function obtenerCuerpoDetalles(detalles){
        var text = "<tr>";
        
        for (var detalle in detalles) {
            text +="<td>"+detalles[detalle]+"</td>";
        }
        text+="</tr>";        
        return text;
        
    }
    

    
</script>