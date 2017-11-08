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
                <a class="navbar-brand" href="#">Github Metrics</a>
              </div>
              <ul class="nav navbar-nav">
                <li><a href="#" onclick="showhome()">Home</a></li>
                <li><a href="#" onclick="shownav1()">Projeto 1</a></li>
                <li><a href="#" onclick="shownav2()">Projeto 2</a></li>
                <li><a href="#" onclick="showtreemap()">TreeMap</a></li>
                <li><a href="#" onclick="showlinechart()">Line Chart</a></li>
                <li><a href="#" onclick="showheatmap()">Heatmap</a></li>
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
            <input type="text" class="form-control" id="dateStart" placeholder="YYYY-MM-DD" aria-describedby="basic-addon1">
        </div>
        
        <div class="col-md-4" id="div_data_final" style="display: none;">
            <label for="inputdefault">Data final:</label>
            <input type="text" class="form-control" id="dateEnd" placeholder="YYYY-MM-DD" aria-describedby="basic-addon1">
        </div>
        
        <div class="col-md-4" id="div_button" style="display: none;">
            <label for="inputdefault"></label> 
            <button type="button" class="btn btn-default btn-block" onclick="gerarVisualizacao2()">Calcular</button>
        </div>

        <div class="col-md-12" id="div_treemap" style="display: none;">
            <div id="chart_div" style="height: 500px;"></div>
        </div>
        
        <div class="col-md-12" id="div_treemap_files" style="display: none;">
            <div id="chart_div_file" style="height: 500px;"></div>
        </div>
        
        <div class="col-md-12" id="div_button_treemap" style="display: none;">
            <label for="inputdefault"><hr></label>    
            <button type="button" class="btn btn-default btn-block" onclick="changeTreemap()">Pacote/Arquivos</button>
        </div>
        
        <div class="col-md-12" id="div_chart_curve" style="display: none;">
            <div id="curve_chart" style="height: 500px"></div>
        </div>
         
        <div class="col-md-12" id="div_chart_curvelines" style="display: none;">
            <div id="curve_chartlines" style="height: 500px"></div>
        </div>
        
        <div class="col-md-12" id="div_chart_curvepullreq" style="display: none;">
            <div id="curve_chartpullreq" style="height: 500px"></div>
        </div>
        
        <div class="col-md-4" id="div_button_curve" style="display: none;">
            <label for="inputdefault"><hr></label>    
            <button type="button" class="btn btn-default btn-block" onclick="changeFileChart()">Commits</button>
        </div>
        
        <div class="col-md-4" id="div_button_curveLines" style="display: none;">
            <label for="inputdefault"><hr></label>    
            <button type="button" class="btn btn-default btn-block" onclick="changeLineChart()">Linhas modificadas de Arquivos</button>
        </div>
        
        <div class="col-md-4" id="div_button_curvepullreq" style="display: none;">
            <label for="inputdefault"><hr></label>    
            <button type="button" class="btn btn-default btn-block" onclick="changePullReqChart()">Pull Request</button>
        </div>
        
        <!--<div class="input-group col-md-3">
            <span class="input-group-addon" id="basic-addon4">Total de Commits</span>
            <input type="text" class="form-control" id="numCommit" placeholder="commit" aria-describedby="basic-addon1">
        </div>-->
        
        <div class="col-md-12" id="report" style="display: none;">
            <p><br><br><br></p>
            <!-- Exemplo de texto dinamico html: http://www.hardware.com.br/comunidade/texto-muda/1378036/-->
            <p>O numero total de commits no período é <span id="numbercommit"></span>. Número total de Pull Requests aberto no peŕiodo é <span id="pullrequest"></span>.
            Número total de Pull Requests merged no peŕiodo é <span id="pullrequestclosed"></span>.
            Número total de Pull Requests unmerged no peŕiodo é <span id="pullrequestunmerged"></span>.
            Número total de autores é <span id="numberauthor"></span>.
            Autor com maior numero de commits é <span id="ownership"></span>.
            Author Owner fez <span id="numberownership"></span> commits.
            Autor com maior experiência é <span id="experience"></span>.
            </p>
        </div>
        
        <div class="col-md-12" id="filter" style="display: none;">
            <input type="text"class="form-control" id="myInput" onkeyup="myFilter()" placeholder="Search for names..">
        </div>
        
        <div class="col-md-12" style="height:500px; overflow:auto;display: none;" id="div_table">
         <table id="teste2" class="table table-striped">
            <tr>
              <th>Arquivo</th>
              <th>Entropia</th>
              <th>Add</th>
              <th>Remove</th>
              <th>Changed</th>
              <th>Defects</th>
              <th>P.R Closed</th>
              <th>P.R Closed Comment</th>
              <th>P.R Opened</th>
              <th>P.R Opened Comment</th>
              <th>Ownership</th>
              <th>Exp</th>
            </tr>
         </table>
        </div>
        
        <div class="col-md-12" id="divHeat" style="display: none;">
            <hr>
            <h4><br><br><br>Heatmap de correlação entre métricas</h4>
            <div id="fieldHeat" style="height: 500px;"></div>
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
            <button type="button" class="btn btn-default btn-block" onclick="changeTreemap2()">Pacote/Arquivos</button>
        </div>
        
        <div class="col-md-12" id="div_chart_curve2" style="display: none;">
            <div id="curve_chart2" style="height: 500px"></div>
        </div>
        
        <div class="col-md-12" id="div_chart_curve2lines" style="display: none;">
            <div id="curve_chart2lines" style="height: 500px"></div>
        </div>
        
        <div class="col-md-12" id="div_chart_curve2pullreq" style="display: none;">
            <div id="curve_chart2pullreq" style="height: 500px"></div>
        </div>
        
        <div class="col-md-4" id="div_button_curve2" style="display: none;">
            <label for="inputdefault"><hr></label>    
            <button type="button" class="btn btn-default btn-block" onclick="changeFileChart2()">Arquivos</button>
        </div>
        
        <div class="col-md-4" id="div_button_curve2Lines" style="display: none;">
            <label for="inputdefault"><hr></label>    
            <button type="button" class="btn btn-default btn-block" onclick="changeLineChart2()">Linhas Alteradas</button>
        </div>
        
        <div class="col-md-4" id="div_button_curve2pullreq" style="display: none;">
            <label for="inputdefault"><hr></label>    
            <button type="button" class="btn btn-default btn-block" onclick="changePullReqChart2()">Pull Request</button>
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
            Número total de Pull Requests fechado no peŕiodo é <span id="pullrequestclosed2"></span>
            Número total de autores é <span id="numberauthor2"></span>.
            Autor com maior numero de commits é <span id="ownership2"></span>.
            Author Owner fez <span id="numberownership2"></span> commits.
            Autor com maior experiência é <span id="experience2"></span>.
            </p>
        </div>
        
        <div class="col-md-12" id="filter2" style="display: none;">
            <input type="text" class="form-control" id="myInput2" onkeyup="myFilter2()" placeholder="Search for names..">
        </div>
        
        <div class="col-md-12" id="div_table2" style="height:130px; overflow:auto; display: none;" >
         <table id="table2" cellspacing="0" class="table table-striped">
            <tr>
              <th>Arquivo</th>
              <th>Entropia</th>
              <th>Add</th>
              <th>Remove</th>
              <th>Changed</th>
              <th>Defects</th>
              <th>P.R Closed</th>
              <th>P.R Closed Comment</th>
              <th>P.R Opened</th>
              <th>P.R Opened Comment</th>
              <th>Ownership</th>
              <th>Exp</th>
            </tr>
         </table>
        </div>
        
        <div class="col-md-12" id="divHeat2" style="display: none;">
            <hr>
            <h4><br><br><br>Heatmap de correlação entre métricas</h4>
            <div id="fieldHeat2" style="height: 500px;"></div>
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
            var jsonFilePullRequestOpen;
            var returnedJsonPullClosed;
            var jsonFilePullRequestClosed;
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
            var urlFilePullRequestOpen = 'http://localhost:9090/WebService/webresources/webservicegit/project/getFilePullRequestopenbydate/'+ date1 + '/' + date2 +'/'+ projeto;
            var urlpullrequestclosed = 'http://localhost:9090/WebService/webresources/webservicegit/project/getPullRequestclosedbydate/'+ date1 + '/' + date2 +'/'+ projeto;
            var urllistcommits = 'http://localhost:9090/WebService/webresources/webservicegit/project/getcommitsbydate/'+ date1 + '/' + date2 + '/' + projeto;
            var urlCommitPullRequestClosed = 'http://localhost:9090/WebService/webresources/webservicegit/project/getCommitPullRequestclosedbydate/'+ date1 + '/' + date2 + '/' + projeto;
            var urlFilePullRequestClosed = 'http://localhost:9090/WebService/webresources/webservicegit/project/getFilePullRequestclosedbydate/'+ date1 + '/' + date2 + '/' + projeto;
            
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
                    //pull aberto

                    returnedJsonPull = data;
                    //alert("Sucesso: ");
                    
               },
               error: function(e){
                    alert('Could not able to find location!' + e);
               }
           });
           
           $.ajax({
               // GET is the default type, no need to specify it
               type: 'GET',
               url:  urlFilePullRequestOpen,
               contentType: "application/json",
               dataType : 'json',
               crossDomain:true,
               async: false,
               success: function(data) {
                    //arquivos de pull request abertos

                   jsonFilePullRequestOpen = data;
                    
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
                    
               },
               error: function(e){
                    alert('Could not able to find location!' + e);
               }
           });
           
           $.ajax({
               // Lista de commits do periodo definido
               type: 'GET',
               url: urllistcommits,
               contentType: "application/json",
               dataType : 'json',
               crossDomain:true,
               async: false,
               success: function(data) {

                    listcommit = data;
                    
               },
               error: function(e){
                    alert('Could not able to find location!' + e);
               }
           });
           
           $.ajax({
               // Lista de arquivos dos pullRequest fechados no periodo
               type: 'GET',
               url: urlFilePullRequestClosed,
               contentType: "application/json",
               dataType : 'json',
               crossDomain:true,
               async: false,
               success: function(data) {

                    jsonFilePullRequestClosed = data;
                    
               },
               error: function(e){
                    alert('Could not able to find location!' + e);
               }
           });
           
           //setar valores no texto 1
           //document.getElementById('numCommit').value = countCommit[0].numbercommit;
           var countCommitText = document.getElementById('numbercommit'); 
           countCommitText.innerHTML = countCommit[0].numbercommit;
           
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
            var mapFilesAdded = {};//numero de linhas adicionadas no total
            var mapFilesRemoved = {}; // numero de linhas removidas
            var mapFilesChanged = {}; //numero de linhas modificadas
            var mapFilePullRequestClosed = {};//numero de pull request fechado por arquivo
            var mapFileCommentPullRequestClosed = {};//numero de comment pull request fechado por arquivo
            var mapFilePullRequestOpen = {};//numero de pull request fechado por arquivo
            var mapFileCommentPullRequestOpen = {};//numero de comment pull request fechado por arquivo
            var mapOwnershipFile = {};
            var mapExperienceFile = {};
            
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
            
            //CONTAR NUMERO DE DEFEITOS considerando as palavras bug, fix, postfix, prefix
            var mapFileBug = {};//armazenar quantidade de defeitos em cada arquivo
            for (i = 0; i < listcommit.length; i++) {
                var message = listcommit[i].messageCommit;
                
                //se encontrou as palavras adicionar a lista
                if(message.toLowerCase().indexOf("bug") !== -1 
                    || message.toLowerCase().indexOf("fix") !== -1
                    || message.toLowerCase().indexOf("postfix") !== -1
                    || message.toLowerCase().indexOf("prefix") !== -1
                    || message.toLowerCase().indexOf("fixes") !== -1
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
            //FIM CONTAGEM NUMERO DEFEITOS
            
            //CONTAR QUANTIDADE DE COMMITS DE CADA AUTOR
            var mapAuthorship = {}; //Armazenar quantidade de commits de cada autor
            var countAuthor = 0;
            for (i = 0; i < listcommit.length; i++) {
                var author = listcommit[i].author;
                
                if (author in mapAuthorship){
                    mapAuthorship[author] = mapAuthorship[author] + 1;
                }else{
                    mapAuthorship[author] = 1;
                    countAuthor = countAuthor +1
                }
            }
            
            var authortext = document.getElementById('numberauthor');
            authortext.innerHTML = countAuthor;
            
            var nameOwner;
            var maxvalue = 0;
            for(var name in mapAuthorship){
                if(mapAuthorship[name] > maxvalue){
                    nameOwner = name;
                    maxvalue = mapAuthorship[name];
                }
            }
            
            var authorownertext = document.getElementById('ownership');
            authorownertext.innerHTML = nameOwner;
            
            var authorownernumbertext = document.getElementById('numberownership');
            authorownernumbertext.innerHTML = mapAuthorship[nameOwner];
            
            console.log(mapAuthorship);
            console.log(nameOwner);
            
            //contar quantas vezes cada arquivo foi commitado pelo owner
            for (i = 0; i < listcommit.length; i++) {
                var shacommit = listcommit[i].sha;
                //quais arquivos foram comitados pelo owner do periodo
                if(listcommit[i].author == nameOwner){
                    
                    for (j = 0; j < returnedJson.length; j++) {
                        //ver quais arquivos tem o mesmo sha e incrementar no map
                        if(shacommit === returnedJson[j].shaFile){
                            if(returnedJson[j].nameFile in mapOwnershipFile){
                                mapOwnershipFile[returnedJson[j].nameFile] = mapOwnershipFile[returnedJson[j].nameFile] + 1;
                            }else{
                                mapOwnershipFile[returnedJson[j].nameFile] = 1;
                            }
                        }
                    }
                }
            }
            //setar 0 para os demais arquivo que nao entraram na lista
            for (i = 0; i < returnedJson.length; i++) { 
                if(!(returnedJson[i].nameFile in mapOwnershipFile)){
                    mapOwnershipFile[returnedJson[i].nameFile] = 0;
                }
            }
            
            console.log(mapOwnershipFile);
            //FIM OWNERSHIP
            
            //CONTAR EXPERIENCE DE CADA AUTOR EM UM PERIODO
            var mapExperience = {};//armazena experience de cada autor
            for (i = 0; i < listcommit.length; i++) {
                var shacommit = listcommit[i].sha;
                for (j = 0; j < returnedJson.length; j++) {
                        //ver quais arquivos tem o mesmo sha e incrementar no map
                    if(shacommit === returnedJson[j].shaFile){
                        
                        if(listcommit[i].author in mapExperience){
                            mapExperience[listcommit[i].author] = mapExperience[listcommit[i].author] + returnedJson[j].lineChanged;
                        }else{
                            mapExperience[listcommit[i].author] = returnedJson[j].lineChanged;
                        }
                        
                    }
                }
                
            }
            
            var nameSenior;
            var maxvalueex = 0;
            for(var name in mapExperience){
                if(mapExperience[name] > maxvalueex){
                    nameSenior = name;
                    maxvalueex = mapExperience[name];
                }
            }
            
            var authorexptext = document.getElementById('experience');
            authorexptext.innerHTML = nameSenior;
            
             //contar quantas vezes cada arquivo foi commitado pelo usuario com mais experiencia
            for (i = 0; i < listcommit.length; i++) {
                var shacommit = listcommit[i].sha;
                //quais arquivos foram comitados pelo usuario com mais experiencia
                if(listcommit[i].author == nameSenior){
                    
                    for (j = 0; j < returnedJson.length; j++) {
                        //ver quais arquivos tem o mesmo sha e incrementar no map
                        if(shacommit === returnedJson[j].shaFile){
                            if(returnedJson[j].nameFile in mapExperienceFile){
                                mapExperienceFile[returnedJson[j].nameFile] = mapExperienceFile[returnedJson[j].nameFile] + 1;
                            }else{
                                mapExperienceFile[returnedJson[j].nameFile] = 1;
                            }
                        }
                    }
                }
            }
            
            //setar 0 para os demais arquivo que nao entraram na lista
            for (i = 0; i < returnedJson.length; i++) { 
                if(!(returnedJson[i].nameFile in mapExperienceFile)){
                    mapExperienceFile[returnedJson[i].nameFile] = 0;
                }
            }
            
            console.log(mapExperience);
            console.log(nameSenior);
            //FIM EXPERIENCE
            
            //INICIO CONTAGEM PULL REQUEST ABERTO E FECHADO
            var pullMerged = 0;
            var pullUnmerged = 0;
            //pull criado fechado e merged, comentario e pull por arquivo
            for (i = 0; i < returnedJsonPull.length; i++){
                
                var numComment = returnedJsonPull[i].numComments;
                
                //contar merged e unmerged
                if(returnedJsonPull[i].merged == 1){
                    pullMerged = pullMerged + 1;
                }else{
                    pullUnmerged = pullUnmerged + 1;
                }
                
                for(j = 0; j < jsonFilePullRequestOpen.length; j++){
                    //se foi merged
                    if(returnedJsonPull[i].nameProject == jsonFilePullRequestOpen[j].nameProjectFilePull && returnedJsonPull[i].numberId == jsonFilePullRequestOpen[j].pullReqNumber && returnedJsonPull[i].merged == 1){
                        //Verificar os arquivos do pulrequest e contar em quantos pullrequest o arquivo aparece       
                        if(jsonFilePullRequestOpen[j].fileName in mapFilePullRequestClosed){
                            mapFilePullRequestClosed[jsonFilePullRequestOpen[j].fileName] = mapFilePullRequestClosed[jsonFilePullRequestOpen[j].fileName] + 1;
                            mapFileCommentPullRequestClosed[jsonFilePullRequestOpen[j].fileName] = mapFileCommentPullRequestClosed[jsonFilePullRequestOpen[j].fileName] + numComment;
                        }else{
                            mapFilePullRequestClosed[jsonFilePullRequestOpen[j].fileName] = 1;
                            mapFileCommentPullRequestClosed[jsonFilePullRequestOpen[j].fileName] = numComment;
                        }
                    //se nao foi merged
                    }
                    if (returnedJsonPull[i].nameProject == jsonFilePullRequestOpen[j].nameProjectFilePull && returnedJsonPull[i].numberId == jsonFilePullRequestOpen[j].pullReqNumber && returnedJsonPull[i].merged == 0){
                        if(jsonFilePullRequestOpen[j].fileName in mapFilePullRequestOpen){
                            mapFilePullRequestOpen[jsonFilePullRequestOpen[j].fileName] = mapFilePullRequestOpen[jsonFilePullRequestOpen[j].fileName] + 1;
                            mapFileCommentPullRequestOpen[jsonFilePullRequestOpen[j].fileName] = mapFileCommentPullRequestOpen[jsonFilePullRequestOpen[j].fileName] + numComment;
                        }else{
                            mapFilePullRequestOpen[jsonFilePullRequestOpen[j].fileName] = 1;
                            mapFileCommentPullRequestOpen[jsonFilePullRequestOpen[j].fileName] = numComment;
                        }
                    }
                }
            }
            
            //setar pullRequests abertos
            var pulltext = document.getElementById('pullrequest');
            pulltext.innerHTML = returnedJsonPull.length;
           
            var pullclosedtext = document.getElementById('pullrequestclosed');
            pullclosedtext.innerHTML = pullMerged;
            
            var pullunmergedtext = document.getElementById('pullrequestunmerged');
            pullunmergedtext.innerHTML = pullUnmerged;
            
//            //pull aberto comentario e pull por arquivo
//            for (i = 0; i < returnedJsonPull.length; i++){
//                
//                var numComment = returnedJsonPull[i].numComments;
//                
//                for(j = 0; j < jsonFilePullRequestOpen.length; j++){
//                    if(returnedJsonPull[i].nameProject == jsonFilePullRequestOpen[j].nameProjectFilePull && returnedJsonPull[i].numberId == jsonFilePullRequestOpen[j].pullReqNumber){
//                        //Verificar os arquivos do pulrequest e contar em quantos pullrequest o arquivo aparece
//                        if(jsonFilePullRequestOpen[j].fileName in mapFilePullRequestOpen){
//                            mapFilePullRequestOpen[jsonFilePullRequestOpen[j].fileName] = mapFilePullRequestOpen[jsonFilePullRequestOpen[j].fileName] + 1;
//                            mapFileCommentPullRequestOpen[jsonFilePullRequestOpen[j].fileName] = mapFileCommentPullRequestOpen[jsonFilePullRequestOpen[j].fileName] + numComment;
//                        }else{
//                            mapFilePullRequestOpen[jsonFilePullRequestOpen[j].fileName] = 1;
//                            mapFileCommentPullRequestOpen[jsonFilePullRequestOpen[j].fileName] = numComment;
//                        }
//                    }
//                }
//            }
            
            //Colocar valor 0 de pull req fechado para os demais arquivos
            for(var name in mapFiles){
                if(name in mapFilePullRequestClosed){
                    
                }else{
                    mapFilePullRequestClosed[name] = 0;
                    mapFileCommentPullRequestClosed[name] = 0;
                }
                
                if(name in mapFilePullRequestOpen){
                    
                }else{
                    mapFilePullRequestOpen[name] = 0;
                    mapFileCommentPullRequestOpen[name] = 0;
                }
            }
            
            //for(var name in mapFilePullRequestOpen){
                //console.log(name + " : " + mapFilePullRequestOpen[name]);
            //}
            //FIM CONTAGEM PULL ABERTO E FECHADO E COMENTARIOS
            
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
                var cell7 = row.insertCell(6);
                var cell8 = row.insertCell(7);
                var cell9 = row.insertCell(8);
                var cell10 = row.insertCell(9);
                var cell11 = row.insertCell(10);
                var cell12 = row.insertCell(11);

                cell1.innerHTML = name;
                cell2.innerHTML = mapFiles[name];
                cell3.innerHTML = mapFilesAdded[name];
                cell4.innerHTML = mapFilesRemoved[name];
                cell5.innerHTML = mapFilesChanged[name];
                cell6.innerHTML = mapFileBug[name];
                cell7.innerHTML = mapFilePullRequestClosed[name];
                cell8.innerHTML = mapFileCommentPullRequestClosed[name];
                cell9.innerHTML = mapFilePullRequestOpen[name];
                cell10.innerHTML = mapFileCommentPullRequestOpen[name];
                cell11.innerHTML = mapOwnershipFile[name];
                cell12.innerHTML = mapExperienceFile[name];
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
                minColor: '#0d0',
                midColor: '#ddd',
                maxColor: '#f00',
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
                minColor: '#0d0',
                midColor: '#ddd',
                maxColor: '#f00',
                headerHeight: 15,
                fontColor: 'black',
                showScale: true
              });
              
              function myReadyHandler(){
                document.getElementById("div_treemap_files").style.display = "none"; 
              }
            }
            
            
            //fim treemap
            
            //TIMELINE GRAFICO
            //array para guardar os dados que serão plotados (quatidade de arquivos modificados por tempo)
            var arrayLine = [
                        ['Periodo', 'Quantidade de Arquivos','Commits', 'Owner Commits']
                        
                      ];
            var arrayLine2 = [
                        ['Periodo', 'Linhas modificadas','linhas adicionadas', 'linhas removidas']
                        
                      ];
                      
            var arrayLine3 = [
                        ['Periodo', 'P.R closed','P.R open','P.R closed comment','P.R open comment']
                        
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
            
            while(dPeriodo <= dFinal){
                numPeriodo = numPeriodo + 1;
                var contaArquivo = 0;
                var contaCommit = 0;
                var contaModificada = 0;
                var contaAdicionada = 0;
                var contaRemovida = 0;
                var contaPullRequestFechado = 0;
                var contaPullRequestAberto = 0;
                var contaCommentPullRequestFechado = 0;
                var contaCommentPullRequestAberto = 0;
                var contaCommitOwner = 0;
                
                for (i = 0; i < listcommit.length; i++) {
                    var dateString = listcommit[i].dateCreate;
                    var date = new Date(dateString);
                    
                    if(date < dPeriodo && date >= dInicio){
                        contaCommit = contaCommit + 1;
                        
                        if(listcommit[i].author == nameOwner){
                            contaCommitOwner = contaCommitOwner + 1; 
                        }
                        
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
                
                //Pull request fechado a cada 15 dias
                for (i = 0; i < returnedJsonPull.length; i++){
                    var dateString = returnedJsonPull[i].dateClose;
                    var date = new Date(dateString);
                    var dateopen = new Date(returnedJsonPull[i].dateCreate);
                    
                    if(date < dPeriodo && date >= dInicio && dateopen < dPeriodo && dateopen >= dInicio && returnedJsonPull[i].merged == 1){
                        contaPullRequestFechado = contaPullRequestFechado + 1;
                        contaCommentPullRequestFechado = contaCommentPullRequestFechado + returnedJsonPull[i].numComments;
                    }else{
                        if(dateopen < dPeriodo && dateopen >= dInicio && returnedJsonPull[i].merged == 0){
                            contaPullRequestAberto = contaPullRequestAberto + 1;
                            contaCommentPullRequestAberto = contaCommentPullRequestAberto + returnedJsonPull[i].numComments;
                        }
                    }
                }
                
                //Pull Request aberto a cada 15 dias
//                for (i = 0; i < returnedJsonPull.length; i++){
//                    var dateString = returnedJsonPull[i].dateCreate;
//                    var date = new Date(dateString);
//                    
//                    if(date < dPeriodo && date >= dInicio){
//                        contaPullRequestAberto = contaPullRequestAberto + 1;
//                        contaCommentPullRequestAberto = contaCommentPullRequestAberto + returnedJsonPull[i].numComments;
//                    }
//                }
                
                arrayLine.push([numPeriodo.toString(), contaArquivo, contaCommit, contaCommitOwner]);
                arrayLine2.push([numPeriodo.toString(), contaModificada, contaAdicionada, contaRemovida]);
                arrayLine3.push([numPeriodo.toString(), contaPullRequestFechado, contaPullRequestAberto,contaCommentPullRequestFechado,contaCommentPullRequestAberto]);
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
                title: 'Quantidade de mudança',
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
                title: 'Quantidade de linhas alteradas no período',
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
            
            google.charts.load('current', {'packages':['corechart']});
            google.charts.setOnLoadCallback(drawChart2pull);

            function drawChart2pull() {
              var data = google.visualization.arrayToDataTable(arrayLine3);
              document.getElementById("div_chart_curvepullreq").style.display = "block"

              var options = {
                title: 'Quantidade de Pull Request no peŕiodo',
                curveType: 'function',
                legend: { position: 'bottom' }
              };

              var chart = new google.visualization.LineChart(document.getElementById('curve_chartpullreq'));
              google.visualization.events.addListener(chart, 'ready', myReadyHandler);
              
              function myReadyHandler(){
                document.getElementById("div_chart_curvepullreq").style.display = "none"; 
              }
              
              chart.draw(data, options);
            }
            //FIM TIMELINE GRAFICO
            
            //inicio heatmap utvilizar spearman
            var arquivoEntropia = []; //array para guardar a entropia com indexes numerico para files
            var arquivoDefeito = [];//array para guardar o numero de defeitos com indexes numerico para file
            var arquivoModificada = [];//array para guardar o numero de linhas modficadas com indexes numerico para file
            var arquivoAdicionado = [];
            var arquivoRemovido = []; 
            var arquivoPullRequestClosed = [];
            var arquivoPullRequestOpen = [];
            var arquivoCommentPullRequestClosed = [];
            var arquivoCommentPullRequestOpen = [];
            var arquivoOwnership = [];
            var arquivoExperience = [];
            
            for (var name in mapFiles) {
                arquivoEntropia.push(mapFiles[name]);
                arquivoDefeito.push(mapFileBug[name]);
                arquivoModificada.push(mapFilesChanged[name]);
                arquivoAdicionado.push(mapFilesAdded[name]);
                arquivoRemovido.push(mapFilesRemoved[name]);
                arquivoPullRequestClosed.push(mapFilePullRequestClosed[name]);//numero de pull request fechado por arquivo
                arquivoPullRequestOpen.push(mapFilePullRequestOpen[name]);//numero de pull request fechado por arquivo
                arquivoCommentPullRequestClosed.push(mapFileCommentPullRequestClosed[name]);//numero de comment pull request fechado por arquivo
                arquivoCommentPullRequestOpen.push(mapFileCommentPullRequestOpen[name]);//numero de comment pull request fechado por arquivo
                arquivoOwnership.push(mapOwnershipFile[name]);
                arquivoExperience.push(mapExperienceFile[name]);
            }
            
            var corrEntDef = spearson.correlation.spearman(arquivoEntropia, arquivoDefeito);
            var corrEntMod = spearson.correlation.spearman(arquivoEntropia, arquivoModificada);
            var corrEntAdd = spearson.correlation.spearman(arquivoEntropia, arquivoAdicionado);
            var corrEntRem = spearson.correlation.spearman(arquivoEntropia, arquivoRemovido);
            var corrEntPullReqClosed = spearson.correlation.spearman(arquivoEntropia, arquivoPullRequestClosed);
            var corrEntPullReqClosedComment = spearson.correlation.spearman(arquivoEntropia, arquivoCommentPullRequestClosed);
            var corrEntPullReqOpen = spearson.correlation.spearman(arquivoEntropia, arquivoPullRequestOpen);
            var corrEntPullReqOpenComment = spearson.correlation.spearman(arquivoEntropia, arquivoCommentPullRequestOpen);
            var corrEntOwner = spearson.correlation.spearman(arquivoEntropia, arquivoOwnership);
            var corrEntExp = spearson.correlation.spearman(arquivoEntropia, arquivoExperience);
            
            var defLinMod = spearson.correlation.spearman(arquivoDefeito, arquivoModificada);
            var defLinAdd = spearson.correlation.spearman(arquivoDefeito, arquivoAdicionado);
            var defLinRemove = spearson.correlation.spearman(arquivoDefeito, arquivoRemovido);
            var defPRClosed = spearson.correlation.spearman(arquivoDefeito, arquivoPullRequestClosed);
            var defCommentClosed = spearson.correlation.spearman(arquivoDefeito, arquivoCommentPullRequestClosed);
            var defPROpen = spearson.correlation.spearman(arquivoDefeito, arquivoPullRequestOpen);
            var defCommentOpen = spearson.correlation.spearman(arquivoDefeito, arquivoCommentPullRequestOpen);
            var defOwnership = spearson.correlation.spearman(arquivoDefeito, arquivoOwnership);
            var defExperience = spearson.correlation.spearman(arquivoDefeito, arquivoExperience);
            
            var modAdd = spearson.correlation.spearman(arquivoModificada, arquivoAdicionado);
            var modRem = spearson.correlation.spearman(arquivoModificada, arquivoRemovido);
            var modPRClosed = spearson.correlation.spearman(arquivoModificada, arquivoPullRequestClosed);
            var modCommentClosed = spearson.correlation.spearman(arquivoModificada, arquivoCommentPullRequestClosed);
            var modPROpen = spearson.correlation.spearman(arquivoModificada, arquivoPullRequestOpen);
            var modCommentOpen = spearson.correlation.spearman(arquivoModificada, arquivoCommentPullRequestOpen);
            var modOwnership = spearson.correlation.spearman(arquivoModificada, arquivoOwnership);
            var modExperience = spearson.correlation.spearman(arquivoModificada, arquivoExperience);
            
            var addRem = spearson.correlation.spearman(arquivoAdicionado, arquivoRemovido);
            var addPRClosed = spearson.correlation.spearman(arquivoAdicionado, arquivoPullRequestClosed);
            var addCommentClosed = spearson.correlation.spearman(arquivoAdicionado, arquivoCommentPullRequestClosed);
            var addPROpen = spearson.correlation.spearman(arquivoAdicionado, arquivoPullRequestOpen);
            var addCommentOpen = spearson.correlation.spearman(arquivoAdicionado, arquivoCommentPullRequestOpen);
            var addOwnership = spearson.correlation.spearman(arquivoAdicionado, arquivoOwnership);
            var addExperience = spearson.correlation.spearman(arquivoAdicionado, arquivoExperience);
            
            var remPRClosed = spearson.correlation.spearman(arquivoRemovido, arquivoPullRequestClosed);
            var remCommentClosed = spearson.correlation.spearman(arquivoRemovido, arquivoCommentPullRequestClosed);
            var remPROpen = spearson.correlation.spearman(arquivoRemovido, arquivoPullRequestOpen);
            var remCommentOpen = spearson.correlation.spearman(arquivoRemovido, arquivoCommentPullRequestOpen);
            var remOwnership = spearson.correlation.spearman(arquivoRemovido, arquivoOwnership);
            var remExperience = spearson.correlation.spearman(arquivoRemovido, arquivoExperience);
            
            var prclosedCommentClosed = spearson.correlation.spearman(arquivoPullRequestClosed, arquivoCommentPullRequestClosed);
            var prclosedPROpen = spearson.correlation.spearman(arquivoPullRequestClosed, arquivoPullRequestOpen);
            var prclosedCommentOpen = spearson.correlation.spearman(arquivoPullRequestClosed, arquivoCommentPullRequestOpen);
            var prclosedOwnership = spearson.correlation.spearman(arquivoPullRequestClosed, arquivoOwnership);
            var prclosedExperience = spearson.correlation.spearman(arquivoPullRequestClosed, arquivoExperience);
            
            var prclosedcommentPROpen = spearson.correlation.spearman(arquivoCommentPullRequestClosed, arquivoPullRequestOpen);
            var prclosedcommentCommentOpen = spearson.correlation.spearman(arquivoCommentPullRequestClosed, arquivoCommentPullRequestOpen);
            var prclosedcommentOwnership = spearson.correlation.spearman(arquivoCommentPullRequestClosed, arquivoOwnership);
            var prclosedcommentExperience = spearson.correlation.spearman(arquivoCommentPullRequestClosed, arquivoExperience);
            
            var propenCommentOpen = spearson.correlation.spearman(arquivoPullRequestOpen, arquivoCommentPullRequestOpen);
            var propenOwnership = spearson.correlation.spearman(arquivoPullRequestOpen, arquivoOwnership);
            var propenExperience = spearson.correlation.spearman(arquivoPullRequestOpen, arquivoExperience);
            
            var propencommentOwnership = spearson.correlation.spearman(arquivoCommentPullRequestOpen, arquivoOwnership);
            var propencommentExperience = spearson.correlation.spearman(arquivoCommentPullRequestOpen, arquivoExperience);
            
            var ownershipExperience = spearson.correlation.spearman(arquivoOwnership, arquivoExperience);
            
            var data = [
              {
                z: [[corrEntDef, corrEntMod,corrEntAdd, corrEntRem, corrEntPullReqClosed, corrEntPullReqClosedComment, corrEntPullReqOpen, corrEntPullReqOpenComment, corrEntOwner, corrEntExp],
                    [null,defLinMod,defLinAdd,defLinRemove,defPRClosed,defCommentClosed,defPROpen,defCommentOpen,defOwnership,defExperience], 
                    [null,null,modAdd,modRem,modPRClosed,modCommentClosed,modPROpen,modCommentOpen,modOwnership,modExperience],
                    [null,null,null,addRem,addPRClosed,addCommentClosed,addPROpen,addCommentOpen,addOwnership,addExperience],
                    [null,null,null,null,remPRClosed,remCommentClosed,remPROpen,remCommentOpen,remOwnership,remExperience],
                    [null,null,null,null,null,prclosedCommentClosed,prclosedPROpen,prclosedCommentOpen,prclosedOwnership,prclosedExperience],
                    [null,null,null,null,null,null,prclosedcommentPROpen,prclosedcommentCommentOpen,prclosedcommentOwnership,prclosedcommentExperience],
                    [null,null,null,null,null,null,null,propenCommentOpen,propenOwnership,propenExperience],
                    [null,null,null,null,null,null,null,null,propencommentOwnership,propencommentExperience],
                    [null,null,null,null,null,null,null,null,null,ownershipExperience]
                    ],
                x: ['Defeito','Linhas modificadas','linhas adicionadas','linhas removidas', 'P.R Closed', 'P.R Closed Comment', 'P.R Open', 'P.R Open Comment', 'Owner', 'exp'],
                y: ['Entropia','Defeito','Linhas modificadas','linhas adicionadas','linhas removidas', 'P.R Closed', 'P.R Closed Comment', 'P.R Open', 'P.R Open Comment', 'Owner'],
                type: 'heatmap',
                zmin: -1,
                zmax: 1
              }
            ];

          Plotly.newPlot('fieldHeat', data);
          //Fim HEATMAP
        }
    
        </script>
    
    <script type="text/javascript">
       function gerarVisualizacao3(){    
            var returnedJson;
            var countCommit;
            var listcommit;
            var returnedJsonPull;
            var returnedJsonPullClosed;
            var jsonFilePullRequestOpen;
            var jsonFilePullRequestClosed;
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
            var urlFilePullRequestOpen = 'http://localhost:9090/WebService/webresources/webservicegit/project/getFilePullRequestopenbydate/'+ date1 + '/' + date2 +'/'+ projeto;
            var urlFilePullRequestClosed = 'http://localhost:9090/WebService/webresources/webservicegit/project/getFilePullRequestclosedbydate/'+ date1 + '/' + date2 + '/' + projeto;

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
           
           $.ajax({
               // GET is the default type, no need to specify it
               type: 'GET',
               url:  urlFilePullRequestOpen,
               contentType: "application/json",
               dataType : 'json',
               crossDomain:true,
               async: false,
               success: function(data) {
                    //arquivos de pull request abertos

                   jsonFilePullRequestOpen = data;
                    
               },
               error: function(e){
                    alert('Could not able to find location!' + e);
               }
           });
           
           $.ajax({
               // Lista de arquivos dos pullRequest fechados no periodo
               type: 'GET',
               url: urlFilePullRequestClosed,
               contentType: "application/json",
               dataType : 'json',
               crossDomain:true,
               async: false,
               success: function(data) {

                    jsonFilePullRequestClosed = data;
                    
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
            var mapFilePullRequestClosed = {};//numero de pull request fechado por arquivo
            var mapFileCommentPullRequestClosed = {};//numero de comment pull request fechado por arquivo
            var mapFilePullRequestOpen = {};//numero de pull request fechado por arquivo
            var mapFileCommentPullRequestOpen = {};//numero de comment pull request fechado por arquivo
            var mapOwnershipFile = {}; //quantas vezes arquivo foi comitado pelo owner
            var mapExperienceFile = {}; //quantas vezes arquivo foi comitado pelo mais experiente
            
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
                if(message.toLowerCase().indexOf("bug") !== -1 
                    || message.toLowerCase().indexOf("fix") !== -1
                    || message.toLowerCase().indexOf("postfix") !== -1
                    || message.toLowerCase().indexOf("prefix") !== -1
                    || message.toLowerCase().indexOf("fixes") !== -1)
                {
                    
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
            //FIM CONTAGEM BUGS
            
            //INICIO CONTAGEM PULL REQUEST ABERTO E FECHADO
            //pull fechado comentario e pull por arquivo
            for (i = 0; i < returnedJsonPullClosed.length; i++){
                
                var numComment = returnedJsonPullClosed[i].numComments;
                
                for(j = 0; j < jsonFilePullRequestClosed.length; j++){
                    if(returnedJsonPullClosed[i].nameProject == jsonFilePullRequestClosed[j].nameProjectFilePull && returnedJsonPullClosed[i].numberId == jsonFilePullRequestClosed[j].pullReqNumber){
                        //Verificar os arquivos do pulrequest e contar em quantos pullrequest o arquivo aparece
                        if(jsonFilePullRequestClosed[j].fileName in mapFilePullRequestClosed){
                            mapFilePullRequestClosed[jsonFilePullRequestClosed[j].fileName] = mapFilePullRequestClosed[jsonFilePullRequestClosed[j].fileName] + 1;
                            mapFileCommentPullRequestClosed[jsonFilePullRequestClosed[j].fileName] = mapFileCommentPullRequestClosed[jsonFilePullRequestClosed[j].fileName] + numComment;
                        }else{
                            mapFilePullRequestClosed[jsonFilePullRequestClosed[j].fileName] = 1;
                            mapFileCommentPullRequestClosed[jsonFilePullRequestClosed[j].fileName] = numComment;
                        }
                    }
                }
            }
            
            //pull aberto comentario e pull por arquivo
            for (i = 0; i < returnedJsonPull.length; i++){
                
                var numComment = returnedJsonPull[i].numComments;
                
                for(j = 0; j < jsonFilePullRequestOpen.length; j++){
                    if(returnedJsonPull[i].nameProject == jsonFilePullRequestOpen[j].nameProjectFilePull && returnedJsonPull[i].numberId == jsonFilePullRequestOpen[j].pullReqNumber){
                        //Verificar os arquivos do pulrequest e contar em quantos pullrequest o arquivo aparece
                        if(jsonFilePullRequestOpen[j].fileName in mapFilePullRequestOpen){
                            mapFilePullRequestOpen[jsonFilePullRequestOpen[j].fileName] = mapFilePullRequestOpen[jsonFilePullRequestOpen[j].fileName] + 1;
                            mapFileCommentPullRequestOpen[jsonFilePullRequestOpen[j].fileName] = mapFileCommentPullRequestOpen[jsonFilePullRequestOpen[j].fileName] + numComment;
                        }else{
                            mapFilePullRequestOpen[jsonFilePullRequestOpen[j].fileName] = 1;
                            mapFileCommentPullRequestOpen[jsonFilePullRequestOpen[j].fileName] = numComment;
                        }
                    }
                }
            }
            
            //Colocar valor 0 de pull req fechado para os demais arquivos
            for(var name in mapFiles){
                if(name in mapFilePullRequestClosed){
                    
                }else{
                    mapFilePullRequestClosed[name] = 0;
                    mapFileCommentPullRequestClosed[name] = 0;
                }
                
                if(name in mapFilePullRequestOpen){
                    
                }else{
                    mapFilePullRequestOpen[name] = 0;
                    mapFileCommentPullRequestOpen[name] = 0;
                }
            }
            
            //for(var name in mapFilePullRequestOpen){
                //console.log(name + " : " + mapFilePullRequestOpen[name]);
            //}
            //FIM CONTAGEM PULL ABERTO E FECHADO E COMENTARIOS
            
            
            //CONTAR QUANTIDADE DE COMMITS DE CADA AUTOR
            var mapAuthorship = {}; //Armazenar quantidade de commits de cada autor
            var countAuthor = 0;
            for (i = 0; i < listcommit.length; i++) {
                var author = listcommit[i].author;
                
                if (author in mapAuthorship){
                    mapAuthorship[author] = mapAuthorship[author] + 1;
                }else{
                    mapAuthorship[author] = 1;
                    countAuthor = countAuthor +1
                }
            }
            
            var authortext = document.getElementById('numberauthor2');
            authortext.innerHTML = countAuthor;
            
            var nameOwner;
            var maxvalue = 0;
            for(var name in mapAuthorship){
                if(mapAuthorship[name] > maxvalue){
                    nameOwner = name;
                    maxvalue = mapAuthorship[name];
                }
            }
            
            var authorownertext = document.getElementById('ownership2');
            authorownertext.innerHTML = nameOwner;
            
            var authorownernumbertext = document.getElementById('numberownership2');
            authorownernumbertext.innerHTML = mapAuthorship[nameOwner];
            
            console.log(mapAuthorship);
            console.log(nameOwner);
            
            //contar quantas vezes cada arquivo foi commitado pelo owner
            for (i = 0; i < listcommit.length; i++) {
                var shacommit = listcommit[i].sha;
                //quais arquivos foram comitados pelo owner do periodo
                if(listcommit[i].author == nameOwner){
                    
                    for (j = 0; j < returnedJson.length; j++) {
                        //ver quais arquivos tem o mesmo sha e incrementar no map
                        if(shacommit === returnedJson[j].shaFile){
                            if(returnedJson[j].nameFile in mapOwnershipFile){
                                mapOwnershipFile[returnedJson[j].nameFile] = mapOwnershipFile[returnedJson[j].nameFile] + 1;
                            }else{
                                mapOwnershipFile[returnedJson[j].nameFile] = 1;
                            }
                        }
                    }
                }
            }
            //setar 0 para os demais arquivo que nao entraram na lista
            for (i = 0; i < returnedJson.length; i++) { 
                if(!(returnedJson[i].nameFile in mapOwnershipFile)){
                    mapOwnershipFile[returnedJson[i].nameFile] = 0;
                }
            }
            
            console.log(mapOwnershipFile);
            //FIM OWNERSHIP
            
            //CONTAR EXPERIENCE DE CADA AUTOR EM UM PERIODO
            var mapExperience = {};//armazena experience de cada autor
            for (i = 0; i < listcommit.length; i++) {
                var shacommit = listcommit[i].sha;
                for (j = 0; j < returnedJson.length; j++) {
                        //ver quais arquivos tem o mesmo sha e incrementar no map
                    if(shacommit === returnedJson[j].shaFile){
                        
                        if(listcommit[i].author in mapExperience){
                            mapExperience[listcommit[i].author] = mapExperience[listcommit[i].author] + returnedJson[j].lineChanged;
                        }else{
                            mapExperience[listcommit[i].author] = returnedJson[j].lineChanged;
                        }
                        
                    }
                }
                
            }
            
            var nameSenior;
            var maxvalueex = 0;
            for(var name in mapExperience){
                if(mapExperience[name] > maxvalueex){
                    nameSenior = name;
                    maxvalueex = mapExperience[name];
                }
            }
            
            var authorexptext = document.getElementById('experience2');
            authorexptext.innerHTML = nameSenior;
            
             //contar quantas vezes cada arquivo foi commitado pelo usuario com mais experiencia
            for (i = 0; i < listcommit.length; i++) {
                var shacommit = listcommit[i].sha;
                //quais arquivos foram comitados pelo usuario com mais experiencia
                if(listcommit[i].author == nameSenior){
                    
                    for (j = 0; j < returnedJson.length; j++) {
                        //ver quais arquivos tem o mesmo sha e incrementar no map
                        if(shacommit === returnedJson[j].shaFile){
                            if(returnedJson[j].nameFile in mapExperienceFile){
                                mapExperienceFile[returnedJson[j].nameFile] = mapExperienceFile[returnedJson[j].nameFile] + 1;
                            }else{
                                mapExperienceFile[returnedJson[j].nameFile] = 1;
                            }
                        }
                    }
                }
            }
            
            //setar 0 para os demais arquivo que nao entraram na lista
            for (i = 0; i < returnedJson.length; i++) { 
                if(!(returnedJson[i].nameFile in mapExperienceFile)){
                    mapExperienceFile[returnedJson[i].nameFile] = 0;
                }
            }
            
            console.log(mapExperience);
            console.log(nameSenior);
            //FIM EXPERIENCE
            
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
                var cell7 = row.insertCell(6);
                var cell8 = row.insertCell(7);
                var cell9 = row.insertCell(8);
                var cell10 = row.insertCell(9);
                var cell11 = row.insertCell(10);
                var cell12 = row.insertCell(11);

                cell1.innerHTML = name;
                cell2.innerHTML = mapFiles[name];
                cell3.innerHTML = mapFilesAdded[name];
                cell4.innerHTML = mapFilesRemoved[name];
                cell5.innerHTML = mapFilesChanged[name];
                cell6.innerHTML = mapFileBug[name];
                cell7.innerHTML = mapFilePullRequestClosed[name];
                cell8.innerHTML = mapFileCommentPullRequestClosed[name];
                cell9.innerHTML = mapFilePullRequestOpen[name];
                cell10.innerHTML = mapFileCommentPullRequestOpen[name];
                cell11.innerHTML = mapOwnershipFile[name];
                cell12.innerHTML = mapExperienceFile[name];
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
                minColor: '#0d0',
                midColor: '#ddd',
                maxColor: '#f00',
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
                minColor: '#0d0',
                midColor: '#ddd',
                maxColor: '#f00',
                headerHeight: 15,
                fontColor: 'black',
                showScale: true
              });
              
              function myReadyHandler(){
                document.getElementById("div_treemap_files2").style.display = "none"; 
              }

            }
            //Fim treemap
            
            //TIMELINE GRAFICO
            //array para guardar os dados que serão plotados (quatidade de arquivos modificados por tempo)
            var arrayLine = [
                        ['Periodo', 'Quantidade de Arquivos','Quantidade de commits', 'Commits Owner']
                        
                      ];
            var arrayLine2 = [
                        ['Periodo', 'Linhas modificadas','linhas adicionadas', 'linhas removidas']
                        
                      ];
                      
            var arrayLine3 = [
                        ['Periodo', 'P.R closed','P.R open', 'P.R closed Comment', 'P.R open Comme']
                        
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
                var contaPullRequestFechado = 0;
                var contaPullRequestAberto = 0;
                var contaCommentPullRequestFechado = 0;
                var contaCommentPullRequestAberto = 0;
                var contaCommitOwner = 0;
                
                //Contar commit e linhas a cada 15 dias
                for (i = 0; i < listcommit.length; i++) {
                    var dateString = listcommit[i].dateCreate;
                    var date = new Date(dateString);
                    
                    if(date < dPeriodo && date >= dInicio){
                        contaCommit = contaCommit + 1;
                        var shaCommit = listcommit[i].sha;
                        
                        if(listcommit[i].author == nameOwner){
                            contaCommitOwner = contaCommitOwner + 1; 
                        }
                        
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
                
                //Pull request fechado a cada 15 dias
                for (i = 0; i < returnedJsonPullClosed.length; i++){
                    var dateString = returnedJsonPullClosed[i].dateClose;
                    var date = new Date(dateString);
                    
                    if(date < dPeriodo && date >= dInicio){
                        contaPullRequestFechado = contaPullRequestFechado + 1;
                        contaCommentPullRequestFechado = contaCommentPullRequestFechado + returnedJsonPullClosed[i].numComments;
                    }
                }
                
                //Pull Request aberto a cada 15 dias
                for (i = 0; i < returnedJsonPull.length; i++){
                    var dateString = returnedJsonPull[i].dateCreate;
                    var date = new Date(dateString);
                    
                    if(date < dPeriodo && date >= dInicio){
                        contaPullRequestAberto = contaPullRequestAberto + 1;
                        contaCommentPullRequestAberto = contaCommentPullRequestAberto + returnedJsonPull[i].numComments;
                    }
                }
                
                arrayLine.push([numPeriodo.toString(), contaArquivo, contaCommit, contaCommitOwner]);
                arrayLine2.push([numPeriodo.toString(), contaModificada, contaAdicionada, contaRemovida]);
                arrayLine3.push([numPeriodo.toString(), contaPullRequestFechado, contaPullRequestAberto, contaCommentPullRequestFechado, contaCommentPullRequestAberto]);
                //Avançar 15 dias no periodo
                dInicio.setDate(dInicio.getDate() + 15);
                dPeriodo.setDate(dPeriodo.getDate() + 15);
            }
            
            google.charts.load('current', {'packages':['corechart']});
            google.charts.setOnLoadCallback(drawChart2);

            function drawChart2() {
              var data = google.visualization.arrayToDataTable(arrayLine);

              var options = {
                title: 'Quantidade de mudança',
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
            
            google.charts.load('current', {'packages':['corechart']});
            google.charts.setOnLoadCallback(drawChart2Pull);

            function drawChart2Pull() {
              var data = google.visualization.arrayToDataTable(arrayLine3);
              document.getElementById("div_chart_curve2pullreq").style.display = "block"; 
              
              var options = {
                title: 'Pull Request Abertos e Fechados',
                curveType: 'function',
                legend: { position: 'bottom' }
              };

              var chart = new google.visualization.LineChart(document.getElementById('curve_chart2pullreq'));
              google.visualization.events.addListener(chart, 'ready', myReadyHandler);
              
              function myReadyHandler(){
                document.getElementById("div_chart_curve2pullreq").style.display = "none"; 
              }

              chart.draw(data, options);
            }
            //FIM TIMELINE GRAFICO
            
            //heatmap
            //inicio heatmap utvilizar spearman
            var arquivoEntropia = []; //array para guardar a entropia com indexes numerico para files
            var arquivoDefeito = [];//array para guardar o numero de defeitos com indexes numerico para file
            var arquivoModificada = [];//array para guardar o numero de linhas modficadas com indexes numerico para file
            var arquivoAdicionado = [];
            var arquivoRemovido = [];
            var arquivoPullRequestClosed = [];
            var arquivoPullRequestOpen = [];
            var arquivoCommentPullRequestClosed = [];
            var arquivoCommentPullRequestOpen = [];
            var arquivoOwnership = [];
            var arquivoExperience = [];
            
            for (var name in mapFiles) {
                arquivoEntropia.push(mapFiles[name]);
                arquivoDefeito.push(mapFileBug[name]);
                arquivoModificada.push(mapFilesChanged[name]);
                arquivoAdicionado.push(mapFilesAdded[name]);
                arquivoRemovido.push(mapFilesRemoved[name]);
                
                arquivoPullRequestClosed.push(mapFilePullRequestClosed[name]);//numero de pull request fechado por arquivo
                arquivoPullRequestOpen.push(mapFilePullRequestOpen[name]);//numero de pull request fechado por arquivo
                arquivoCommentPullRequestClosed.push(mapFileCommentPullRequestClosed[name]);//numero de comment pull request fechado por arquivo
                arquivoCommentPullRequestOpen.push(mapFileCommentPullRequestOpen[name]);//numero de comment pull request fechado por arquivo
                arquivoOwnership.push(mapOwnershipFile[name]);
                arquivoExperience.push(mapExperienceFile[name]);
            }
            
            var corrEntDef = spearson.correlation.spearman(arquivoEntropia, arquivoDefeito);
            var corrEntMod = spearson.correlation.spearman(arquivoEntropia, arquivoModificada);
            var corrEntAdd = spearson.correlation.spearman(arquivoEntropia, arquivoAdicionado);
            var corrEntRem = spearson.correlation.spearman(arquivoEntropia, arquivoRemovido);
            var corrEntPullReqClosed = spearson.correlation.spearman(arquivoEntropia, arquivoPullRequestClosed);
            var corrEntPullReqClosedComment = spearson.correlation.spearman(arquivoEntropia, arquivoCommentPullRequestClosed);
            var corrEntPullReqOpen = spearson.correlation.spearman(arquivoEntropia, arquivoPullRequestOpen);
            var corrEntPullReqOpenComment = spearson.correlation.spearman(arquivoEntropia, arquivoCommentPullRequestOpen);
            var corrEntOwner = spearson.correlation.spearman(arquivoEntropia, arquivoOwnership);
            var corrEntExp = spearson.correlation.spearman(arquivoEntropia, arquivoExperience);
            
            var defLinMod = spearson.correlation.spearman(arquivoDefeito, arquivoModificada);
            var defLinAdd = spearson.correlation.spearman(arquivoDefeito, arquivoAdicionado);
            var defLinRemove = spearson.correlation.spearman(arquivoDefeito, arquivoRemovido);
            var defPRClosed = spearson.correlation.spearman(arquivoDefeito, arquivoPullRequestClosed);
            var defCommentClosed = spearson.correlation.spearman(arquivoDefeito, arquivoCommentPullRequestClosed);
            var defPROpen = spearson.correlation.spearman(arquivoDefeito, arquivoPullRequestOpen);
            var defCommentOpen = spearson.correlation.spearman(arquivoDefeito, arquivoCommentPullRequestOpen);
            var defOwnership = spearson.correlation.spearman(arquivoDefeito, arquivoOwnership);
            var defExperience = spearson.correlation.spearman(arquivoDefeito, arquivoExperience);
            
            var modAdd = spearson.correlation.spearman(arquivoModificada, arquivoAdicionado);
            var modRem = spearson.correlation.spearman(arquivoModificada, arquivoRemovido);
            var modPRClosed = spearson.correlation.spearman(arquivoModificada, arquivoPullRequestClosed);
            var modCommentClosed = spearson.correlation.spearman(arquivoModificada, arquivoCommentPullRequestClosed);
            var modPROpen = spearson.correlation.spearman(arquivoModificada, arquivoPullRequestOpen);
            var modCommentOpen = spearson.correlation.spearman(arquivoModificada, arquivoCommentPullRequestOpen);
            var modOwnership = spearson.correlation.spearman(arquivoModificada, arquivoOwnership);
            var modExperience = spearson.correlation.spearman(arquivoModificada, arquivoExperience);
            
            var addRem = spearson.correlation.spearman(arquivoAdicionado, arquivoRemovido);
            var addPRClosed = spearson.correlation.spearman(arquivoAdicionado, arquivoPullRequestClosed);
            var addCommentClosed = spearson.correlation.spearman(arquivoAdicionado, arquivoCommentPullRequestClosed);
            var addPROpen = spearson.correlation.spearman(arquivoAdicionado, arquivoPullRequestOpen);
            var addCommentOpen = spearson.correlation.spearman(arquivoAdicionado, arquivoCommentPullRequestOpen);
            var addOwnership = spearson.correlation.spearman(arquivoAdicionado, arquivoOwnership);
            var addExperience = spearson.correlation.spearman(arquivoAdicionado, arquivoExperience);
            
            var remPRClosed = spearson.correlation.spearman(arquivoRemovido, arquivoPullRequestClosed);
            var remCommentClosed = spearson.correlation.spearman(arquivoRemovido, arquivoCommentPullRequestClosed);
            var remPROpen = spearson.correlation.spearman(arquivoRemovido, arquivoPullRequestOpen);
            var remCommentOpen = spearson.correlation.spearman(arquivoRemovido, arquivoCommentPullRequestOpen);
            var remOwnership = spearson.correlation.spearman(arquivoRemovido, arquivoOwnership);
            var remExperience = spearson.correlation.spearman(arquivoRemovido, arquivoExperience);
            
            var prclosedCommentClosed = spearson.correlation.spearman(arquivoPullRequestClosed, arquivoCommentPullRequestClosed);
            var prclosedPROpen = spearson.correlation.spearman(arquivoPullRequestClosed, arquivoPullRequestOpen);
            var prclosedCommentOpen = spearson.correlation.spearman(arquivoPullRequestClosed, arquivoCommentPullRequestOpen);
            var prclosedOwnership = spearson.correlation.spearman(arquivoPullRequestClosed, arquivoOwnership);
            var prclosedExperience = spearson.correlation.spearman(arquivoPullRequestClosed, arquivoExperience);
            
            var prclosedcommentPROpen = spearson.correlation.spearman(arquivoCommentPullRequestClosed, arquivoPullRequestOpen);
            var prclosedcommentCommentOpen = spearson.correlation.spearman(arquivoCommentPullRequestClosed, arquivoCommentPullRequestOpen);
            var prclosedcommentOwnership = spearson.correlation.spearman(arquivoCommentPullRequestClosed, arquivoOwnership);
            var prclosedcommentExperience = spearson.correlation.spearman(arquivoCommentPullRequestClosed, arquivoExperience);
            
            var propenCommentOpen = spearson.correlation.spearman(arquivoPullRequestOpen, arquivoCommentPullRequestOpen);
            var propenOwnership = spearson.correlation.spearman(arquivoPullRequestOpen, arquivoOwnership);
            var propenExperience = spearson.correlation.spearman(arquivoPullRequestOpen, arquivoExperience);
            
            var propencommentOwnership = spearson.correlation.spearman(arquivoCommentPullRequestOpen, arquivoOwnership);
            var propencommentExperience = spearson.correlation.spearman(arquivoCommentPullRequestOpen, arquivoExperience);
            
            var ownershipExperience = spearson.correlation.spearman(arquivoOwnership, arquivoExperience);
            
            var data = [
              {
                z: [[corrEntDef, corrEntMod,corrEntAdd, corrEntRem, corrEntPullReqClosed, corrEntPullReqClosedComment, corrEntPullReqOpen, corrEntPullReqOpenComment, corrEntOwner, corrEntExp],
                    [null,defLinMod,defLinAdd,defLinRemove,defPRClosed,defCommentClosed,defPROpen,defCommentOpen,defOwnership,defExperience], 
                    [null,null,modAdd,modRem,modPRClosed,modCommentClosed,modPROpen,modCommentOpen,modOwnership,modExperience],
                    [null,null,null,addRem,addPRClosed,addCommentClosed,addPROpen,addCommentOpen,addOwnership,addExperience],
                    [null,null,null,null,remPRClosed,remCommentClosed,remPROpen,remCommentOpen,remOwnership,remExperience],
                    [null,null,null,null,null,prclosedCommentClosed,prclosedPROpen,prclosedCommentOpen,prclosedOwnership,prclosedExperience],
                    [null,null,null,null,null,null,prclosedcommentPROpen,prclosedcommentCommentOpen,prclosedcommentOwnership,prclosedcommentExperience],
                    [null,null,null,null,null,null,null,propenCommentOpen,propenOwnership,propenExperience],
                    [null,null,null,null,null,null,null,null,propencommentOwnership,propencommentExperience],
                    [null,null,null,null,null,null,null,null,null,ownershipExperience]
                    ],
                x: ['Defeito','Linhas modificadas','linhas adicionadas','linhas removidas', 'P.R Closed', 'P.R Closed Comment', 'P.R Open', 'P.R Open Comment', 'Owner', 'exp'],
                y: ['Entropia','Defeito','Linhas modificadas','linhas adicionadas','linhas removidas', 'P.R Closed', 'P.R Closed Comment', 'P.R Open', 'P.R Open Comment', 'Owner'],
                type: 'heatmap',
                zmin: -1,
                zmax: 1
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
        document.getElementById("report").style.display = "none";
        document.getElementById("filter").style.display = "none";
        document.getElementById("div_table").style.display = "none";
        document.getElementById("div_treemap_files").style.display = "none";
        document.getElementById("div_search").style.display = "none";
        document.getElementById("div_button_treemap").style.display = "none";
        document.getElementById("divHeat").style.display = "none";
        document.getElementById("div_button_curve").style.display = "none";
        document.getElementById("div_button_curveLines").style.display = "none";
        document.getElementById("div_button_curvepullreq").style.display = "none";
        document.getElementById("div_chart_curve").style.display = "none";
        document.getElementById("div_chart_curvelines").style.display = "none";
        document.getElementById("div_chart_curvepullreq").style.display = "none";
        
        document.getElementById("div_combo2").style.display = "block";
        document.getElementById("div_data_inicial2").style.display = "block";
        document.getElementById("div_data_final2").style.display = "block";
        document.getElementById("div_button2").style.display = "block";
        document.getElementById("report2").style.display = "block";
        document.getElementById("filter2").style.display = "block";
        document.getElementById("div_table2").style.display = "block";
        document.getElementById("div_button_treemap2").style.display = "block";
        document.getElementById("divHeat2").style.display = "block";
        document.getElementById("div_chart_curve2").style.display = 'block';
        document.getElementById("div_chart_curve2lines").style.display = 'none';
        document.getElementById("div_chart_curve2pullreq").style.display = 'none';
        document.getElementById("div_button_curve2").style.display = 'block';
        document.getElementById("div_button_curve2Lines").style.display = 'block';
        document.getElementById("div_button_curve2pullreq").style.display = 'block';
        
        if(optionTreemapDisplay == "showByPackage"){
            document.getElementById("div_treemap2").style.display = "block";
        }else{
            document.getElementById("div_treemap_files2").style.display = "block";
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
        document.getElementById("report2").style.display = "none";
        document.getElementById("filter2").style.display = "none";
        document.getElementById("div_table2").style.display = "none";
        document.getElementById("div_treemap_files2").style.display = "none";
        document.getElementById("div_search").style.display = "none";
        document.getElementById("div_button_treemap2").style.display = "none";
        document.getElementById("divHeat2").style.display = "none";  
        document.getElementById("div_chart_curve2").style.display = 'none';
        document.getElementById("div_chart_curve2lines").style.display = 'none';
        document.getElementById("div_chart_curve2pullreq").style.display = 'none';
        document.getElementById("div_button_curve2").style.display = 'none';
        document.getElementById("div_button_curve2Lines").style.display = 'none';
        document.getElementById("div_button_curve2pullreq").style.display = 'none';
        
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
        document.getElementById("div_button_curveLines").style.display = "block";
        document.getElementById("div_button_curvepullreq").style.display = "block";
        document.getElementById("div_chart_curve").style.display = "block";
        document.getElementById("div_chart_curvelines").style.display = "none";
        document.getElementById("div_chart_curvepullreq").style.display = "none";
        
        if(optionTreemapDisplay == "showByPackage"){
            document.getElementById("div_treemap").style.display = "block";
        }else{
            document.getElementById("div_treemap_files").style.display = "block";
        }
        
    }
    
    function showhome(){
        document.getElementById("div_search").style.display = "block";
        
        document.getElementById("div_combo2").style.display = "none";
        document.getElementById("div_data_inicial2").style.display = "none";
        document.getElementById("div_data_final2").style.display = "none";
        document.getElementById("div_button2").style.display = "none";
        document.getElementById("div_treemap2").style.display = "none";
        document.getElementById("report2").style.display = "none";
        document.getElementById("filter2").style.display = "none";
        document.getElementById("div_table2").style.display = "none";
        document.getElementById("div_treemap_files2").style.display = "none";
        document.getElementById("div_button_treemap2").style.display = "none";
        document.getElementById("divHeat2").style.display = "none";
        
        document.getElementById("div_chart_curve2").style.display = 'none';
        document.getElementById("div_chart_curve2lines").style.display = 'none';
        document.getElementById("div_chart_curve2pullreq").style.display = 'none';
        document.getElementById("div_button_curve2").style.display = 'none';
        document.getElementById("div_button_curve2Lines").style.display = 'none';
        document.getElementById("div_button_curve2pullreq").style.display = 'none';
        
        document.getElementById("div_combo").style.display = "none";
        document.getElementById("div_data_inicial").style.display = "none";
        document.getElementById("div_data_final").style.display = "none";
        document.getElementById("div_button").style.display = "none";
        document.getElementById("div_treemap").style.display = "none";
        document.getElementById("report").style.display = "none";
        document.getElementById("filter").style.display = "none";
        document.getElementById("div_table").style.display = "none";
        document.getElementById("div_treemap_files").style.display = "none";
        document.getElementById("div_button_treemap").style.display = "none";
        document.getElementById("divHeat").style.display = "none";
        document.getElementById("div_button_curve").style.display = "none";
        document.getElementById("div_button_curveLines").style.display = "none";
        document.getElementById("div_button_curvepullreq").style.display = "none";
        document.getElementById("div_chart_curve").style.display = "none";
        document.getElementById("div_chart_curvelines").style.display = "none";
        document.getElementById("div_chart_curvepullreq").style.display = "none";
    }
    
    function showtreemap(){
        showhome();
        document.getElementById("div_search").style.display = "none";
        
        document.getElementById("div_combo2").style.display = "block";
        document.getElementById("div_data_inicial2").style.display = "block";
        document.getElementById("div_data_final2").style.display = "block";
        document.getElementById("div_treemap_files2").style.display = "block";
        document.getElementById("div_button_treemap2").style.display = "block";
        
        document.getElementById("div_combo").style.display = "block";
        document.getElementById("div_data_inicial").style.display = "block";
        document.getElementById("div_data_final").style.display = "block";
        document.getElementById("div_treemap_files").style.display = "block";
        document.getElementById("div_button_treemap").style.display = "block";
    }
    
    function showlinechart(){
        showhome();
        document.getElementById("div_search").style.display = "none";
        
        document.getElementById("div_combo2").style.display = "block";
        document.getElementById("div_data_inicial2").style.display = "block";
        document.getElementById("div_data_final2").style.display = "block";
        document.getElementById("div_button_curve2").style.display = 'block';
        document.getElementById("div_button_curve2Lines").style.display = 'block';
        document.getElementById("div_button_curve2pullreq").style.display = 'block';
        document.getElementById("div_chart_curve2").style.display = "block";
        
        document.getElementById("div_combo").style.display = "block";
        document.getElementById("div_data_inicial").style.display = "block";
        document.getElementById("div_data_final").style.display = "block";
        document.getElementById("div_button_curve").style.display = "block";
        document.getElementById("div_button_curveLines").style.display = "block";
        document.getElementById("div_button_curvepullreq").style.display = "block";
        document.getElementById("div_chart_curve").style.display = "block";
    }
    
    function showheatmap(){
        showhome();
        document.getElementById("div_search").style.display = "none";
        
        document.getElementById("div_combo2").style.display = "block";
        document.getElementById("div_data_inicial2").style.display = "block";
        document.getElementById("div_data_final2").style.display = "block";
        document.getElementById("divHeat2").style.display = "block";
        
        document.getElementById("div_combo").style.display = "block";
        document.getElementById("div_data_inicial").style.display = "block";
        document.getElementById("div_data_final").style.display = "block";
        document.getElementById("divHeat").style.display = "block";
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
    
    function changeFileChart(){
            document.getElementById("div_chart_curve").style.display = 'block';
            document.getElementById("div_chart_curvelines").style.display = 'none';
            document.getElementById("div_chart_curvepullreq").style.display = 'none';
    }
    
    function changeLineChart(){
            document.getElementById("div_chart_curve").style.display = 'none';
            document.getElementById("div_chart_curvelines").style.display = 'block';
            document.getElementById("div_chart_curvepullreq").style.display = 'none';
    }
    
    function changePullReqChart(){
            document.getElementById("div_chart_curve").style.display = 'none';
            document.getElementById("div_chart_curvelines").style.display = 'none';
            document.getElementById("div_chart_curvepullreq").style.display = 'block';
    }
    
    function changeFileChart2(){
            document.getElementById("div_chart_curve2").style.display = 'block';
            document.getElementById("div_chart_curve2lines").style.display = 'none';
            document.getElementById("div_chart_curve2pullreq").style.display = 'none';
    }
    
    function changeLineChart2(){
            document.getElementById("div_chart_curve2").style.display = 'none';
            document.getElementById("div_chart_curve2lines").style.display = 'block';
            document.getElementById("div_chart_curve2pullreq").style.display = 'none';
    }
    
    function changePullReqChart2(){
            document.getElementById("div_chart_curve2").style.display = 'none';
            document.getElementById("div_chart_curve2lines").style.display = 'none';
            document.getElementById("div_chart_curve2pullreq").style.display = 'block';
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
    
    </body>
</html>
