/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Buscar;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.eclipse.egit.github.core.Commit;
import org.eclipse.egit.github.core.CommitFile;
import org.eclipse.egit.github.core.CommitStatus;
import org.eclipse.egit.github.core.CommitUser;
import org.eclipse.egit.github.core.Issue;
import org.eclipse.egit.github.core.PullRequest;
import org.eclipse.egit.github.core.Repository;
import org.eclipse.egit.github.core.RepositoryCommit;
import org.eclipse.egit.github.core.User;
import org.eclipse.egit.github.core.client.GitHubClient;
import org.eclipse.egit.github.core.service.CommitService;
import org.eclipse.egit.github.core.service.IssueService;
import org.eclipse.egit.github.core.service.PullRequestService;
import org.eclipse.egit.github.core.service.RepositoryService;
import org.kohsuke.github.GHCommit;
import org.kohsuke.github.GHRepository;
import org.kohsuke.github.GitHub;

/**
 *
 * @author tiago
 */
@WebServlet(name = "BuscarServlet", urlPatterns = {"/BuscarServlet"})
public class BuscarServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */

        @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
        //calcular metricas para um periodo e armazena-las para depois compara-las com outro periodo
        //parametros: nome, nome projeto, data inicio e data final, depois subdivide o periodo de 15 em 15 dias
        Map<String, Integer> nomesArquivos = new HashMap<String, Integer>();
        int count = 0;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date dateinicio = new Date();
        Date datefinal = new Date();
            try {
                dateinicio = sdf.parse("2016-10-14");
                datefinal = sdf.parse("2016-10-31");
            } catch (ParseException ex) {
                Logger.getLogger(BuscarServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            
        String op = request.getParameter("op"); //nome do botao submit
        String nameuser = request.getParameter("namerepo");//pegar parametro nome do jsp
        String nameproject = request.getParameter("idrepo");//pegar parametro password do jsp
        System.out.println(nameuser + "----" + nameproject);
        
        String projectkohsuke = nameuser + "/" + nameproject;
        //Api egit.core
        GitHubClient client = new GitHubClient();
        client.setOAuth2Token("7fd0f4907677951b9fff94a7dedc2982c0b45c7e");
        
        CommitService serviceCommit = new CommitService(client);
        RepositoryService service = new RepositoryService(client);
        PullRequestService servicePullRequest = new PullRequestService(client);
        IssueService serviceIssue = new IssueService(client);
        
        //API Kohsuke segunda API
        GitHub github = GitHub.connectUsingOAuth("7fd0f4907677951b9fff94a7dedc2982c0b45c7e");
        //GHRepository repo = github.getRepository("TiagoUmemura/Algoritmo-de-Djkistra-em-Java");
        GHRepository repo = github.getRepository(projectkohsuke);
        /*GHCommit commit2 = repo.getCommit("990ed8363c6a2b432ea5ef3b732abcae28ec194e");
        List<GHCommit.File> listarquivos = commit2.getFiles();
        for(int i = 0; i < listarquivos.size(); i++){
            System.out.println("nome do arquivo: " + listarquivos.get(i).getFileName());
            System.out.println("linhas modificadas: " + listarquivos.get(i).getLinesChanged());
        }*/
        
        String nameProject2 = nameuser + "-" + nameproject;
        DAO.addProject(nameProject2);
        //escolhendo repositrio egit
        //Repository repoExample = service.getRepository("una", "CSSgram");
        Repository repoExample = service.getRepository("TiagoUmemura", "Algoritmo-de-Djkistra-em-Java");
        Repository repoExample2 = service.getRepository(nameuser, nameproject);
        
        //date está no User commiter (quando é integrado no master) e User author (quando é feito o commit)
        //todos os sha dos commits de um repositorio
        for(RepositoryCommit commit : serviceCommit.getCommits(repoExample2)){
            //System.out.println("Sha commit: " + commit.getSha());
            Commit commitdate = commit.getCommit();//pegar o tipo commit do repositoryCommit
            CommitUser commituser = commitdate.getCommitter();//pegar o commiter
            
            System.out.println("Commit");
            System.out.println(commit.getSha());
            System.out.println(commituser.getDate());//no commiter pegar a data
            String datecommit = null;

            datecommit = sdf.format(commituser.getDate());

            //chamar DAO
            System.out.println(datecommit);
            System.out.println(commit.getCommit().getCommitter().getName());
            System.out.println(commit.getUrl());
            System.out.println(commit.getCommit().getMessage());//testar
            
            String messageCorrigido = commit.getCommit().getMessage();
            messageCorrigido = messageCorrigido.replace("\'", "");
            messageCorrigido = messageCorrigido.replace("\"", "");
            messageCorrigido =  messageCorrigido.replace(",", "");
            
            DAO.addCommit(nameProject2, messageCorrigido, datecommit, commit.getSha(), commit.getCommit().getAuthor().getName(), commit.getCommit().getUrl());

            try {
                TimeUnit.SECONDS.sleep(1);
            } catch (InterruptedException ex) {
                Logger.getLogger(BuscarServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            //GHCommit API kousuke
            GHCommit commitarq = repo.getCommit(commit.getSha());//passando SHA de uma API para outra
            List<GHCommit.File> listarquivo = commitarq.getFiles();
            for(int i = 0; i < listarquivo.size(); i++){
                //System.out.println("nome do arquivo: " + listarquivo.get(i).getFileName());
                //System.out.println("linhas modificadas: " + listarquivo.get(i).getLinesChanged());
                System.out.println("Arquivos");
                DAO.addFile(listarquivo.get(i).getFileName(), listarquivo.get(i).getLinesChanged(), listarquivo.get(i).getLinesDeleted(), listarquivo.get(i).getLinesAdded(), commit.getSha());
                //setando quantidade de commits que cada arquivo teve

                try {
                    TimeUnit.SECONDS.sleep(1);
                } catch (InterruptedException ex) {
                    Logger.getLogger(BuscarServlet.class.getName()).log(Level.SEVERE, null, ex);
                }

            }

            //contador que conta numero de commits
            count++;
        //}
             
        }
        
        //System.out.println("PullRequests");
        //Todos os pull request de um repositório, commit no pull e arquivos modificados no pull
        //Atencao: int number é o id.
        //state: open, close e all no estado do pull request
        for(PullRequest pullreq : servicePullRequest.getPullRequests(repoExample2, "close")){
            System.out.println("PullRequest");
            System.out.println(sdf.format(pullreq.getCreatedAt()));
            if(pullreq.getClosedAt() != null){
            System.out.println(sdf.format(pullreq.getClosedAt()));
            }
            System.out.println(pullreq.getTitle());
            System.out.println(pullreq.getUser().getLogin());
            
            
            Issue issue = serviceIssue.getIssue(repoExample2, pullreq.getNumber());
            System.out.println(issue.getComments());
            
            try {
                TimeUnit.SECONDS.sleep(1);
            } catch (InterruptedException ex) {
                Logger.getLogger(BuscarServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            
            System.out.println(pullreq.getState());
            System.out.println("");
            
           
            List<RepositoryCommit> pullcommits = servicePullRequest.getCommits(repoExample2, pullreq.getNumber());
            System.out.println(pullcommits.size());
            
            //se merged true entao seta merged 1 no sql se nao 0
            if(pullreq.getMergedAt() != null){
                DAO.addPullRequest(pullreq.getTitle(), pullreq.getUser().getLogin(), pullreq.getNumber(), pullreq.getState(), issue.getComments(), sdf.format(pullreq.getCreatedAt()), sdf.format(pullreq.getClosedAt()), nameProject2, 1);
            }else{
                DAO.addPullRequest(pullreq.getTitle(), pullreq.getUser().getLogin(), pullreq.getNumber(), pullreq.getState(), issue.getComments(), sdf.format(pullreq.getCreatedAt()), sdf.format(pullreq.getClosedAt()), nameProject2, 0);
            }
            
            try {
                TimeUnit.SECONDS.sleep(1);
            } catch (InterruptedException ex) {
                Logger.getLogger(BuscarServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            
            //servicePullRequest.getcomments para pegar os comentarios passar repo name e id getNumber 
            //servicePullRequest.getComments(repoExample, pullreq.getnumber);
            //arquivos modificados no pull
            List<CommitFile> commitfile = servicePullRequest.getFiles(repoExample2, pullreq.getNumber());
            for(int i = 0; i < commitfile.size(); i++){
                CommitFile c = commitfile.get(i);
                
                DAO.addFilesPullRequest(pullreq.getNumber(), c.getFilename(), c.getAdditions(), c.getDeletions(), c.getChanges(), servicePullRequest.getComments(repoExample2, pullreq.getNumber()).size(), nameProject2);
                //System.out.println("Name: " + c.getFilename() + " |" + "Linha modificada: " + c.getChanges());
                //pullrequest file: pullreq number, filename, addittions, deletions, changes
                try {
                TimeUnit.SECONDS.sleep(1);
                } catch (InterruptedException ex) {
                Logger.getLogger(BuscarServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            
            //pegar commits do pullRequst - PullReq .number utilizado para pegar tanto commits quanto files
            System.out.println("Commits do pull ***");
            List<RepositoryCommit> commitspull = servicePullRequest.getCommits(repoExample2, pullreq.getNumber());
            for(int i = 0; i < commitspull.size(); i++){
                
                RepositoryCommit rc = commitspull.get(i);
                Commit c = rc.getCommit();
                
                System.out.println("Pullreq commit sha: " + rc.getSha());
                System.out.println("Pullreq commit author: " + c.getAuthor().getName());
                System.out.println("Pullreq commit date: " + sdf.format(c.getAuthor().getDate()));
                System.out.println("Pullreq commit number: " + pullreq.getNumber());
                System.out.println("Pullreq commit project: " + nameProject2);
                
                DAO.addCommitPullRequest(rc.getSha(), c.getAuthor().getName(), sdf.format(c.getAuthor().getDate()), pullreq.getNumber(), nameProject2, c.getMessage(), c.getUrl());
                
                try {
                TimeUnit.SECONDS.sleep(1);
                } catch (InterruptedException ex) {
                Logger.getLogger(BuscarServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        System.out.println("Commits:" + count);
        
        //printando qtde de commits que cada arquivo foi modificado
        //for (String key : nomesArquivos.keySet()) {
                      
            //Capturamos o valor a partir da chave
            //int value = nomesArquivos.get(key);
            //System.out.println(key + " = " + value);
        //}
        
        response.sendRedirect("buscar.jsp");//redirect para mandar pra outra pagina
    }

}
