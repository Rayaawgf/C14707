package services;
import jakarta.xml.ws.Endpoint;

public class PersonServicePublisher {
    public static void main(String[] args) {
        Endpoint.publish("http://localhost:8080/PersonService", new PersonServiceImp());
        System.out.println("PersonService is published and running at http://localhost:8080/PersonService");
    }
}

