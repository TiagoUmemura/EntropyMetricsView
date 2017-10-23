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
//    private static final Connection c = null;
//    private static final PreparedStatement pst = null;
//    private static final ResultSet rs = null;

//    public static Connection getConection(Connection c) throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException {
//        if (c == null) {
//            Class.forName(driver).newInstance();
//            return DriverManager.getConnection(url + dbName, userName, password);
//        } else {
//            return c;
//        }
//    }

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
    public static void addCommit(String nameProjetoCommit, String messageCommit, String dateCreate,String sha, String author, String link ) {
        Connection conexao = null;
        Statement statement = null;

        try {
            Class.forName(driver).newInstance();
            conexao = DriverManager.getConnection(url + dbName, userName, password);
            statement = conexao.createStatement();
            String sql = "INSERT INTO commit(nameProjetoCommit, messageCommit, dateCreate, sha, author, link) VALUES ( '" + nameProjetoCommit + "','" + messageCommit + "','" + dateCreate + "','" + sha + "','" + author + "','" + link + "');";
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

    public static void addFile(String nameFile, int lineChanged, int lineDeleted, int lineAdd, String sha) {
        Connection conexao = null;
        Statement statement = null;

        try {
//            Connection conexao = getConection(c);
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

    public static void addPullRequest(String pullTitle, String authorPull, int numberId, String state, int numComments, String dateCreate, String dateClose, String nameProject) {
        Connection conexao = null;
        Statement statement = null;

        try {
            Class.forName(driver).newInstance();
            conexao = DriverManager.getConnection(url + dbName, userName, password);
//            Connection conexao = getConection(c);
            statement = conexao.createStatement();
            String sql = "INSERT INTO pullRequest(pullTitle, authorPull, numberId, state, numComments, dateCreate, dateClose, nameProject) VALUES ( '" + pullTitle + "','" + authorPull + "','" + numberId + "','" + state + "','" + numComments + "','" + dateCreate + "','" + dateClose + "','" + nameProject + "');";
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

    public static void addFilesPullRequest(int pullReqNumber, String fileName, int additions, int deletions, int changes, int numComment, String nameProjectFilePull) {
        Connection conexao = null;
        Statement statement = null;

        try {
            Class.forName(driver).newInstance();
//            Connection conexao = getConection(c);
            conexao = DriverManager.getConnection(url + dbName, userName, password);
            statement = conexao.createStatement();
            String sql = "INSERT INTO filesPullRequest(pullReqNumber, fileName, additions, deletions, changes, numComment, nameProjectFilePull) VALUES ( '" + pullReqNumber + "','" + fileName + "','" + additions + "','" + deletions + "','" + changes + "','" + numComment + "','" + nameProjectFilePull + "');";
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
    
    public static void addCommitPullRequest(String sha, String author, String dateCreate, int number, String project, String message, String link) {
        Connection conexao = null;
        Statement statement = null;

        try {
            Class.forName(driver).newInstance();
//            Connection conexao = getConection(c);
            conexao = DriverManager.getConnection(url + dbName, userName, password);
            statement = conexao.createStatement();
            String sql = "INSERT INTO commitPullRequest(shaCommitPull, authorCommitPull, dateCommitPull, numberCommitPull, nameProjectCommitPull, messageCommitPull, linkCommitPull) VALUES ( '" + sha + "','" + author + "','" + dateCreate + "','" + number + "','" + project + "','" + message + "','" + link + "');";
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
}
