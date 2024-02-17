package services;

import jakarta.xml.ws.Endpoint;

public class TestService {
    public static void main(String[] args) {
        // Creer et publier un servce SOAP
        String addresse = "http://localhost:8080/Service-Addition";
        Endpoint.publish(addresse, new ServiceOperationImp());

        System.out.println("Le service SOAP est lanceé à l'adresse : " + addresse);
    }
}
