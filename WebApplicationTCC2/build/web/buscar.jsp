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
        <script type="text/javascript" language="javascript" src="TableFilter/tablefilter.js"></script>  
        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
        <script type="text/javascript" src="https://cdn.plot.ly/plotly-latest.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
        <link href="bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="spearson.js"></script>

    </head>
    <body onload="preencheCombo()">
        <nav class="navbar navbar-inverse navbar-fixed-top">
            <div class="container-fluid">
              <div class="navbar-header">
                <a class="navbar-brand" href="#">WebSiteName</a>
              </div>
              <ul class="nav navbar-nav">
                <li><a href="#" onclick="showhome()">Home</a></li>
                <li><a href="#" onclick="shownav1()">Projeto 1</a></li>
                <li><a href="#" onclick="shownav2()">Projeto 2</a></li>
              </ul>
            </div>
        </nav>
        
        <div class="container text-center" style="margin-top:50px">
            <div id="div_search">
                <h1>Github Data</h1>
                <form action="BuscarServlet" method="POST">
                    <h1>Search</h1>
                    <input type="text" value="" name="namerepo" placeholder="Usuario" id="namerepo" required/>
                    <input type="text" name="idrepo" value="" placeholder="Nome do projeto" id="idrepo" required/>
                    <input type="submit" value="Buscar" name="op"/>
                </form>
            </div>
        
        <hr>
        <!-- 
        <canvas id="myChart" width="400" height="400"></canvas>
        -->
        <div class="col-md-12" id="div_combo" style="display: none;">
            <label for="inputdefault">Projeto:</label>
             <select id="projeto">
                
              </select> 
        </div>
        
        <div class="col-md-4" id="div_data_inicial" style="display: none;">
            <label for="inputdefault">Data Inicial:</label>
            <input type="text" class="form-control" id="dateStart" placeholder="Data inicial" aria-describedby="basic-addon1">
        </div>
        
        <div class="col-md-4" id="div_data_final" style="display: none;">
            <label for="inputdefault">Data final:</label>
            <input type="text" class="form-control" id="dateEnd" placeholder="Data final" aria-describedby="basic-addon1">
        </div>
        
        <div class="col-md-4" id="div_button" style="display: none;">
            <label for="inputdefault"><hr></label>    
            <button type="button" class="btn btn-default" onclick="gerarVisualizacao2()">Calcular</button>
        </div>

        <div class="col-md-12" id="div_treemap" style="display: none;">
            <div id="chart_div" style="height: 500px;"></div>
        </div>
        
        <div class="col-md-12" id="div_treemap_files" style="display: none;">
            <div id="chart_div_file" style="height: 500px;"></div>
        </div>
        
        <div class="col-md-12" id="div_button_treemap" style="display: none;">
            <label for="inputdefault"><hr></label>    
            <button type="button" class="btn btn-default" onclick="changeTreemap()">Pacote/Arquivos</button>
        </div>
        
        <div class="col-md-12" id="div_chart_curve" style="display: none;">
            <div id="curve_chart" style="height: 500px"></div>
        </div>
         
        <div class="col-md-12" id="div_chart_curvelines" style="display: none;">
            <div id="curve_chartlines" style="height: 500px"></div>
        </div>
        
        <div class="col-md-12" id="div_button_curve" style="display: none;">
            <label for="inputdefault"><hr></label>    
            <button type="button" class="btn btn-default" onclick="changeLineChart()">Arquivos/Linhas Alteradas</button>
        </div>
        
        <!--<div class="input-group col-md-3">
            <span class="input-group-addon" id="basic-addon4">Total de Commits</span>
            <input type="text" class="form-control" id="numCommit" placeholder="commit" aria-describedby="basic-addon1">
        </div>-->
        
        <div class="col-md-12" id="report" style="display: none;">
            <p><br><br><br></p>
            <!-- Exemplo de texto dinamico html: http://www.hardware.com.br/comunidade/texto-muda/1378036/-->
            <p>O numero total de commits no período é <span id="numbercommit"></span>. Número total de Pull Requests aberto no peŕiodo é <span id="pullrequest"></span>
            Número total de Pull Requests fechados no peŕiodo é <span id="pullrequestclosed"></span></p>
        </div>
        
        <div class="col-md-12" id="filter" style="display: none;">
            <input type="text"class="form-control" id="myInput" onkeyup="myFilter()" placeholder="Search for names..">
        </div>
        
        <div class="col-md-12" style="height:120px; overflow:auto;display: none;" id="div_table">
         <table id="teste2" class="table table-striped">
            <tr>
              <th>Arquivo</th>
              <th>Entropia</th>
              <th>Linhas adicionadas</th>
              <th>Linhas removidas</th>
              <th>Linhas Modificadas</th>
              <th>Defeitos</th>
            </tr>
         </table>
        </div>
        
        <div class="col-md-12" id="divHeat" style="display: none;">
            <div id="fieldHeat" style="height: 300px;"></div>
        </div>
        
        
        <!-- Treemap 2 -->
        
        <div class="col-md-12" id="div_combo2" style="display: none;">
            <label for="inputdefault">Projeto:</label>
             <select id="projeto2">
                
              </select> 
        </div>
        
        <div class="col-md-4" id="div_data_inicial2" style="display: none;">
            <label for="inputdefault">Data Inicial:</label>
            <input type="text" class="form-control" id="dateStart2" placeholder="Data inicial" aria-describedby="basic-addon1">
        </div>
        
        <div class="col-md-4" id="div_data_final2" style="display: none;">
            <label for="inputdefault">Data final:</label>
            <input type="text" class="form-control" id="dateEnd2" placeholder="Data final" aria-describedby="basic-addon1">
        </div>
        
        <div class="col-md-4" id="div_button2" style="display: none;">
            <label for="inputdefault"><hr></label>    
            <button type="button" class="btn btn-default" onclick="gerarVisualizacao3()">Calcular</button>
        </div>
        
        <div class="col-md-12" id="div_treemap2" style="display: none;">
            <div id="chart_div2" style="height: 500px;"></div>
        </div>
        
        <div class="col-md-12" id="div_treemap_files2" style="display: none;">
            <div id="chart_div_file2" style="height: 500px;"></div>
        </div>
        
        <div class="col-md-12" id="div_button_treemap2" style="display: none;">
            <label for="inputdefault"><hr></label>    
            <button type="button" class="btn btn-default" onclick="changeTreemap2()">Pacote/Arquivos</button>
        </div>
        
        <div class="col-md-12" id="div_chart_curve2" style="display: none;">
            <div id="curve_chart2" style="height: 500px"></div>
        </div>
        
        <div class="col-md-12" id="div_chart_curve2lines" style="display: none;">
            <div id="curve_chart2lines" style="height: 500px"></div>
        </div>
        
        <div class="col-md-12" id="div_button_curve2" style="display: none;">
            <label for="inputdefault"><hr></label>    
            <button type="button" class="btn btn-default" onclick="changeLineChart2()">Arquivos/Linhas Alteradas</button>
        </div>
        
        <!--
        <div class="input-group col-md-3">
            <span class="input-group-addon" id="basic-addon7">Total de Commits</span>
            <input type="text" class="form-control" id="numCommit2" placeholder="commit" aria-describedby="basic-addon1">
        </div>
        -->
        
        <div class="col-md-12" id="report2" style="display: none;">
            <p><br><br><br></p>
            <!-- Exemplo de texto dinamico html: http://www.hardware.com.br/comunidade/texto-muda/1378036/-->
            <p>O numero total de commits no período é <span id="numbercommit2"></span>. Número total de Pull Requests aberto no peŕiodo é <span id="pullrequest2"></span>.
            Número total de Pull Requests fechado no peŕiodo é <span id="pullrequestclosed2"></span></p>
        </div>
        
        <div class="col-md-12" id="filter2" style="display: none;">
            <input type="text" class="form-control" id="myInput2" onkeyup="myFilter2()" placeholder="Search for names..">
        </div>
        
        <div class="col-md-12" id="div_table2" style="height:120px; overflow:auto; display: none;" >
         <table id="table2" cellspacing="0" class="table table-striped">
            <tr>
              <th>Arquivo</th>
              <th>Entropia</th>
              <th>Linhas adicionadas</th>
              <th>Linhas removidas</th>
              <th>Linhas Modificadas</th>
              <th>Defeitos</th>
            </tr>
         </table>
        </div>
        
        <div class="col-md-12" id="divHeat2" style="display: none;">
        <div id="fieldHeat2" style="height: 300px;"></div>
        </div>
        
        
        <!-- Fecha container -->
        </div>
     
        
        <script>
            function myFilter() {
              // Declare variables
              var input, filter, table, tr, td, i;
              input = document.getElementById("myInput");
              filter = input.value.toUpperCase();
              table = document.getElementById("teste2");
              tr = table.getElementsByTagName("tr");

              // Loop through all table rows, and hide those who don't match the search query
              for (i = 0; i < tr.length; i++) {
                td = tr[i].getElementsByTagName("td")[0];
                if (td) {
                  if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
                    tr[i].style.display = "";
                  } else {
                    tr[i].style.display = "none";
                  }
                }
              }
            }
        </script>
        
         <script>
            function myFilter2() {
              // Declare variables
              var input, filter, table, tr, td, i;
              input = document.getElementById("myInput2");
              filter = input.value.toUpperCase();
              table = document.getElementById("table2");
              tr = table.getElementsByTagName("tr");

              // Loop through all table rows, and hide those who don't match the search query
              for (i = 0; i < tr.length; i++) {
                td = tr[i].getElementsByTagName("td")[0];
                if (td) {
                  if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
                    tr[i].style.display = "";
                  } else {
                    tr[i].style.display = "none";
                  }
                }
              }
            }
        </script>
        
        <script type="text/javascript">
        
        function gerarVisualizacao2(){    
            var returnedJson;
            var countCommit;
            var returnedJsonPull;
            var returnedJsonPullClosed;
            var listcommit;
            //2016-10-14 2016-10-26
            var date1 = document.getElementById('dateStart').value;
            var date2 = document.getElementById('dateEnd').value;;
            var yourSelect = document.getElementById("projeto");
            var projeto = yourSelect.options[ yourSelect.selectedIndex ].value;
            
            //var tf1 = setFilterGrid("teste2");
            
            var urlcommitcount = 'http://localhost:9090/WebService/webresources/webservicegit/project/getcountcommitbydate/' + date1 + '/'+ date2 +'/' + projeto;
            var urlfiles = 'http://localhost:9090/WebService/webresources/webservicegit/project/getfilesbydate/'+ date1 + '/' + date2 +'/' + projeto;
            var urlpullrequest = 'http://localhost:9090/WebService/webresources/webservicegit/project/getPullRequestbydate/'+ date1 + '/' + date2 +'/'+ projeto;
            var urlpullrequestclosed = 'http://localhost:9090/WebService/webresources/webservicegit/project/getPullRequestclosedbydate/'+ date1 + '/' + date2 +'/'+ projeto;
            var urllistcommits = 'http://localhost:9090/WebService/webresources/webservicegit/project/getcommitsbydate/'+ date1 + '/' + date2 + '/' + projeto;
            
            $.ajax({
               // GET is the default type, no need to specify it
               type: 'GET',
               url: urlfiles,
               contentType: "application/json",
               dataType : 'json',
               crossDomain:true,
               async: false,
               success: function(data) {
                    //data is the object that youre after, handle it here

                    returnedJson = data;
                    alert("Sucesso: ");
                    //chamar uma funcao aqui passando como parametro o data
                    //criar a função abaixo do data
               },
               error: function(e){
                    alert('Could not able to find location!' + e);
               }
           });
           
            $.ajax({
               // GET is the default type, no need to specify it
               type: 'GET',
               url: urlcommitcount,
               contentType: "application/json",
               dataType : 'json',
               crossDomain:true,
               async: false,
               success: function(data) {
                    //data is the object that youre after, handle it here

                    countCommit = data;
                    //chamar uma funcao aqui passando como parametro o data
                    //criar a função abaixo do data
               },
               error: function(e){
                    alert('Could not able to find location!' + e);
               }
           });
           
           $.ajax({
               // GET is the default type, no need to specify it
               type: 'GET',
               url: urlpullrequest,
               contentType: "application/json",
               dataType : 'json',
               crossDomain:true,
               async: false,
               success: function(data) {
                    //data is the object that youre after, handle it here

                    returnedJsonPull = data;
                    alert("Sucesso: ");
                    
               },
               error: function(e){
                    alert('Could not able to find location!' + e);
               }
           });
           
           $.ajax({
               // GET is the default type, no need to specify it
               type: 'GET',
               url: urlpullrequestclosed,
               contentType: "application/json",
               dataType : 'json',
               crossDomain:true,
               async: false,
               success: function(data) {
                    //data is the object that youre after, handle it here

                    returnedJsonPullClosed = data;
                    //alert("Sucesso: ");
                    
               },
               error: function(e){
                    alert('Could not able to find location!' + e);
               }
           });
           
           $.ajax({
               // GET is the default type, no need to specify it
               type: 'GET',
               url: urllistcommits,
               contentType: "application/json",
               dataType : 'json',
               crossDomain:true,
               async: false,
               success: function(data) {
                    //data is the object that youre after, handle it here

                    listcommit = data;
                    
               },
               error: function(e){
                    alert('Could not able to find location!' + e);
               }
           });
           
           //setar valores no texto 1
           //document.getElementById('numCommit').value = countCommit[0].numbercommit;
           var countCommitText = document.getElementById('numbercommit'); 
           countCommitText.innerHTML = countCommit[0].numbercommit;
           
           //setar pullRequests abertos
           var pulltext = document.getElementById('pullrequest');
           pulltext.innerHTML = returnedJsonPull.length;
           
           var pullclosedtext = document.getElementById('pullrequestclosed');
           pullclosedtext.innerHTML = returnedJsonPullClosed.length;
           
           //cabecalho treemap array
           var treeMapArray = [
                        ['Location', 'Parent', 'Market trade volume (size)', 'Market increase/decrease (color)'],
                        ['Project',    '',                 0,                               0]
                      ];
                      
            //array treemap para dividir por arquivos
            var treeMapArrayFiles = [
                        ['Location', 'Parent', 'Market trade volume (size)', 'Market increase/decrease (color)'],
                        ['Project',    '',                 0,                               0]
                      ];
            
            var mapFiles = {};//numero de vezes que o arquivo foi commitado
            var mapFilesAdded = {}//numero de linhas adicionadas no total
            var mapFilesRemoved = {} // numero de linhas removidas
            var mapFilesChanged = {} //numero de linhas modificadas
            
            //Contar quantas vezes os arquivos (files) foram modificados
            //Contagem de linhas modificadas e quantas vezes o arquivo foi comitado
            for (i = 0; i < returnedJson.length; i++) { 
                if(returnedJson[i].nameFile in mapFiles){
                    mapFiles[returnedJson[i].nameFile] = mapFiles[returnedJson[i].nameFile] + 1;
                    mapFilesAdded[returnedJson[i].nameFile] = mapFilesAdded[returnedJson[i].nameFile] + returnedJson[i].lineAdd;
                    mapFilesRemoved[returnedJson[i].nameFile] = mapFilesRemoved[returnedJson[i].nameFile] + returnedJson[i].lineDeleted;
                    mapFilesChanged[returnedJson[i].nameFile] = mapFilesChanged[returnedJson[i].nameFile] + returnedJson[i].lineChanged;       
                }else{
                    mapFiles[returnedJson[i].nameFile] = 1;
                    mapFilesAdded[returnedJson[i].nameFile] = returnedJson[i].lineAdd;
                    mapFilesRemoved[returnedJson[i].nameFile] = returnedJson[i].lineDeleted;
                    mapFilesChanged[returnedJson[i].nameFile] = returnedJson[i].lineChanged;
                }
            }
            
            //contar numero de defeitos considerando as palavras bug, fix, postfix, prefix
            var mapFileBug = {};//armazenar quantidade de defeitos em cada arquivo
            for (i = 0; i < listcommit.length; i++) {
                var message = listcommit[i].messageCommit;
                
                //se encontrou as palavras adicionar a lista
                if(message.indexOf("bug") !== -1 
                    || message.indexOf("fix") !== -1
                    || message.indexOf("postfix") !== -1
                    || message.indexOf("prefix") !== -1
                    || message.indexOf("fixes") !== -1
                    ){
                    
                    var shacommit = listcommit[i].sha;
                    console.log(listcommit[i].sha);
                    for (j = 0; j < returnedJson.length; j++) {
                        //ver quais arquivos tem o mesmo sha e incrementar no map
                        if(shacommit === returnedJson[j].shaFile){
                            if(returnedJson[j].nameFile in mapFileBug){
                                mapFileBug[returnedJson[j].nameFile] = mapFileBug[returnedJson[j].nameFile] + 1;
                            }else{
                                mapFileBug[returnedJson[j].nameFile] = 1;
                            }
                        }
                    }
                }
            }
            //verificar quais arquivos nao tiveram defeitos e inserir na lista com valor 0
            for (i = 0; i < returnedJson.length; i++) { 
                if(!(returnedJson[i].nameFile in mapFileBug)){
                    mapFileBug[returnedJson[i].nameFile] = 0;
                }
            }
            
            //Inserindo os arquivos no array que ira gerar o treemap
            for (var name in mapFiles) {
                treeMapArrayFiles.push([name, 'Project',mapFiles[name],mapFiles[name]]);
                
                var table = document.getElementById("teste2");
                var row = table.insertRow(table.rows.length);
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                var cell5 = row.insertCell(4);
                var cell6 = row.insertCell(5);
                cell1.innerHTML = name;
                cell2.innerHTML = mapFiles[name];
                cell3.innerHTML = mapFilesAdded[name];
                cell4.innerHTML = mapFilesRemoved[name];
                cell5.innerHTML = mapFilesChanged[name];
                cell6.innerHTML = mapFileBug[name];
                //var tf1 = setFilterGrid("teste2");
            }
            
            //for para dividir em pastas, pacotes
            var mapAllPath = {};//guardar todos os caminhos e subcaminhos da pasta para nao inserir um subcaminho igual
            for (var name in mapFiles) {
                var path = name.split("/");
                var pathaux = ""; //variavel para ir concatenando e verificando se ocaminho ja existe
                var pathparent = "";
                
                if(path.length > 1){
                    for(i = 0; i < path.length; i++){

                        pathparent = pathaux;

                        if(i != 0){
                            pathaux = pathaux + "/" +path[i];
                        }else{
                            pathaux = path[i];
                        }

                        if(pathaux in mapAllPath){
                            mapAllPath[pathaux] = mapAllPath[pathaux] + 1;
                        }else{
                            mapAllPath[pathaux] = 1;


                            if (i == 0){
                                treeMapArray.push([pathaux, "Project", 0, 0]);
                            }else if(i == path.length - 1){
                                treeMapArray.push([name, pathparent, mapFiles[name], mapFiles[name]]);
                            }else{
                                treeMapArray.push([pathaux, pathparent, 0, 0]);
                            }
                        }

                    }
                } else {
                    treeMapArray.push([name, 'Project',mapFiles[name],mapFiles[name]]);
                }
            }
            
            //Inicio treemap
            //se a div estiver display none, treemap apresenta problemas
            document.getElementById("div_treemap").style.display = "block";
            
            google.charts.load('current', {'packages':['treemap']});
            google.charts.setOnLoadCallback(drawChart);
            function drawChart() {
              var data = google.visualization.arrayToDataTable(treeMapArray);

              tree = new google.visualization.TreeMap(document.getElementById('chart_div'));

              tree.draw(data, {
                minColor: '#f00',
                midColor: '#ddd',
                maxColor: '#0d0',
                headerHeight: 15,
                fontColor: 'black',
                showScale: true
              });

            }
            
            //treemap by files
            document.getElementById("div_treemap_files").style.display = "block"; 
            
            google.charts.load('current', {'packages':['treemap']});
            google.charts.setOnLoadCallback(drawChartFiles);
            
            function drawChartFiles() {
              var data = google.visualization.arrayToDataTable(treeMapArrayFiles);

              tree = new google.visualization.TreeMap(document.getElementById('chart_div_file'));
              google.visualization.events.addListener(tree, 'ready', myReadyHandler);

              tree.draw(data, {
                minColor: '#f00',
                midColor: '#ddd',
                maxColor: '#0d0',
                headerHeight: 15,
                fontColor: 'black',
                showScale: true
              });
              
              function myReadyHandler(){
                document.getElementById("div_treemap_files").style.display = "none"; 
              }
            }
            
            
            //fim treemap
            
            //timeline grafico
            //array para guardar os dados que serão plotados (quatidade de arquivos modificados por tempo)
            var arrayLine = [
                        ['Periodo', 'Quantidade de Arquivos','Quantidade de commits']
                        
                      ];
            var arrayLine2 = [
                        ['Periodo', 'Linhas modificadas','linhas adicionadas', 'linhas removidas']
                        
                      ];
                      
            var numPeriodo = 0;
            var dInicio = new Date(date1);
            var dPeriodo = new Date(date1);
            var dFinal = new Date(date2);
            
            //setar o primeiro periodo
            dPeriodo.setDate(dPeriodo.getDate() + 15);
            console.log("date: " + dInicio);
            console.log("date: " + dPeriodo);
            console.log("date: " + dFinal);
            //https://www.w3schools.com/js/js_date_methods.asp
            
            while(dPeriodo <= dFinal){
                numPeriodo = numPeriodo + 1;
                var contaArquivo = 0;
                var contaCommit = 0;
                var contaModificada = 0;
                var contaAdicionada = 0;
                var contaRemovida = 0;
                
                for (i = 0; i < listcommit.length; i++) {
                    var dateString = listcommit[i].dateCreate;
                    var date = new Date(dateString);
                    
                    if(date < dPeriodo && date >= dInicio){
                        contaCommit = contaCommit + 1;
                        var shaCommit = listcommit[i].sha;
                        for (j = 0; j < returnedJson.length; j++) {
                        //ver quais arquivos tem o mesmo sha e incrementar no map
                            if(shaCommit === returnedJson[j].shaFile){
                                 contaArquivo = contaArquivo + 1;
                                 contaModificada = contaModificada + returnedJson[j].lineChanged;
                                 contaAdicionada = contaAdicionada + returnedJson[j].lineAdd;
                                 contaRemovida = contaRemovida + returnedJson[j].lineDeleted;
                            }
                        }
                        
                    }
                }
                
                arrayLine.push([numPeriodo.toString(), contaArquivo, contaCommit]);
                arrayLine2.push([numPeriodo.toString(), contaModificada, contaAdicionada, contaRemovida]);
                //Avançar 15 dias no periodo
                dInicio.setDate(dInicio.getDate() + 15);
                dPeriodo.setDate(dPeriodo.getDate() + 15);
                console.log("date dentro da funcao: " + dInicio);
                console.log("date dentro da funcao: " + dPeriodo);
                
            }
            
            google.charts.load('current', {'packages':['corechart']});
            google.charts.setOnLoadCallback(drawChart2);

            function drawChart2() {
              var data = google.visualization.arrayToDataTable(arrayLine);

              var options = {
                title: 'Quantidade de arquivos alterados',
                curveType: 'function',
                legend: { position: 'bottom' }
              };

              var chart = new google.visualization.LineChart(document.getElementById('curve_chart'));

              chart.draw(data, options);
            }
            
             google.charts.load('current', {'packages':['corechart']});
            google.charts.setOnLoadCallback(drawChart2lines);

            function drawChart2lines() {
              var data = google.visualization.arrayToDataTable(arrayLine2);
              document.getElementById("div_chart_curvelines").style.display = "block"

              var options = {
                title: 'Quantidade de linhas alteradas',
                curveType: 'function',
                legend: { position: 'bottom' }
              };

              var chart = new google.visualization.LineChart(document.getElementById('curve_chartlines'));
              google.visualization.events.addListener(chart, 'ready', myReadyHandler);
              
              function myReadyHandler(){
                document.getElementById("div_chart_curvelines").style.display = "none"; 
              }
              
              chart.draw(data, options);
            }
            //fim timeline grafico
            
            //inicio heatmap utvilizar spearman
            var arquivoEntropia = []; //array para guardar a entropia com indexes numerico para files
            var arquivoDefeito = [];//array para guardar o numero de defeitos com indexes numerico para file
            var arquivoModificada = [];//array para guardar o numero de linhas modficadas com indexes numerico para file
            var arquivoAdicionado = [];
            var arquivoRemovido = []; 
            
            for (var name in mapFiles) {
                arquivoEntropia.push(mapFiles[name]);
                arquivoDefeito.push(mapFileBug[name]);
                arquivoModificada.push(mapFilesChanged[name]);
                arquivoAdicionado.push(mapFilesAdded[name]);
                arquivoRemovido.push(mapFilesRemoved[name]);
            }
            
            var corrEntDef = spearson.correlation.spearman(arquivoEntropia, arquivoDefeito);
            var corrEntMod = spearson.correlation.spearman(arquivoEntropia, arquivoModificada);
            var corrEntAdd = spearson.correlation.spearman(arquivoEntropia, arquivoAdicionado);
            var corrEntRem = spearson.correlation.spearman(arquivoEntropia, arquivoRemovido);
            
            var data = [
              {
                z: [[corrEntDef, corrEntMod, corrEntAdd, corrEntRem], [-1, -1, -1, -1], [-1, -1, -1, -1]],
                x: ['Defeito','Linhas modificadas','linhas adicionadas','linhas removidas'],
                y: ['Entropia', 'Afternoon', 'Evening'],
                type: 'heatmap'
              }
            ];

          Plotly.newPlot('fieldHeat', data);
          //Fim treemap
        }
    
        </script>
    
    <script type="text/javascript">
       function gerarVisualizacao3(){    
            var returnedJson;
            var countCommit;
            var listcommit;
            var returnedJsonPull;
            var returnedJsonPullClosed;
            //2016-10-14 2016-10-26
            var date1 = document.getElementById('dateStart2').value;
            var date2 = document.getElementById('dateEnd2').value;;
            var yourSelect = document.getElementById("projeto2");
            var projeto = yourSelect.options[ yourSelect.selectedIndex ].value;
            
            var urlcommit = 'http://localhost:9090/WebService/webresources/webservicegit/project/getcountcommitbydate/' + date1 + '/'+ date2 +'/' + projeto;
            var urlfiles = 'http://localhost:9090/WebService/webresources/webservicegit/project/getfilesbydate/'+ date1 + '/' + date2 +'/' + projeto;
            var urlpullrequest = 'http://localhost:9090/WebService/webresources/webservicegit/project/getPullRequestbydate/'+ date1 + '/' + date2 +'/'+ projeto;
            var urlpullrequestclosed = 'http://localhost:9090/WebService/webresources/webservicegit/project/getPullRequestclosedbydate/'+ date1 + '/' + date2 +'/'+ projeto;
            var urllistcommits = 'http://localhost:9090/WebService/webresources/webservicegit/project/getcommitsbydate/'+ date1 + '/' + date2 + '/' + projeto;
            
            $.ajax({
               // GET is the default type, no need to specify it
               type: 'GET',
               url: urlfiles,
               contentType: "application/json",
               dataType : 'json',
               crossDomain:true,
               async: false,
               success: function(data) {
                    //data is the object that youre after, handle it here

                    returnedJson = data;
                    alert("Sucesso: ");
                    //chamar uma funcao aqui passando como parametro o data
                    //criar a função abaixo do data
               },
               error: function(e){
                    alert('Could not able to find location!' + e);
               }
           });
           
            $.ajax({
               // GET is the default type, no need to specify it
               type: 'GET',
               url: urlcommit,
               contentType: "application/json",
               dataType : 'json',
               crossDomain:true,
               async: false,
               success: function(data) {
                    //data is the object that youre after, handle it here

                    countCommit = data;
                    //chamar uma funcao aqui passando como parametro o data
                    //criar a função abaixo do data
               },
               error: function(e){
                    alert('Could not able to find location!' + e);
               }
           });
           
           $.ajax({
               // GET is the default type, no need to specify it
               type: 'GET',
               url: urlpullrequest,
               contentType: "application/json",
               dataType : 'json',
               crossDomain:true,
               async: false,
               success: function(data) {
                    //data is the object that youre after, handle it here

                    returnedJsonPull = data;
                    alert("Sucesso: ");
                    //chamar uma funcao aqui passando como parametro o data
                    //criar a função abaixo do data
               },
               error: function(e){
                    alert('Could not able to find location!' + e);
               }
           });
           
           $.ajax({
               // GET is the default type, no need to specify it
               type: 'GET',
               url: urlpullrequestclosed,
               contentType: "application/json",
               dataType : 'json',
               crossDomain:true,
               async: false,
               success: function(data) {
                    //data is the object that youre after, handle it here

                    returnedJsonPullClosed = data;
                    //alert("Sucesso: ");
                    
               },
               error: function(e){
                    alert('Could not able to find location!' + e);
               }
           });
           
           $.ajax({
               // GET is the default type, no need to specify it
               type: 'GET',
               url: urllistcommits,
               contentType: "application/json",
               dataType : 'json',
               crossDomain:true,
               async: false,
               success: function(data) {
                    //data is the object that youre after, handle it here

                    listcommit = data;
                    
               },
               error: function(e){
                    alert('Could not able to find location!' + e);
               }
           });
           
           //document.getElementById('numCommit2').value = countCommit[0].numbercommit;
           var countCommitText2 = document.getElementById('numbercommit2'); 
           countCommitText2.innerHTML = countCommit[0].numbercommit;
           
           var pulltext2 = document.getElementById('pullrequest2');
           pulltext2.innerHTML = returnedJsonPull.length;
           
           var pulltextclosed2 = document.getElementById('pullrequestclosed2');
           pulltextclosed2.innerHTML = returnedJsonPullClosed.length;
           
           //array treemap para dividir por pacotes
           var treeMapArray = [
                        ['Location', 'Parent', 'Market trade volume (size)', 'Market increase/decrease (color)'],
                        ['Project',    '',                 0,                               0]
                      ];
            
            //array treemap para dividir por arquivos
            var treeMapArrayFiles = [
                        ['Location', 'Parent', 'Market trade volume (size)', 'Market increase/decrease (color)'],
                        ['Project',    '',                 0,                               0]
                      ];
            
            var mapFiles = {};//armazenar entropia de cada arquivo   
            var mapFilesAdded = {};//numero de linhas adicionadas no total
            var mapFilesRemoved = {}; // numero de linhas removidas
            var mapFilesChanged = {}; //numero de linhas modificadas
            //data.length
            for (i = 0; i < returnedJson.length; i++) { 
                //treeMapArray.push([returnedJson[i].nameFile, 'Project',returnedJson[i].lineChanged,returnedJson[i].lineChanged]);
                if(returnedJson[i].nameFile in mapFiles){
                    mapFiles[returnedJson[i].nameFile] = mapFiles[returnedJson[i].nameFile] + 1;
                    mapFilesAdded[returnedJson[i].nameFile] = mapFilesAdded[returnedJson[i].nameFile] + returnedJson[i].lineAdd;
                    mapFilesRemoved[returnedJson[i].nameFile] = mapFilesRemoved[returnedJson[i].nameFile] + returnedJson[i].lineDeleted;
                    mapFilesChanged[returnedJson[i].nameFile] = mapFilesChanged[returnedJson[i].nameFile] + returnedJson[i].lineChanged;
                }else{
                    mapFiles[returnedJson[i].nameFile] = 1;
                    mapFilesAdded[returnedJson[i].nameFile] = returnedJson[i].lineAdd;
                    mapFilesRemoved[returnedJson[i].nameFile] = returnedJson[i].lineDeleted;
                    mapFilesChanged[returnedJson[i].nameFile] = returnedJson[i].lineChanged;
                }
            }
            
            //contar numero de defeitos considerando as palavras bug, fix, postfix, prefix
            var mapFileBug = {};//armazenar quantidade de defeitos em cada arquivo
            for (i = 0; i < listcommit.length; i++) {
                var message = listcommit[i].messageCommit;
                
                //se encontrou as palavras adicionar a lista
                if(message.indexOf("bug") !== -1 
                    || message.indexOf("fix") !== -1
                    || message.indexOf("postfix") !== -1
                    || message.indexOf("prefix") !== -1
                    ){
                    
                    var shacommit = listcommit[i].sha;
                    console.log(listcommit[i].sha);
                    for (j = 0; j < returnedJson.length; j++) {
                        //ver quais arquivos tem o mesmo sha e incrementar no map
                        if(shacommit === returnedJson[j].shaFile){
                            if(returnedJson[j].nameFile in mapFileBug){
                                mapFileBug[returnedJson[j].nameFile] = mapFileBug[returnedJson[j].nameFile] + 1;
                            }else{
                                mapFileBug[returnedJson[j].nameFile] = 1;
                            }
                        }
                    }
                }
            }
            
            //verificar quais arquivos nao tem defeitos e inserir na lsita com 0 no valor
            for (i = 0; i < returnedJson.length; i++) { 
                if(!(returnedJson[i].nameFile in mapFileBug)){
                    mapFileBug[returnedJson[i].nameFile] = 0;
                }
            }
            
            
            for (var name in mapFiles) {
                treeMapArrayFiles.push([name, 'Project',mapFiles[name],mapFiles[name]]);
                
                var table = document.getElementById("table2");
                var row = table.insertRow(table.rows.length);
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                var cell5 = row.insertCell(4);
                var cell6 = row.insertCell(5);
                cell1.innerHTML = name;
                cell2.innerHTML = mapFiles[name];
                cell3.innerHTML = mapFilesAdded[name];
                cell4.innerHTML = mapFilesRemoved[name];
                cell5.innerHTML = mapFilesChanged[name];
                cell6.innerHTML = mapFileBug[name];
            }
            
            //for para dividir em pastas, pacotes
            var mapAllPath = {};//guardar todos os caminhos e subcaminhos da pasta para nao inserir um subcaminho igual
            for (var name in mapFiles) {
                var path = name.split("/");
                var pathaux = ""; //variavel para ir concatenando e verificando se ocaminho ja existe
                var pathparent = "";
                
                if(path.length > 1){
                    for(i = 0; i < path.length; i++){
                        
                        //armazenar o pai do subcaminho seguinte
                        pathparent = pathaux;

                        if(i != 0){
                            pathaux = pathaux + "/" +path[i];
                        }else{
                            pathaux = path[i];
                        }
                        
                        //se o subcaminho ja existe nao faz nada, operação de soma apenas para contagem
                        if(pathaux in mapAllPath){
                            mapAllPath[pathaux] = mapAllPath[pathaux] + 1;
                        }else{
                            mapAllPath[pathaux] = 1;


                            if (i == 0){
                                treeMapArray.push([pathaux, "Project", 0, 0]);
                            }else if(i == path.length - 1){
                                treeMapArray.push([name, pathparent, mapFiles[name], mapFiles[name]]);
                            }else{
                                treeMapArray.push([pathaux, pathparent, 0, 0]);
                            }
                        }

                    }
                } else {
                    treeMapArray.push([name, 'Project',mapFiles[name],mapFiles[name]]);
                }
            }
            
            document.getElementById("div_treemap2").style.display = "block";
            
            google.charts.load('current', {'packages':['treemap']});
            google.charts.setOnLoadCallback(drawChart);
            function drawChart() {
              var data = google.visualization.arrayToDataTable(treeMapArray);

              tree = new google.visualization.TreeMap(document.getElementById('chart_div2'));

              tree.draw(data, {
                minColor: '#f00',
                midColor: '#ddd',
                maxColor: '#0d0',
                headerHeight: 15,
                fontColor: 'black',
                showScale: true
              });

            }
            
             //treemap by files
             //se estiver no display none treemap apresenta problemas
            document.getElementById("div_treemap_files2").style.display = "block";
            
            google.charts.load('current', {'packages':['treemap']});
            google.charts.setOnLoadCallback(drawChartFiles);
            function drawChartFiles() {
              var data = google.visualization.arrayToDataTable(treeMapArrayFiles);

              tree = new google.visualization.TreeMap(document.getElementById('chart_div_file2'));
              google.visualization.events.addListener(tree, 'ready', myReadyHandler);

              tree.draw(data, {
                minColor: '#f00',
                midColor: '#ddd',
                maxColor: '#0d0',
                headerHeight: 15,
                fontColor: 'black',
                showScale: true
              });
              
              function myReadyHandler(){
                document.getElementById("div_treemap_files2").style.display = "none"; 
              }

            }
            //Fim treemap
            
            //timeline grafico
            //array para guardar os dados que serão plotados (quatidade de arquivos modificados por tempo)
            var arrayLine = [
                        ['Periodo', 'Quantidade de Arquivos','Quantidade de commits']
                        
                      ];
            var arrayLine2 = [
                        ['Periodo', 'Linhas modificadas','linhas adicionadas', 'linhas removidas']
                        
                      ];
                      
            var numPeriodo = 0;
            var dInicio = new Date(date1);
            var dPeriodo = new Date(date1);
            var dFinal = new Date(date2);
            
            //setar o primeiro periodo
            dPeriodo.setDate(dPeriodo.getDate() + 15);
            console.log("date: " + dInicio);
            console.log("date: " + dPeriodo);
            console.log("date: " + dFinal);
            //https://www.w3schools.com/js/js_date_methods.asp
            
            //enquanto nao chegar no final do periodo, avançar em 15 dias no intervalo
            while(dPeriodo <= dFinal){
                numPeriodo = numPeriodo + 1;
                var contaArquivo = 0;
                var contaCommit = 0;
                var contaModificada = 0;
                var contaAdicionada = 0;
                var contaRemovida = 0;
                
                for (i = 0; i < listcommit.length; i++) {
                    var dateString = listcommit[i].dateCreate;
                    var date = new Date(dateString);
                    
                    if(date < dPeriodo && date >= dInicio){
                        contaCommit = contaCommit + 1;
                        var shaCommit = listcommit[i].sha;
                        for (j = 0; j < returnedJson.length; j++) {
                        //ver quais arquivos tem o mesmo sha e incrementar no map
                            if(shaCommit === returnedJson[j].shaFile){
                                 contaArquivo = contaArquivo + 1;
                                 contaModificada = contaModificada + returnedJson[j].lineChanged;
                                 contaAdicionada = contaAdicionada + returnedJson[j].lineAdd;
                                 contaRemovida = contaRemovida + returnedJson[j].lineDeleted;
                            }
                        }
                        
                    }
                }
                
                arrayLine.push([numPeriodo.toString(), contaArquivo, contaCommit]);
                arrayLine2.push([numPeriodo.toString(), contaModificada, contaAdicionada, contaRemovida]);
                //Avançar 15 dias no periodo
                dInicio.setDate(dInicio.getDate() + 15);
                dPeriodo.setDate(dPeriodo.getDate() + 15);
                console.log("date dentro da funcao: " + dInicio);
                console.log("date dentro da funcao: " + dPeriodo);
                
            }
            
            google.charts.load('current', {'packages':['corechart']});
            google.charts.setOnLoadCallback(drawChart2);

            function drawChart2() {
              var data = google.visualization.arrayToDataTable(arrayLine);

              var options = {
                title: 'Quantidade de arquivos alterados',
                curveType: 'function',
                legend: { position: 'bottom' }
              };

              var chart = new google.visualization.LineChart(document.getElementById('curve_chart2'));

              chart.draw(data, options);
            }
            
            google.charts.load('current', {'packages':['corechart']});
            google.charts.setOnLoadCallback(drawChart2lines);

            function drawChart2lines() {
              var data = google.visualization.arrayToDataTable(arrayLine2);
              document.getElementById("div_chart_curve2lines").style.display = "block"; 
              
              var options = {
                title: 'Quantidade de linhas alteradas',
                curveType: 'function',
                legend: { position: 'bottom' }
              };

              var chart = new google.visualization.LineChart(document.getElementById('curve_chart2lines'));
              google.visualization.events.addListener(chart, 'ready', myReadyHandler);
              
              function myReadyHandler(){
                document.getElementById("div_chart_curve2lines").style.display = "none"; 
              }

              chart.draw(data, options);
            }
            //fim timeline grafico
            
            //heatmap
            //inicio heatmap utvilizar spearman
            var arquivoEntropia = []; //array para guardar a entropia com indexes numerico para files
            var arquivoDefeito = [];//array para guardar o numero de defeitos com indexes numerico para file
            var arquivoModificada = [];//array para guardar o numero de linhas modficadas com indexes numerico para file
            var arquivoAdicionado = [];
            var arquivoRemovido = [];
            
            for (var name in mapFiles) {
                arquivoEntropia.push(mapFiles[name]);
                arquivoDefeito.push(mapFileBug[name]);
                arquivoModificada.push(mapFilesChanged[name]);
                arquivoAdicionado.push(mapFilesAdded[name]);
                arquivoRemovido.push(mapFilesRemoved[name]);
            }
            
            var corrArqDef = spearson.correlation.spearman(arquivoEntropia, arquivoDefeito);
            var corrEntMod = spearson.correlation.spearman(arquivoEntropia, arquivoModificada);
            var corrEntAdd = spearson.correlation.spearman(arquivoEntropia, arquivoAdicionado);
            var corrEntRem = spearson.correlation.spearman(arquivoEntropia, arquivoRemovido);
            
            var data = [
              {
                z: [[corrArqDef, corrEntMod,corrEntAdd, corrEntRem], [-1, -1, -1, -1], [-1, -1, -1, -1]],
                x: ['Defeito','Linhas modificadas','linhas adicionadas','linhas removidas'],
                y: ['Entropia', 'Afternoon', 'Evening'],
                type: 'heatmap'
              }
            ];

          Plotly.newPlot('fieldHeat2', data);
        }
        
        
    </script>
    
    <script type="text/javascript">
    
    //funcoes para controlar as abas (navbar)
    function shownav2(){
        var optionTreemapDisplay;
        var optionCharLineDisplay;
        
        if( document.getElementById("div_chart_curve2lines").style.display == "none"){
            optionCharLineDisplay = "byFilesAndCommits";
        }else{
            optionCharLineDisplay = "byNumberLines";
        }
        
        if( document.getElementById("div_treemap_files").style.display == "none"){
            optionTreemapDisplay = "showByPackage";
        }else{
            optionTreemapDisplay = "showByFiles";
        }
        
        document.getElementById("div_combo").style.display = "none";
        document.getElementById("div_data_inicial").style.display = "none";
        document.getElementById("div_data_final").style.display = "none";
        document.getElementById("div_button").style.display = "none";
        document.getElementById("div_treemap").style.display = "none";
        document.getElementById("div_chart_curve").style.display = "none";
        document.getElementById("div_chart_curvelines").style.display = "none";
        document.getElementById("report").style.display = "none";
        document.getElementById("filter").style.display = "none";
        document.getElementById("div_table").style.display = "none";
        document.getElementById("div_treemap_files").style.display = "none";
        document.getElementById("div_search").style.display = "none";
        document.getElementById("div_button_treemap").style.display = "none";
        document.getElementById("divHeat").style.display = "none";
        document.getElementById("div_button_curve").style.display = "none";
        
        document.getElementById("div_combo2").style.display = "block";
        document.getElementById("div_data_inicial2").style.display = "block";
        document.getElementById("div_data_final2").style.display = "block";
        document.getElementById("div_button2").style.display = "block";
        document.getElementById("report2").style.display = "block";
        document.getElementById("filter2").style.display = "block";
        document.getElementById("div_table2").style.display = "block";
        document.getElementById("div_button_treemap2").style.display = "block";
        document.getElementById("divHeat2").style.display = "block";
        document.getElementById("div_button_curve2").style.display = "block";
        
        if(optionTreemapDisplay == "showByPackage"){
            document.getElementById("div_treemap2").style.display = "block";
        }else{
            document.getElementById("div_treemap_files2").style.display = "block";
        }
        
        if(optionCharLineDisplay == "byNumberLines"){
            document.getElementById("div_chart_curve2lines").style.display = "block";
        }else{
            document.getElementById("div_chart_curve2").style.display = "block";
        }
       
    }
    
    function shownav1(){
        var optionTreemapDisplay;
        var optionCharLineDisplay;
        
        if( document.getElementById("div_chart_curvelines").style.display == "none"){
            optionCharLineDisplay = "byFilesAndCommits";
        }else{
            optionCharLineDisplay = "byNumberLines";
        }
        
        if( document.getElementById("div_treemap_files2").style.display == "none"){
            optionTreemapDisplay = "showByPackage";
        }else{
            optionTreemapDisplay = "showByFiles";
        }
        
        document.getElementById("div_combo2").style.display = "none";
        document.getElementById("div_data_inicial2").style.display = "none";
        document.getElementById("div_data_final2").style.display = "none";
        document.getElementById("div_button2").style.display = "none";
        document.getElementById("div_treemap2").style.display = "none";
        document.getElementById("div_chart_curve2").style.display = "none";
        document.getElementById("div_chart_curve2lines").style.display = "none";
        document.getElementById("report2").style.display = "none";
        document.getElementById("filter2").style.display = "none";
        document.getElementById("div_table2").style.display = "none";
        document.getElementById("div_treemap_files2").style.display = "none";
        document.getElementById("div_search").style.display = "none";
        document.getElementById("div_button_treemap2").style.display = "none";
        document.getElementById("divHeat2").style.display = "none";
        document.getElementById("div_button_curve2").style.display = "none";
        
        document.getElementById("div_combo").style.display = "block";
        document.getElementById("div_data_inicial").style.display = "block";
        document.getElementById("div_data_final").style.display = "block";
        document.getElementById("div_button").style.display = "block";
        document.getElementById("div_button_treemap").style.display = "block";
        document.getElementById("report").style.display = "block";
        document.getElementById("filter").style.display = "block";
        document.getElementById("div_table").style.display = "block";
        document.getElementById("divHeat").style.display = "block";
        document.getElementById("div_button_curve").style.display = "block";
        
        if(optionTreemapDisplay == "showByPackage"){
            document.getElementById("div_treemap").style.display = "block";
        }else{
            document.getElementById("div_treemap_files").style.display = "block";
        }
        
        if(optionCharLineDisplay == "byNumberLines"){
            document.getElementById("div_chart_curvelines").style.display = "block";
        }else{
            document.getElementById("div_chart_curve").style.display = "block";
        }
        
    }
    
    function showhome(){
        document.getElementById("div_search").style.display = "block";
        
        document.getElementById("div_combo2").style.display = "none";
        document.getElementById("div_data_inicial2").style.display = "none";
        document.getElementById("div_data_final2").style.display = "none";
        document.getElementById("div_button2").style.display = "none";
        document.getElementById("div_treemap2").style.display = "none";
        document.getElementById("div_chart_curve2").style.display = "none";
        document.getElementById("div_chart_curve2lines").style.display = "none";
        document.getElementById("report2").style.display = "none";
        document.getElementById("filter2").style.display = "none";
        document.getElementById("div_table2").style.display = "none";
        document.getElementById("div_treemap_files2").style.display = "none";
        document.getElementById("div_button_treemap2").style.display = "none";
        document.getElementById("divHeat2").style.display = "none";
        document.getElementById("div_button_curve2").style.display = "none";
        
        document.getElementById("div_combo").style.display = "none";
        document.getElementById("div_data_inicial").style.display = "none";
        document.getElementById("div_data_final").style.display = "none";
        document.getElementById("div_button").style.display = "none";
        document.getElementById("div_treemap").style.display = "none";
        document.getElementById("div_chart_curve").style.display = "none";
        document.getElementById("div_chart_curvelines").style.display = "none";
        document.getElementById("report").style.display = "none";
        document.getElementById("filter").style.display = "none";
        document.getElementById("div_table").style.display = "none";
        document.getElementById("div_treemap_files").style.display = "none";
        document.getElementById("div_button_treemap").style.display = "none";
        document.getElementById("divHeat").style.display = "none";
        document.getElementById("div_button_curve").style.display = "none";
    }
    
    function changeTreemap(){
        var display = document.getElementById("div_treemap").style.display;
        if(display == "none"){
            document.getElementById("div_treemap").style.display = 'block';
            document.getElementById("div_treemap_files").style.display = 'none';
        }
        else{
            document.getElementById("div_treemap").style.display = 'none';
            document.getElementById("div_treemap_files").style.display = 'block';
        }
    }
    
    function changeTreemap2(){
        var display = document.getElementById("div_treemap2").style.display;
        if(display == "none"){
            document.getElementById("div_treemap2").style.display = 'block';
            document.getElementById("div_treemap_files2").style.display = 'none';
        }
        else{
            document.getElementById("div_treemap2").style.display = 'none';
            document.getElementById("div_treemap_files2").style.display = 'block';
        }
    }
    
    function changeLineChart(){
        var display = document.getElementById("div_chart_curve").style.display;
        if(display == "none"){
            document.getElementById("div_chart_curve").style.display = 'block';
            document.getElementById("div_chart_curvelines").style.display = 'none';
        }
        else{
            document.getElementById("div_chart_curve").style.display = 'none';
            document.getElementById("div_chart_curvelines").style.display = 'block';
        }
    }
    
    function changeLineChart2(){
        var display = document.getElementById("div_chart_curve2").style.display;
        if(display == "none"){
            document.getElementById("div_chart_curve2").style.display = 'block';
            document.getElementById("div_chart_curve2lines").style.display = 'none';
        }
        else{
            document.getElementById("div_chart_curve2").style.display = 'none';
            document.getElementById("div_chart_curve2lines").style.display = 'block';
        }
    }
    
    function preencheCombo(){
        var urlProject = 'http://localhost:9090/WebService/webresources/webservicegit/project/getproject';
        var listProject;
        
        $.ajax({
               // GET is the default type, no need to specify it
               type: 'GET',
               url: urlProject,
               contentType: "application/json",
               dataType : 'json',
               crossDomain:true,
               async: false,
               success: function(data) {
                    //data is the object that youre after, handle it here

                    listProject = data;
                    
               },
               error: function(e){
                    alert('Could not able to find location!' + e);
               }
           });
           
        var select1 = document.getElementById('projeto');
        var select2 = document.getElementById('projeto2');
        
        for (i = 0; i < listProject.length; i++) { 
            var name = listProject[i].nameProject;
            console.log(name);
            
            var opt = document.createElement('option');
            opt.text = name;
            
            var opt2 = document.createElement('option');
            opt2.text = name;
            select1.add(opt);    
            select2.add(opt2);    
                
        }
           
    }
    
    </script>
    <!-- Tabela que lista arquivos e mostra as metricas desses arquivos: entropia, numero de defeitos etc (tcc)
        Um texto com numero de commits no periodo, valor da entropia media, valor de defeito médio, defeito maximo, numero de author
        Visualização treemap: escolher uma metrica para pintar treemap. colocar valores na legenda, dividindo em 5 partes iguais
    
        Colocar code churn, line added, line removed na tabela
    
        contar defeitos, analisar qualquer commit
    
    -->
    </body>
</html>
