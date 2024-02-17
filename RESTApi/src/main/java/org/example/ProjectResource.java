package org.example;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import java.util.List;

@Path("/projects")
public class ProjectResource {

    private ProjectDao projectDao;

    public ProjectResource() {
        projectDao = new ProjectDaoImpl();
    }

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public List<Project> getAllProjects() {
        return projectDao.getAllProjects();
    }

    @GET
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Project getProjectById(@PathParam("id") int id) {
        return projectDao.getProjectById(id);
    }

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    public void addProject(Project project) {
        projectDao.addProject(project);
    }

    @PUT
    @Path("/{id}")
    @Consumes(MediaType.APPLICATION_JSON)
    public void updateProject(@PathParam("id") int id, Project project) {
        project.setId(id);
        projectDao.updateProject(project);
    }

    @DELETE
    @Path("/{id}")
    public void deleteProject(@PathParam("id") int id) {
        projectDao.deleteProject(id);
    }
}