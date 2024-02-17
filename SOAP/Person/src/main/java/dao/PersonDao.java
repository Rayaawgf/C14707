package dao;

import db.DbConnection;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import models.Person;
import java.sql.PreparedStatement;

public class PersonDao implements DAO<Person>{

    // variables
    Connection connection = null;
    Statement statement = null;
    String requet = null;
    Person person = null;

    public PersonDao() {
        try {
            connection = DbConnection.getInstance().getConnection();
            statement = connection.createStatement();
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    @Override
    public List<Person> getAll() {
        List<Person> persons = new ArrayList<>();
        String requet = "SELECT * FROM PERSONNE;";
        System.out.println(requet);
        try {
            ResultSet resultSet = statement.executeQuery(requet);
            while (resultSet.next()) {
                int nni = resultSet.getInt("nni");
                String nom = resultSet.getString("nom");
                Person person = new Person(nni, nom);
                System.out.println(person.toString());
                persons.add(person);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return persons;
    }

    @Override
    public Person getById(int id) {
        requet = "SELECT * FROM PERSONNE WHERE nni =" + id + " ;";
        System.out.println(requet);
        try {
            ResultSet resultSet = statement.executeQuery(requet);
            resultSet.next();
            int nni = resultSet.getInt("nni");
            String nom = resultSet.getString("nom");
            person = new Person(nni, nom);
            System.out.println(person.toString());

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return person;
    }

    @Override
    public void save(Person t) {
        requet = "insert into personne values(" + t.getNni() + ",'" + t.getNom() + "');";
        System.out.println(requet);

        try {
            int resultat = statement.executeUpdate(requet);
            if (resultat != 0) {
                System.out.println("Insertion effectuée");
            } else {
                System.out.println("Erreur d'insertion");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    @Override
    public void update(Person person) {
        String query = "UPDATE PERSONNE SET nom = ? WHERE nni = ?;";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, person.getNom());
            preparedStatement.setInt(2, person.getNni());

            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(Person person) {
        String query = "DELETE FROM PERSONNE WHERE nni = ?;";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, person.getNni());

            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args){
        /*System.out.println(new PersonDao().getById(121231232));*/
        /*new PersonDao().save(new Person(121231232, "Baba"));*/
    }
}
