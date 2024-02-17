package services;

import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import jakarta.jws.WebService;

@WebService(name = "service d'addition")
public interface ServiceOperation {
    @WebMethod(operationName="addition")
    public int addition(@WebParam(name = "a") int a, @WebParam(name = "b") int b) ;
}
