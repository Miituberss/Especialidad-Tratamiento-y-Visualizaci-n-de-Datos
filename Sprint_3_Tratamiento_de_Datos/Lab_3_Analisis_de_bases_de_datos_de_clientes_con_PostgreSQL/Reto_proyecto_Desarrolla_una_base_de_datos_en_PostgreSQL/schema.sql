-- Se eliminan las tablas clients, interactions y sales en orden, usando CASCADE para evitar problemas de integridad referencial si hay dependencias entre ellas.
DROP TABLE IF EXISTS clients CASCADE;
DROP TABLE IF EXISTS interactions CASCADE;
DROP TABLE IF EXISTS sales CASCADE;

/* Antes de cargar los ficheros se deben ejecutar los siguientes comandos para crear la BBDD
 CREATE DATABASE customer_analysis; */

-- Crear una tabla llamada clients con las siguientes columnas:
CREATE TABLE clients (
	client_id SERIAL PRIMARY KEY,
	client_name VARCHAR(100),
	industry VARCHAR(100),
	contact_info VARCHAR(255)
);

-- Crear una tabla llamada interactions con las siguientes columnas:
CREATE TABLE interactions (
	interaction_id SERIAL PRIMARY KEY,
	client_id INTEGER REFERENCES clients(client_id),
	date DATE,
	interaction_type VARCHAR(100)
);

--Crear una tabla llamada sales con las siguientes columnas:
CREATE TABLE sales (
	sale_id SERIAL PRIMARY KEY,
	client_id INTEGER REFERENCES clients(client_id),
	sale_amount DECIMAL(10, 2),
	sale_date DATE
);
