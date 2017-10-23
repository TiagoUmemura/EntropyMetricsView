/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ws;

import Buscar.DAO;
import com.google.gson.Gson;
import com.sun.jersey.api.json.JSONWithPadding;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.UriInfo;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PUT;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.GenericEntity;
import modelo.Commit;
import modelo.File;
import modelo.PullRequest;

/**
 * REST Web Service
 *
 * @author tiago
 */
@Path("webservicegit")
public class WS {

    @Context
    private UriInfo context;

    /**
     * Creates a new instance of WS
     */
    public WS() {
    }

    /**
     * Retrieves representation of an instance of ws.WS
     * @return an instance of java.lang.String
     */
    @GET
    @Produces("application/json")
    public String getJson() {
        //TODO return proper representation object
        return "teste";
    }
    
    @GET
    @Produces("application/json")
    @Path("project/getcommits")
    public String getCommits() {
        //TODO return proper representation object
        List<Commit> lista = new ArrayList<Commit>(); 
        
        lista = DAO.listCommit();
        
        Gson g = new Gson();
        return g.toJson(lista);
    }
    
    @GET
    @Produces("application/json")
    @Path("project/getcommitsbydate/{datainicio}/{datafim}/{nomeprojeto}")
    public String getCommitsByDate(@PathParam("datainicio") String dataInicio, @PathParam("datafim") String dataFim, @PathParam("nomeprojeto") String nomeprojeto) {
        //TODO return proper representation object
        List<Commit> lista = new ArrayList<Commit>(); 
        
        lista = DAO.listCommitByDate(dataInicio, dataFim, nomeprojeto);
        
        Gson g = new Gson();
        return g.toJson(lista);
    }
    
    //commit por nome e intervalo de datas
    @GET
    @Produces("application/json")
    @Path("project/getfilesbydate/{datainicio}/{datafim}/{nomeprojeto}")
    public String getFilesByDate(@PathParam("datainicio") String dataInicio, @PathParam("datafim") String dataFim, @PathParam("nomeprojeto") String nomeprojeto) {
        //TODO return proper representation object
        List<File> lista = new ArrayList<File>(); 
        
        lista = DAO.listFileByDate(dataInicio, dataFim, nomeprojeto);
        
        Gson g = new Gson();
        return g.toJson(lista);
    }
    
    @GET
    @Produces("application/json")
    @Path("project/getcountcommitbydate/{datainicio}/{datafim}/{nomeprojeto}")
    public String getCountCommitByDate(@PathParam("datainicio") String dataInicio, @PathParam("datafim") String dataFim, @PathParam("nomeprojeto") String nomeprojeto) {
        //TODO return proper representation object
        int number;
        
        number = DAO.countCommitByDate(dataInicio, dataFim, nomeprojeto);
        
        String jsonReturn = "[{\"numbercommit\":" + number + "}]";
        //Gson g = new Gson();
        
        return jsonReturn;
    }
    
    @GET
    @Produces("application/javascript")
    @Path("project/getfiles")
    public String getFiles() {
        //TODO return proper representation object
        List<File> lista = new ArrayList<File>(); 
        
        lista = DAO.listFile();
        
        Gson g = new Gson();
        return g.toJson(lista);
        
    }
    
    @GET
    @Produces("application/json")
    @Path("project/getPullRequestbydate/{datainicio}/{datafim}/{nomeprojeto}")
    public String getPullRequestByDate(@PathParam("datainicio") String dataInicio, @PathParam("datafim") String dataFim, @PathParam("nomeprojeto") String nomeprojeto) {
        //TODO return proper representation object
        List<PullRequest> lista = new ArrayList<PullRequest>(); 
        
        lista = DAO.listPullRequestByDate(dataInicio, dataFim, nomeprojeto);
        
        Gson g = new Gson();
        return g.toJson(lista);
    }
    
    

    /**
     * PUT method for updating or creating an instance of WS
     * @param content representation for the resource
     * @return an HTTP response with content of the updated or created resource.
     */
    @PUT
    @Consumes("application/json")
    public void putJson(String content) {
    }
}
