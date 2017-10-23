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
public class File {
    String nameFile;
    int lineChanged;
    int lineDeleted;
    int lineAdd;
    String shaFile;

    public File(String nameFile, int lineChanged, int lineDeleted, int lineAdd, String shaFile) {
        this.nameFile = nameFile;
        this.lineChanged = lineChanged;
        this.lineDeleted = lineDeleted;
        this.lineAdd = lineAdd;
        this.shaFile = shaFile;
    }
    
    public String getNameFile() {
        return nameFile;
    }

    public void setNameFile(String nameFile) {
        this.nameFile = nameFile;
    }

    public int getLineChanged() {
        return lineChanged;
    }

    public void setLineChanged(int lineChanged) {
        this.lineChanged = lineChanged;
    }

    public int getLineDeleted() {
        return lineDeleted;
    }

    public void setLineDeleted(int lineDeleted) {
        this.lineDeleted = lineDeleted;
    }

    public int getLineAdd() {
        return lineAdd;
    }

    public void setLineAdd(int lineAdd) {
        this.lineAdd = lineAdd;
    }

    public String getShaFile() {
        return shaFile;
    }

    public void setShaFile(String shaFile) {
        this.shaFile = shaFile;
    }
    
    
}
