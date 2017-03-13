/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Buscar;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.eclipse.egit.github.core.Repository;
import org.eclipse.egit.github.core.RepositoryCommit;
import org.eclipse.egit.github.core.client.GitHubClient;
import org.eclipse.egit.github.core.service.CommitService;
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
        String op = request.getParameter("op"); //nome do botao submit
        String name = request.getParameter("namerepo");//pegar parametro nome do jsp
        String password = request.getParameter("idrepo");//pegar parametro password do jsp
        System.out.println(name + "----" + password);
        
        GitHubClient client = new GitHubClient();
        client.setCredentials("TiagoUmemura", "umemura93765520");
        
        CommitService serviceCommit = new CommitService();
        RepositoryService service = new RepositoryService();
        
        //for (Repository repo : service.getRepositories("TiagoUmemura")){
            //System.out.println(repo.getName() + " Watchers: " + repo.getWatchers());
            //for(RepositoryCommit commit : serviceCommit.getCommits(repo)){
                //System.out.println("Sha commit:" + commit.getSha());
            //}
        //}
        
        Repository repoExample = service.getRepository("TiagoUmemura", "Algoritmo-de-Djkistra-em-Java");
        for(RepositoryCommit commit : serviceCommit.getCommits(repoExample)){
            System.out.println("Sha commit: " + commit.getSha());
        }
        
        Runtime.getRuntime().exec("java -jar cm.jar /home/tiago/NetBeansProjects/WebApplicationTCC2/Algoritmo-de-Djkistra-em-Java /home/tiago/NetBeansProjects/WebApplicationTCC2/teste.csv single");
        
        response.sendRedirect("buscar.jsp");//redirect para mandar pra outra pagina
    }

}
