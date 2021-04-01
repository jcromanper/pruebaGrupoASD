<%@page import="com.grupoasd.prueba.modelo.Estado"%>
<%@page import="com.grupoasd.prueba.dao.EstadoDAO"%>
<%@page import="com.grupoasd.prueba.modelo.Empleado"%>
<%@page import="com.grupoasd.prueba.dao.EmpleadoDAO"%>
<%@page import="com.grupoasd.prueba.modelo.Area"%>
<%@page import="com.grupoasd.prueba.dao.AreaDAO"%>
<%@page import="com.grupoasd.prueba.modelo.TipoActivoFijo"%>
<%@page import="java.util.List"%>
<%@page import="com.grupoasd.prueba.dao.TipoActivoFijoDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="Secciones/Head.jsp" />

<%
    TipoActivoFijoDAO tipoDAO = new TipoActivoFijoDAO();
    List<TipoActivoFijo> tipos = tipoDAO.getTipos();

    AreaDAO areaDAO = new AreaDAO();
    List<Area> areas = areaDAO.getAreas();

    EmpleadoDAO empleadoDAO = new EmpleadoDAO();
    List<Empleado> empleados = empleadoDAO.getEmpleados();

    EstadoDAO estadoDAO = new EstadoDAO();
    List<Estado> estados = estadoDAO.getEstados();

%>

<h2>Módulo para actualizar activos fijos</h2>

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


<!-- Modal Actualizar-->
<div class="modal fade" id="myModalActualizar" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Actualizar Activo Fijo</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="formActualizar">

                    <div class="form-group">
                        <label for="emplado">Empleado Asignar:</label>
                        <select name="empleado" class="form-control" id="empleado">
                            <option value='null'>Seleccione un empleado</option>
                            <%  for (Empleado empleado : empleados) {
                                    out.print("<option value='" + empleado.getCedula() + "'>" + empleado.getNombre() + " " + empleado.getApellido() + "</option>");
                                }
                            %> 
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="area">Area asignar:</label>
                        <select name="area" class="form-control" id="area">
                            <option value='null null'>Seleccione un área</option>
                            <%  for (Area area : areas) {
                                    out.print("<option value='" + area.getIdArea() + " " + area.getIdCiudad() + "'>Area: " + area.getNombreArea() + "  -  Ciudad: " + area.getNombreCiudad() + "</option>");
                                }
                            %> 
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="estado">Estado Activo:</label>
                        <select name="estado" class="form-control" id="estado">
                            <option value='null'>Seleccione un estado</option>
                            <%                    for (Estado estado : estados) {
                                    out.print("<option value='" + estado.getIdEstado() + "'>" + estado.getNombreEstado() + "</option>");
                                }
                            %> 
                        </select>
                    </div>

                </form>



            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                <input class="btn btn-primary" type="button" onclick="actualizarActivo()" value = "Actualizar Activo" />
            </div>
        </div>
    </div>
</div>



<script>

    var activoAc;
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
                <td><button type='button' class='btn btn-primary' data-toggle='modal' data-target='#myModalActualizar' onclick = 'actualizar(" + JSON.stringify(activo) + ")'>Actualizar</button></td>\
                <td><button type='button' class='btn btn-primary' data-toggle='modal' data-target='#myModalDetalles' onclick = 'buscarDetalles(" + JSON.stringify(activo) + ")'>Detalles</button></td></tr>";

    }

    function buscarDetalles(activo) {
        console.log("Buscar Detalles");
        $.ajax({
            type: 'GET',
            url: '${pageContext.request.contextPath}/rest/activo/buscar/detalles/' + activo.serial + '/' + activo.numInterno,
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

    function obtenerCabeceraDetalles(cabeceras) {
        var text = "<tr>";
        for (var cabecera in cabeceras) {
            text += "<th>" + cabeceras[cabecera] + "</th>";
        }
        text += "</tr>";
        return text;
    }
    function obtenerCuerpoDetalles(detalles) {
        var text = "<tr>";

        for (var detalle in detalles) {
            text += "<td>" + detalles[detalle] + "</td>";
        }
        text += "</tr>";
        return text;

    }

    function actualizar(activo) {
        this.activoAc = activo;
        console.log(activo);
    }

    function actualizarActivo() {
        console.log("Actualizando Activo");
        if (datos() != 0) {
            console.log(datos());
            $.ajax({
                type: 'PUT',
                url: '${pageContext.request.contextPath}/rest/activo/actualizar/activo',
                data: JSON.stringify(datos()),
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json'
                },
                success: function (response) {
                    if (response !== 'undefined') {
                        alert("Activo ACTUALIZADO");
                    }
                },
                error: function (textStatus) {
                    console.log(textStatus);

                }
            });
        }
    }

    function datos() {
    
        if ($('#estado').val() == 'null') {
            alert("Debe seleccionar un estado para el activo");
            return 0;
        }   
        
        var ids = $('#area').val().split(" ");
        return {
            numInterno: activoAc.numInterno,
            serial: activoAc.serial,
            empleado: $('#empleado').val(),
            estado: $('#estado').val(),
            area: ids[0],
            ciudad: ids[1],
        };
    }




</script>


<jsp:include page="Secciones/Footer.jsp" />

