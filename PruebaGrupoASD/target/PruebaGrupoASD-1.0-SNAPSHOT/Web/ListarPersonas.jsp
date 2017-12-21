<%-- 
    Document   : index
    Created on : 18/12/2017, 09:35:16 PM
    Author     : Santiago
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="Secciones/Head.jsp" />

        <h2>Módulo para listar empleados.</h2>
        
        <input class="btn btn-success" type="button" onclick="listarPersonas()" value = "Listar Personas" />
    
                

        
<jsp:include page="Secciones/Footer.jsp" />
<script>
    
    function listarPersonas(){
        console.log("Listando Personas");
        $.ajax({
            type: 'GET',
            url: '${pageContext.request.contextPath}/rest/personal',
            dataType: "json", // data type of response
            success: function(data){
                console.log(data);
            },
            error: function(textStatus){
                console.log(textStatus);
                
            }
        });
    }
</script>
    


