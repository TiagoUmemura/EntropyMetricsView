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
public class CommitPullRequest {
    String shaCommitPull;  
    String authorCommitPull ;  
    String dateCommitPull; 
    int numberCommitPull; 
    String nameProjectCommitPull;
    String messageCommitPull;  
    String linkCommitPull; 

    public CommitPullRequest(String shaCommitPull, String authorCommitPull, String dateCommitPull, int numberCommitPull, String nameProjectCommitPull, String messageCommitPull, String linkCommitPull) {
        this.shaCommitPull = shaCommitPull;
        this.authorCommitPull = authorCommitPull;
        this.dateCommitPull = dateCommitPull;
        this.numberCommitPull = numberCommitPull;
        this.nameProjectCommitPull = nameProjectCommitPull;
        this.messageCommitPull = messageCommitPull;
        this.linkCommitPull = linkCommitPull;
    }

    public String getShaCommitPull() {
        return shaCommitPull;
    }

    public void setShaCommitPull(String shaCommitPull) {
        this.shaCommitPull = shaCommitPull;
    }

    public String getAuthorCommitPull() {
        return authorCommitPull;
    }

    public void setAuthorCommitPull(String authorCommitPull) {
        this.authorCommitPull = authorCommitPull;
    }

    public String getDateCommitPull() {
        return dateCommitPull;
    }

    public void setDateCommitPull(String dateCommitPull) {
        this.dateCommitPull = dateCommitPull;
    }

    public int getNumberCommitPull() {
        return numberCommitPull;
    }

    public void setNumberCommitPull(int numberCommitPull) {
        this.numberCommitPull = numberCommitPull;
    }

    public String getNameProjectCommitPull() {
        return nameProjectCommitPull;
    }

    public void setNameProjectCommitPull(String nameProjectCommitPull) {
        this.nameProjectCommitPull = nameProjectCommitPull;
    }

    public String getMessageCommitPull() {
        return messageCommitPull;
    }

    public void setMessageCommitPull(String messageCommitPull) {
        this.messageCommitPull = messageCommitPull;
    }

    public String getLinkCommitPull() {
        return linkCommitPull;
    }

    public void setLinkCommitPull(String linkCommitPull) {
        this.linkCommitPull = linkCommitPull;
    }
    
    
}
