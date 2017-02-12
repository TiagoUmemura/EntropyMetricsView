<%-- 
    Document   : login
    Created on : Dec 19, 2016, 3:31:57 PM
    Author     : tiago
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Search project</title>
    </head>
    <body>
        <h1>Github Data Visualization</h1>
         <form action="BuscarServlet" method="POST">
                <h1>Search</h1>
                <input type="text" value="" name="namerepo" placeholder="Nome" id="namerepo" required/>
                <input type="number" name="idrepo" value="" placeholder="ID" id="idrepo" required/>
                <input type="submit" value="Buscar" name="op"/>
        </form>
    </body>
</html>
