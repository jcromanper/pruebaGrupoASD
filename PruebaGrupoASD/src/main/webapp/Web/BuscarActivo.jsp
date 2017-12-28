<%-- 
    Document   : BuscarActivo
    Created on : 25/12/2017, 01:49:20 PM
    Author     : Santiago
--%>
<%@page import="com.grupoasd.prueba.modelo.TipoActivoFijo"%>
<%@page import="java.util.List"%>
<%@page import="com.grupoasd.prueba.dao.TipoActivoFijoDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="Secciones/Head.jsp"/>
<script>

    var activoA = {};
    var detalles = {};

    function buscarTipo() {
        var tipo = $('#tipo').val()

        $.ajax({
            type: 'GET',
            url: '${pageContext.request.contextPath}/rest/activo/buscar/tipo/' + tipo,
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            },
            success: function (activos) {
                console.log(activos);
                $("#activoTipoBody").empty();
                for (var activo in activos) {
                    $("#activoTipoBody").append(obtenerFila(activos[activo]));
                }
            },
            error: function (textStatus) {
                console.log(textStatus);

            }
        });
    }

    function buscarFecha() {
        var fecha = $('#date').val();

        $.ajax({
            type: 'GET',
            url: '${pageContext.request.contextPath}/rest/activo/buscar/fecha/' + fecha,
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            },
            success: function (activos) {
                console.log(activos);
                $("#activoFechaBody").empty();
                for (var activo in activos) {
                    $("#activoFechaBody").append(obtenerFila(activos[activo]));
                }
            },
            error: function (textStatus) {
                console.log(textStatus);

            }
        });
        $('#date').val("");
    }

    function buscarSerial() {
        var serial = $('#serial').val();
        $.ajax({
            type: 'GET',
            url: '${pageContext.request.contextPath}/rest/activo/buscar/serial/' + serial,
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            },
            success: function (activos) {
                console.log(activos);
                $("#activoSerialBody").empty();
                for (var activo in activos) {
                    $("#activoSerialBody").append(obtenerFila(activos[activo]));
                }
            },
            error: function (textStatus) {
                console.log(textStatus);

            }
        });
        $('#serial').val("")
    }

    function fijarActivo(a) {
        //console.log("Activo: " + a);
        this.activoA = a;
        //console.log(activoA.serial);
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

    function actualizarSerial() {
        var serial = $('#serialAct').val();
//        console.log("Actualizar Serial: " + serial);

        $.ajax({
            type: 'PUT',
            url: '${pageContext.request.contextPath}/rest/activo/actualizar/serial/' + serial,
            data: JSON.stringify(serial),
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            },
            success: function (activos) {
                console.log(activos);

            },
            error: function (textStatus) {
                console.log(textStatus);

            }
        });

        $('#serialAct').val("");
    }

    function actualizarFecha() {
        var dateBaja = $('#dateBaja').val();
        console.log("Actualizar Fecha: " + dateBaja);

        $.ajax({
            type: 'PUT',
            url: '${pageContext.request.contextPath}/rest/activo/actualizar/fechaBaja/' + dateBaja,
            data: JSON.stringify(dateBaja),
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            },
            success: function (activos) {
                console.log(activos);

            },
            error: function (textStatus) {
                console.log(textStatus);

            }
        });

        $('#dateBaja').val("");

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
                <td>" + activo.estado + "</td>\
                <td><button type='button' class='btn btn-primary' data-toggle='modal' data-target='#myModalSerial' onclick = 'fijarActivo(" + JSON.stringify(activo) + ")'>Serial</button></td>\\n\
                <td><button type='button' class='btn btn-primary' data-toggle='modal' data-target='#myModalFecha' onclick = 'fijarActivo(" + JSON.stringify(activo) + ")'>Fecha</button></td>\
                <td><button type='button' class='btn btn-primary' data-toggle='modal' data-target='#myModalDetalles' onclick = 'buscarDetalles(" + JSON.stringify(activo) + ")'>Detalles</button></td></tr>"

    }




</script>

<%
    TipoActivoFijoDAO tipoDAO = new TipoActivoFijoDAO();
    List<TipoActivoFijo> tipos = tipoDAO.getTipos();
%>

<h2>Módulo para buscar activos por tipo, fecha o serial</h2>



<div class="container">
    <h4>Buscar por tipo</h4>
    <form>
        <div class="form-group">
            <label for="tipo">Tipo Activo:</label>
            <select name="tipo" class="form-control" id="tipo">
                <%                    for (TipoActivoFijo tipo : tipos) {
                        out.print("<option value='" + tipo.getTipoActivoFijo() + "'>" + tipo.getNombreTipo() + "</option>");
                    }
                %> 
            </select>
        </div>
        <center>
            <input class="btn btn-success" type="button" onclick="buscarTipo()" value = "Buscar por Tipo" />
        </center>


    </form>

    <table id="activoTipo" class="table table-striped" cellspacing="0" width="100%">
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
        <tbody id="activoTipoBody">
        </tbody>
    </table>
    <br>
    <br>

    <hr>
</div>







<div class="container">
    <h4>Buscar por fecha</h4>

    <form>
        <div class="form-group">
            <label for="date">Fecha de Compra:</label>
            <input size="16" type="date" name="date" id="date" class="form-control">
        </div>

        <center>
            <input class="btn btn-success" type="button" onclick="buscarFecha()" value = "Buscar por fecha" />

        </center>
    </form>

    <table id="activoFecha" class="table table-striped" cellspacing="0" width="100%">
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
        <tbody id="activoFechaBody">
        </tbody>
    </table>
    <br>
    <br>

    <hr>


</div>

<div class="container">
    <h4>Buscar por serial</h4>

    <form>
        <div class="form-group">
            <label for="serial">Serial:</label>
            <input type="text" name="serial" class="form-control" id="serial">
        </div>
        <center>
            <input class="btn btn-success" type="button" onclick="buscarSerial()" value = "Buscar por Serial" />

        </center>
    </form>

    <table id="activoSerial" class="table table-striped" cellspacing="0" width="100%">
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
        <tbody id="activoSerialBody">
        </tbody>
    </table>
    <br>
    <br>


    <hr> 
</div>
<!-- Modal Serial-->
<div class="modal fade" id="myModalSerial" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Modificar Serial Activo</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">

                <form>
                    <div class="form-group">
                        <label for="serial">Serial:</label>
                        <input type="text" name="serial" class="form-control" id="serialAct" placeholder="Ingrese nuevo serial">
                    </div>
                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                <input class="btn btn-primary" type="button" onclick="actualizarSerial()" value = "Actualizar Serial" />
            </div>
        </div>
    </div>
</div>            


<!-- Modal Fecha-->
<div class="modal fade" id="myModalFecha" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Modificar Fecha Baja Activo</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">

                <form>
                    <div class="form-group">
                        <label for="date">Fecha de Baja</label>
                        <input size="16" type="date" name="date" id="dateBaja" class="form-control">
                    </div>


                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>

                <input class="btn btn-primary" type="button" onclick="actualizarFecha()" value = "Actualizar fecha" />

            </div>
        </div>
    </div>
</div> 

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

<jsp:include page="Secciones/Footer.jsp"/>

