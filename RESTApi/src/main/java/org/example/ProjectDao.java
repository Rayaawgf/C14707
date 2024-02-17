package org.example;
import java.util.List;

public interface ProjectDao {
    List<Project> getAllProjects();
    Project getProjectById(int id);
    void addProject(Project project);
    void updateProject(Project project);
    void deleteProject(int id);
}