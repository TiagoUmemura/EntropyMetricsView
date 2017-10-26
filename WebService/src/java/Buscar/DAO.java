/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Buscar;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import modelo.Commit;
import modelo.File;
import modelo.Project;
import modelo.PullRequest;

/**
 *
 * @author tiago
 */
public class DAO {
    
    private static final String url = "jdbc:mysql://localhost:3306/";
    private static final String dbName = "tcc";
    private static final String driver = "com.mysql.jdbc.Driver";
    private static final String userName = "root";
    private static final String password = "root";
    
    public static List getProject() {

        Connection conexao = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        String returnString = "";
        List<Project> lista = new ArrayList<Project>();
        
        try {
            Class.forName(driver).newInstance();
            conexao = DriverManager.getConnection(url + dbName, userName, password);
            Statement statement = conexao.createStatement();
            String sql = "SELECT * FROM Project";

            rs = statement.executeQuery(sql);

            while (rs.next()) {
                String nome = rs.getString("nameProject");
                
                
                Project p = new Project(nome);
                //Commit c = new Commit("a","a","a","a","a");
                lista.add(p);
                
            }

            return lista;
        } catch (Exception ex) {
            System.out.println("Erro : " + ex.getMessage());
            return lista;
        }
    }
    
    public static void addProject(String nameProject) {
        Connection conexao = null;
        Statement statement = null;

        try {
            Class.forName(driver).newInstance();
            conexao = DriverManager.getConnection(url + dbName, userName, password);
            statement = conexao.createStatement();
            String sql = "INSERT INTO Project(nameProject) VALUES ( '" + nameProject + "') "
                    + "ON DUPLICATE KEY UPDATE nameProject = VALUES(nameProject);";
            statement.execute(sql);
            

        } catch (Exception ex) {
            System.out.println("Erro : " + ex.getMessage());
            
        } finally{
            try {
                if (statement != null) statement.close();
                if (conexao != null) conexao.close();
            } catch (Exception ex) {
                 System.out.println("Erro : " + ex.getMessage());
            }
        }
    }
    
    //definir parametros depois, tipo date ou string na data
    public static void addCommit(String nameProjetoCommit, String messageCommit, String dateCreate,String sha, String author ) {
        Connection conexao = null;
        Statement statement = null;

        try {
            Class.forName(driver).newInstance();
            conexao = DriverManager.getConnection(url + dbName, userName, password);
            statement = conexao.createStatement();
            String sql = "INSERT INTO commit(nameProjetoCommit, messageCommit, dateCreate, sha, author) VALUES ( '" + nameProjetoCommit + "','" + messageCommit + "','" + dateCreate + "','" + sha + "','" + author + "');";
            statement.execute(sql);

        } catch (Exception ex) {
            System.out.println("Erro : " + ex.getMessage());
        } finally{
            try {
                if (statement != null) statement.close();
                if (conexao != null) conexao.close();
            } catch (Exception ex) {
                 System.out.println("Erro : " + ex.getMessage());
            }
        }
    }
    
    public static void addFile(String nameFile, int lineChanged, int lineDeleted,int lineAdd, String sha ) {
        Connection conexao = null;
        Statement statement = null;

        try {
            Class.forName(driver).newInstance();
            conexao = DriverManager.getConnection(url + dbName, userName, password);
            statement = conexao.createStatement();
            String sql = "INSERT INTO files(nameFile, lineChanged, lineDeleted, lineAdd, shaFiles) VALUES ( '" + nameFile + "','" + lineChanged + "','" + lineDeleted + "','" + lineAdd + "','" + sha + "');";
            statement.execute(sql);

        } catch (Exception ex) {
            System.out.println("Erro : " + ex.getMessage());
        } finally{
            try {
                if (statement != null) statement.close();
                if (conexao != null) conexao.close();
            } catch (Exception ex) {
                 System.out.println("Erro : " + ex.getMessage());
            }
        }
    }
    
    public static boolean addPullRequest() {
        Connection conexao = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            Class.forName(driver).newInstance();
            conexao = DriverManager.getConnection(url + dbName, userName, password);
            Statement statement = conexao.createStatement();
            //String sql = "INSERT INTO commit(name, arquivo, title, description, idplayer) VALUES ( '" + trophy.data.name + "'," + trophy.data.xp + ",'" + trophy.data.title + "','" + trophy.data.description + "','" + trophy.id + "');";
            //statement.execute(sql);
            statement.close();
            return true;

        } catch (Exception ex) {
            System.out.println("Erro : " + ex.getMessage());
            return false;
        }
    }
    
    public static List listCommit() {

        Connection conexao = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        String returnString = "";
        List<Commit> lista = new ArrayList<Commit>();
        
        try {
            Class.forName(driver).newInstance();
            conexao = DriverManager.getConnection(url + dbName, userName, password);
            Statement statement = conexao.createStatement();
            String sql = "SELECT * FROM commit";

            rs = statement.executeQuery(sql);

            while (rs.next()) {
                String nome = rs.getString("nameProjetoCommit");
                String message = rs.getString("messageCommit");
                String date = rs.getDate("dateCreate").toString();
                String sha = rs.getString("sha");
                String author = rs.getString("author");
                
                Commit c = new Commit(nome, message, date, sha, author);
                //Commit c = new Commit("a","a","a","a","a");
                lista.add(c);
                
            }

            return lista;
        } catch (Exception ex) {
            System.out.println("Erro : " + ex.getMessage());
            return lista;
        }
    }
    
    public static List listFile() {

        Connection conexao = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        String returnString = "";
        List<File> lista = new ArrayList<File>();
        
        try {
            Class.forName(driver).newInstance();
            conexao = DriverManager.getConnection(url + dbName, userName, password);
            Statement statement = conexao.createStatement();
            String sql = "SELECT * FROM files";

            rs = statement.executeQuery(sql);

            while (rs.next()) {
                String nameFile = rs.getString("nameFile");
                int lineChanged = rs.getInt("lineChanged");
                int lineDeleted = rs.getInt("lineDeleted");
                int lineAdd = rs.getInt("lineAdd");
                String shaFiles = rs.getString("shaFiles");
                
                File f = new File(nameFile,lineChanged,lineDeleted,lineAdd,shaFiles);
                lista.add(f);
            }

            return lista;
        } catch (Exception ex) {
            System.out.println("Erro : " + ex.getMessage());
            return lista;
        }
    }
    
    //listar commit por data
    public static List listCommitByDate(String dataInicio, String dataFim, String projeto) {

        Connection conexao = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        String returnString = "";
        List<Commit> lista = new ArrayList<Commit>();
        
        try {
            Class.forName(driver).newInstance();
            conexao = DriverManager.getConnection(url + dbName, userName, password);
            Statement statement = conexao.createStatement();
            String sql = "select * from commit where (dateCreate between '" + dataInicio + "' and '" + dataFim + "')"
                    + " and nameProjetoCommit= '" + projeto + "' ";

            rs = statement.executeQuery(sql);

            while (rs.next()) {
                String nome = rs.getString("nameProjetoCommit");
                String message = rs.getString("messageCommit");
                String date = rs.getDate("dateCreate").toString();
                String sha = rs.getString("sha");
                String author = rs.getString("author");
                
                Commit c = new Commit(nome, message, date, sha, author);
                //Commit c = new Commit("a","a","a","a","a");
                lista.add(c);
                
            }

            return lista;
        } catch (Exception ex) {
            System.out.println("Erro : " + ex.getMessage());
            return lista;
        }
    }
    
    //listar arquivos por data e nome do projeto
    public static List listFileByDate(String dataInicio, String dataFim, String nomeProjeto) {

        Connection conexao = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        String returnString = "";
        List<File> lista = new ArrayList<File>();
        
        try {
            Class.forName(driver).newInstance();
            conexao = DriverManager.getConnection(url + dbName, userName, password);
            Statement statement = conexao.createStatement();
            String sql = "select * from files INNER JOIN commit ON sha = shaFiles "
                    +   "where dateCreate BETWEEN '" + dataInicio + "' AND '" + dataFim + "' " 
                    +   "and nameProjetoCommit = '" + nomeProjeto + "' ";

            rs = statement.executeQuery(sql);

            while (rs.next()) {
                String nameFile = rs.getString("nameFile");
                int lineChanged = rs.getInt("lineChanged");
                int lineDeleted = rs.getInt("lineDeleted");
                int lineAdd = rs.getInt("lineAdd");
                String shaFiles = rs.getString("shaFiles");
                
                File f = new File(nameFile,lineChanged,lineDeleted,lineAdd,shaFiles);
                lista.add(f);
                
            }

            return lista;
        } catch (Exception ex) {
            System.out.println("Erro : " + ex.getMessage());
            return lista;
        }
    }
    
    //listar commit por data
    public static int countCommitByDate(String dataInicio, String dataFim, String nomeProjeto) {

        Connection conexao = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        String returnString = "";
        int number = 0;
        
        try {
            Class.forName(driver).newInstance();
            conexao = DriverManager.getConnection(url + dbName, userName, password);
            Statement statement = conexao.createStatement();
            String sql = "select count(sha) as numbercommit from commit where (dateCreate between '" + dataInicio + "' and '" + dataFim + "')"
                     +   " and nameProjetoCommit = '" + nomeProjeto + "' ";

            rs = statement.executeQuery(sql);

            while (rs.next()) {
                number = rs.getInt("numbercommit");
                
                
            }

            return number;
        } catch (Exception ex) {
            System.out.println("Erro : " + ex.getMessage());
            return number;
        }
    }
    
    //listar pullRequests por data
    public static List listPullRequestByDate(String dataInicio, String dataFim, String nomeProjeto) {

        Connection conexao = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        String returnString = "";
        List<PullRequest> lista = new ArrayList<PullRequest>();
        
        try {
            Class.forName(driver).newInstance();
            conexao = DriverManager.getConnection(url + dbName, userName, password);
            Statement statement = conexao.createStatement();
            String sql = "select * from pullRequest "
                    +   "where dateCreate BETWEEN '" + dataInicio + "' AND '" + dataFim + "' " 
                    +   "and nameProject = '" + nomeProjeto + "' ";

            rs = statement.executeQuery(sql);

            while (rs.next()) {
                String pullTitle = rs.getString("pullTitle");
                String authorPull = rs.getString("authorPull");
                int numberId = rs.getInt("numberId");
                String state = rs.getString("state");
                int numComments = rs.getInt("numComments");
                String dateCreate = rs.getDate("dateCreate").toString();
                String dateClose = rs.getDate("dateClose").toString();
                String nameProject = rs.getString("nameProject");
                
                PullRequest c = new PullRequest(pullTitle, authorPull, numberId, state, numComments,dateCreate,dateClose,nameProject);
                //Commit c = new Commit("a","a","a","a","a");
                lista.add(c);
                
            }

            return lista;
        } catch (Exception ex) {
            System.out.println("Erro : " + ex.getMessage());
            return lista;
        }
    }
}
