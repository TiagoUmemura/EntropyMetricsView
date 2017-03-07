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
        <script src="Chart.js"></script>
    </head>
    <body>
        <h1>Github Data Visualization</h1>
        <form action="BuscarServlet" method="POST">
            <h1>Search</h1>
            <input type="text" value="" name="namerepo" placeholder="Nome" id="namerepo" required/>
            <input type="number" name="idrepo" value="" placeholder="ID" id="idrepo" required/>
            <input type="submit" value="Buscar" name="op"/>
        </form>

        <canvas id="myChart" width="400" height="400"></canvas>
        <script>
            var ctx = document.getElementById("myChart");
            var myChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: ['Item 1', 'Item 2', 'Item 3'],
                    datasets: [
                        {
                            type: 'bar',
                            label: 'Bar Component',
                            data: [10, 20, 30],
                        },
                        {
                            type: 'line',
                            label: 'Line Component',
                            data: [30, 20, 10],
                        }
                    ]
                }
            });
        </script>
    </body>
</html>
