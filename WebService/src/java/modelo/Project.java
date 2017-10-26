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
public class Project {
    String nameProject;

    public Project(String project) {
        this.nameProject = project;
    }

    public String getProject() {
        return nameProject;
    }

    public void setProject(String project) {
        this.nameProject = project;
    }
    
    
}
