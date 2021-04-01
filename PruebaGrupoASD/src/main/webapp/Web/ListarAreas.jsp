
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="Secciones/Head.jsp" />
    <h2>Listar areas.</h2>
        
        <table id="area" class="table table-striped" cellspacing="0" width="100%">
            <thead>
                <tr>
                    <th>ID Área</th>
                    <th>Nombre Área</th>
                    <th>Nombre Ciudad</th>
                    
                </tr>
            </thead>
            <tbody id="areasBody">
            </tbody>
        </table>

     <input class="btn btn-success" type="button" onclick="listarAreas()" value = "Listar Areas" />
<jsp:include page="Secciones/Footer.jsp" />

<script>
    
    function listarAreas(){        
        $.ajax({
            type: 'GET',
            url: '${pageContext.request.contextPath}/rest/areas',
            dataType: "json", 
            success: function(areas){
                console.log(areas);
                $("#areasBody").empty();
                for(var area in areas){
                    $("#areasBody").append(obtenerFila(areas[area]));
                }
            },
            error: function(textStatus){
                console.log(textStatus);
                
            }
        });
    }
    
    function obtenerFila(area){
        return "<tr>\
                <td>" + area.idArea + "</td>\\n\
                <td>" + area.nombreArea + "</td>\
                <td>" + area.nombreCiudad + "</td>\</tr>"                
            
    }
</script>
