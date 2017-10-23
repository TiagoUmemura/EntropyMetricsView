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
public class PullRequest {
    String pullTitle;
    String authorPull;
    int numberId;
    String state;
    int numComments;
    String dateCreate;
    String dateClose;
    String nameProject;

    public PullRequest(String pullTitle, String authorPull, int numberId, String state, int numComments, String dateCreate, String dateClose, String nameProject) {
        this.pullTitle = pullTitle;
        this.authorPull = authorPull;
        this.numberId = numberId;
        this.state = state;
        this.numComments = numComments;
        this.dateCreate = dateCreate;
        this.dateClose = dateClose;
        this.nameProject = nameProject;
    }
    
    
    public String getPullTitle() {
        return pullTitle;
    }

    public void setPullTitle(String pullTitle) {
        this.pullTitle = pullTitle;
    }

    public String getAuthorPull() {
        return authorPull;
    }

    public void setAuthorPull(String authorPull) {
        this.authorPull = authorPull;
    }

    public int getNumberId() {
        return numberId;
    }

    public void setNumberId(int numberId) {
        this.numberId = numberId;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public int getNumComments() {
        return numComments;
    }

    public void setNumComments(int numComments) {
        this.numComments = numComments;
    }

    public String getDateCreate() {
        return dateCreate;
    }

    public void setDateCreate(String dateCreate) {
        this.dateCreate = dateCreate;
    }

    public String getDateClose() {
        return dateClose;
    }

    public void setDateClose(String dateClose) {
        this.dateClose = dateClose;
    }

    public String getNameProject() {
        return nameProject;
    }

    public void setNameProject(String nameProject) {
        this.nameProject = nameProject;
    }
    
    
}
