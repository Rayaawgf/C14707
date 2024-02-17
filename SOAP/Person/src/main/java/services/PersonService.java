package services;

import jakarta.jws.WebService;
import models.Person;
import java.util.List;

@WebService
public interface PersonService {
    void addPerson(Person person);
    Person getPerson(int id);
    List<Person> getAllPersons();
    void updatePerson(Person person);
    void deletePerson(Person person);
}
