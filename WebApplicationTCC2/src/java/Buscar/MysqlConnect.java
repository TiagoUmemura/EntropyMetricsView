/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Buscar;

import java.sql.Connection;
import java.sql.Statement;

/**
 *
 * @author tiago
 */
public final class MysqlConnect {
    public Connection conn;
    private Statement statement;
    public static MysqlConnect db;
    
    private MysqlConnect() {
        String url = "jdbc:mysql://localhost:3306/";
        String dbName = "tcc";
        String driver = "com.mysql.jdbc.Driver";
        String userName = "root";
        String password = "root";
    }
}
