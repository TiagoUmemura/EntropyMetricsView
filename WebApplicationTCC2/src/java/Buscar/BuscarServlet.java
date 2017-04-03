/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Buscar;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
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
import org.eclipse.egit.github.core.PullRequest;
import org.eclipse.egit.github.core.Repository;
import org.eclipse.egit.github.core.RepositoryCommit;
import org.eclipse.egit.github.core.User;
import org.eclipse.egit.github.core.client.GitHubClient;
import org.eclipse.egit.github.core.service.CommitService;
import org.eclipse.egit.github.core.service.IssueService;
import org.eclipse.egit.github.core.service.PullRequestService;
import org.eclipse.egit.github.core.service.RepositoryService;

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
//        processRequest(request, response);
        int count = 0;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date dateinicio = new Date();
        Date datefinal = new Date();
            try {
                dateinicio = sdf.parse("2015-12-05");
                datefinal = sdf.parse("2015-12-10");
            } catch (ParseException ex) {
                Logger.getLogger(BuscarServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            
        String op = request.getParameter("op"); //nome do botao submit
        String name = request.getParameter("namerepo");//pegar parametro nome do jsp
        String password = request.getParameter("idrepo");//pegar parametro password do jsp
        System.out.println(name + "----" + password);
        
        GitHubClient client = new GitHubClient();
        client.setOAuth2Token("");
        
        CommitService serviceCommit = new CommitService(client);
        RepositoryService service = new RepositoryService(client);
        PullRequestService servicePullRequest = new PullRequestService(client);
        IssueService serviceissue = new IssueService(client);
        
        //escolhendo repositrio
        //Repository repoExample = service.getRepository("una", "CSSgram");
        Repository repoExample = service.getRepository("TiagoUmemura", "Algoritmo-de-Djkistra-em-Java");
        
        //Todos os repositorios de um usuário
        //for (Repository repo : service.getRepositories("TiagoUmemura")){
            //System.out.println(repo.getName() + " Watchers: " + repo.getWatchers());
            //for(RepositoryCommit commit : serviceCommit.getCommits(repo)){
                //System.out.println("Sha commit:" + commit.getSha());
            //}
        //}
        
        //date está no User commiter (quando é integrado no master) e User author (quando é feito o commit)
        //todos os sha dos commits de um repositorio
        for(RepositoryCommit commit : serviceCommit.getCommits(repoExample)){
            System.out.println("Sha commit: " + commit.getSha());
            Commit commitdate = commit.getCommit();//pegar o tipo commit do repositoryCommit
            CommitUser commituser = commitdate.getCommitter();//pegar o commiter
            System.out.println("date: " + commituser.getDate());//no commiter pegar a data
            
            if(commituser.getDate().after(dateinicio) && commituser.getDate().before(datefinal)){
                count++;
            }
             
        }

        //Todos os pull request de um repositório, commit no pull e arquivos modificados no pull
        //Atencao: int number é o id.
        //state: open, close e all no estado do pull request
        /*for(PullRequest pullreq : servicePullRequest.getPullRequests(repoExample, "open")){
            System.out.println("Date open: " + pullreq.getCreatedAt());
            System.out.println("Date close: " + pullreq.getClosedAt());
            System.out.println("Name:" + pullreq.getTitle());
            
            List<RepositoryCommit> pullcommits = servicePullRequest.getCommits(repoExample, pullreq.getNumber());
            System.out.println("Numero de commits: " + pullcommits.size());
            
            //arquivos modificados no pull
            List<CommitFile> commitfile = servicePullRequest.getFiles(repoExample, pullreq.getNumber());
            for(int i = 0; i < commitfile.size(); i++){
                CommitFile c = commitfile.get(i);
                System.out.println("Name: " + c.getFilename() + " |" + "Linha modificada: " + c.getChanges());
                
            }
        }*/
        System.out.println("Commits:" + count);
        //É possivel pegar todas as modificacoes no pull request? ou somente na lista de commits
        response.sendRedirect("buscar.jsp");//redirect para mandar pra outra pagina
    }

}
