/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

/**
 *
 * @author tiago
 */
public class Commit {
    String nameProjetoCommit;
    String messageCommit;
    String dateCreate;
    String sha;
    String author;

    public Commit(String nameProjetoCommit, String messageCommit, String dateCreate, String sha, String author) {
        this.nameProjetoCommit = nameProjetoCommit;
        this.messageCommit = messageCommit;
        this.dateCreate = dateCreate;
        this.sha = sha;
        this.author = author;
    }

    
    
    

    public String getNameProjetoCommit() {
        return nameProjetoCommit;
    }

    public void setNameProjetoCommit(String nameProjetoCommit) {
        this.nameProjetoCommit = nameProjetoCommit;
    }

    public String getMessageCommit() {
        return messageCommit;
    }

    public void setMessageCommit(String messageCommit) {
        this.messageCommit = messageCommit;
    }

    public String getDateCreate() {
        return dateCreate;
    }

    public void setDateCreate(String dateCreate) {
        this.dateCreate = dateCreate;
    }

    public String getSha() {
        return sha;
    }

    public void setSha(String sha) {
        this.sha = sha;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }
    
    
}
