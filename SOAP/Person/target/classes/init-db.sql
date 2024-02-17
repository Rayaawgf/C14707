-- Create the database
CREATE DATABASE soa;

-- Connect to the database
\c soa;

-- Creating the table
CREATE TABLE personne (
    nni INTEGER PRIMARY KEY,
    nom VARCHAR(255) NOT NULL
);
