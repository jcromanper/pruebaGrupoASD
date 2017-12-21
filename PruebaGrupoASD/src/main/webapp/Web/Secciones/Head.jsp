<%-- 
    Document   : Head
    Created on : 18/12/2017, 09:33:48 PM
    Author     : Santiago
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Web/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Web/css/bootstrap-theme.min.css">
        
        <script type="text/javascript" charset="utf8" src="${pageContext.request.contextPath}/Web/js/jquery-3.2.1.min.js"></script>
        <script type="text/javascript" charset="utf8" src="${pageContext.request.contextPath}/Web/js/bootstrap.min.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Prueba ASD</title>
    </head>
    <body>
        <div class="container-fluid">
    
    <nav class="navbar navbar-default">
      <div class="container">
        
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar-collapse-1">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="${pageContext.request.contextPath}">Activos Fijos Grupo ASD</a>
        </div>
    
        
        <div class="collapse navbar-collapse" id="navbar-collapse-1">
          <ul class="nav navbar-nav navbar-right">
            <li><a href="#">Buscar</a></li>
            <li><a href="#">Crear</a></li>
            <li><a href="#">Actualizar</a></li>
            <li><a href="${pageContext.request.contextPath}/Web/ListarAreas.jsp">Listar áreas</a></li>
            <li><a href="${pageContext.request.contextPath}/Web/ListarPersonas.jsp">Listar personas</a></li>                     
          </ul>

        </div>
      </div>
    </nav>
    
   
    
