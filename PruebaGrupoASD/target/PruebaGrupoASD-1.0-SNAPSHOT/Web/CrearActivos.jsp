<%-- 
    Document   : CrearActivos
    Created on : 21/12/2017, 06:18:31 PM
    Author     : Santiago
--%>

<%@page import="java.util.List"%>
<%@page import="com.grupoasd.prueba.modelo.TipoActivoFijo"%>
<%@page import="com.grupoasd.prueba.dao.TipoActivoFijoDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include  page="Secciones/Head.jsp"/>

<h2>Módulo para crear Activos Fijos</h2>

<%
    TipoActivoFijoDAO tipoDAO = new TipoActivoFijoDAO();
    List<TipoActivoFijo> tipos = tipoDAO.getTipos();


%>



<div class="container">
    <h2>Formulario</h2>    
    <form id="formActivo">
        <div id="ok"></div>
        <div class="form-group">
            <label for="numInventario">Número Interno Inventario:</label>
            <input type="number" name="numInventario" min="1" class="form-control" id="numInventario">
        </div>
        <div class="form-group">
            <label for="serial">Serial:</label>
            <input type="text" name="serial" class="form-control" id="serial">
        </div>

        <div class="form-group">
            <label for="nombre">Nombre Activo:</label>
            <input type="text" name="nombre" min="1" class="form-control" id="nombre">
        </div>

        <div class="form-group">
            <label for="tipo">Tipo Activo:</label>
            <select name="tipo" class="form-control" id="tipo">
                <%                    for (TipoActivoFijo tipo : tipos) {
                        out.print("<option value='" + tipo.getTipoActivoFijo() + "'>" + tipo.getNombreTipo() + "</option>");
                    }
                %> 
            </select>
        </div>

        <div class="form-group">
            <label for="date">Fecha de Compra:</label>
            <input size="16" type="date" name="date" id="date" class="form-control">
        </div>

        <div class="form-group">
            <label for="valor">Valor:</label>
            <input type="number" name="valor" min="1" class="form-control" id="valor">
        </div>

        <div class="form-group">
            <label for="descripcion">Descripción</label>
            <textarea style="overflow:auto;resize:none" name="descripcion" class="form-control" rows="5" id="descripcion"></textarea>
        </div>
        <input class="btn btn-success" type="button" onclick="crearActivo()" value = "Crear Activo" />   
    </form>
</div>
<jsp:include  page="Secciones/Footer.jsp"/>

<script>
    

    function crearActivo() {
        console.log(JSON.stringify(datos()));


        $.ajax({
            type: 'POST',
            url: '${pageContext.request.contextPath}/rest/activo/crear',
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            },
            data: JSON.stringify(datos()),
            success: function (response) {
                console.log(response);
            },
            error: function (textStatus) {
                console.log(textStatus);

            }
        });
        limpiarCampos();
    }

    function limpiarCampos() {
        $('#numInventario').val("");
        $('#serial').val("");
        $('#nombre').val("");
        $('#descripcion').val("");
        $('#valor').val("");
        $('#date').val("");
    }

    function datos() {

        return {
            numInterno: $('#numInventario').val(),
            serial: $('#serial').val(),
            nombre: $('#nombre').val(),
            descripcion: $('#descripcion').val(),
            valor: $('#valor').val(),
            fechaCompra: $('#date').val(),
            tipo: $('#tipo').val(),
            idEstado: 1,

        };
    }

</script>

