package services;

import jakarta.jws.WebService;
import services.PersonService;
import dao.PersonDao;
import models.Person;
import java.util.List;

@WebService(endpointInterface = "services.PersonService")
public class PersonServiceImp implements PersonService {

    private PersonDao personDao = new PersonDao();

    @Override
    public void addPerson(Person person) {
        // Assuming there's a method in PersonDao to add a Person. Needs to be implemented in PersonDao.
        personDao.save(person); // This method needs to be created in PersonDao.
    }

    @Override
    public Person getPerson(int id) {
        // Using existing getById method from PersonDao
        return personDao.getById(id);
    }

    @Override
    public List<Person> getAllPersons() {
        // Using existing getAll method from PersonDao
        return personDao.getAll();
    }

    @Override
    public void updatePerson(Person person) {
        // Assuming there's a method in PersonDao to update a Person. Needs to be implemented in PersonDao.
        personDao.update(person); // This method needs to be created in PersonDao.
    }

    @Override
    public void deletePerson(Person person) {
        // Assuming there's a method in PersonDao to delete a Person by ID. Needs to be implemented in PersonDao.
        personDao.delete(person); // This method needs to be created in PersonDao.
    }
}
