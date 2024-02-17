package org.example;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProjectDaoImpl implements ProjectDao {

    private Connection connection;

    public ProjectDaoImpl() {
        try {
            connection = DatabaseConnection.getInstance().getConnection();
        } catch (SQLException e) {
            System.err.println("Error while establishing database connection:");
            e.printStackTrace();
            throw new RuntimeException("Failed to establish database connection", e);
        }
    }

    @Override
    public List<Project> getAllProjects() {
        List<Project> projects = new ArrayList<>();
        String query = "SELECT * FROM project";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query);
             ResultSet resultSet = preparedStatement.executeQuery()) {
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                String description = resultSet.getString("description");
                String etat = resultSet.getString("etat");
                Project project = new Project(id, name, description, etat);
                projects.add(project);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return projects;
    }

    @Override
    public Project getProjectById(int id) {
        Project project = null;
        String query = "SELECT * FROM project WHERE id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setLong(1, id);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    String name = resultSet.getString("name");
                    String description = resultSet.getString("description");
                    String etat = resultSet.getString("etat");
                    project = new Project(id, name, description, etat);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return project;
    }

    @Override
    public void addProject(Project project) {
        String query = "INSERT INTO project(name, description, etat) VALUES(?, ?, ?)";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, project.getName());
            preparedStatement.setString(2, project.getDescription());
            preparedStatement.setString(3, project.getEtat());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
public void updateProject(Project project) {
    String query = "UPDATE projects SET name = ?, description = ?, etat= ? WHERE id = ?";
    try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
        preparedStatement.setString(1, project.getName());
        preparedStatement.setString(2, project.getDescription());
        preparedStatement.setString(3, project.getEtat());
        preparedStatement.setLong(4, project.getId()); // Utilisation de setInt pour un paramètre de type int
        preparedStatement.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}

    @Override
    public void deleteProject(int id) {
        String query = "DELETE FROM projects WHERE id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, id);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
