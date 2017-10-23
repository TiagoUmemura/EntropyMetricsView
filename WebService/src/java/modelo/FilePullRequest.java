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
public class FilePullRequest {
    int pullReqNumber;
    String fileName;
    int additions;
    int deletions;
    int changes;
    int numComment;
    String nameProjectFilePull;

    public FilePullRequest(int pullReqNumber, String fileName, int additions, int deletions, int changes, int numComment, String nameProjectFilePull) {
        this.pullReqNumber = pullReqNumber;
        this.fileName = fileName;
        this.additions = additions;
        this.deletions = deletions;
        this.changes = changes;
        this.numComment = numComment;
        this.nameProjectFilePull = nameProjectFilePull;
    }

    public int getPullReqNumber() {
        return pullReqNumber;
    }

    public void setPullReqNumber(int pullReqNumber) {
        this.pullReqNumber = pullReqNumber;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public int getAdditions() {
        return additions;
    }

    public void setAdditions(int additions) {
        this.additions = additions;
    }

    public int getDeletions() {
        return deletions;
    }

    public void setDeletions(int deletions) {
        this.deletions = deletions;
    }

    public int getChanges() {
        return changes;
    }

    public void setChanges(int changes) {
        this.changes = changes;
    }

    public int getNumComment() {
        return numComment;
    }

    public void setNumComment(int numComment) {
        this.numComment = numComment;
    }

    public String getNameProjectFilePull() {
        return nameProjectFilePull;
    }

    public void setNameProjectFilePull(String nameProjectFilePull) {
        this.nameProjectFilePull = nameProjectFilePull;
    }
    
    
}
