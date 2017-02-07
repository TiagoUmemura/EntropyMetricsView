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
        <title>Login</title>
    </head>
    <body>
        <h1>Hello World!</h1>
         <form action="LoginServlet" method="POST">
                <h1>Login</h1>
                <input type="email" value="" name="username" placeholder="Email" id="username" required/>
                <input type="number" name="userpass" value="" placeholder="Senha" id="password" required/>
                <input type="submit" value="Buscar" name="op"/>
        </form>
    </body>
</html>
