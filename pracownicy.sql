-- 1. Tworzy tabelę pracownik(imie, nazwisko, wyplata, data urodzenia, stanowisko).
CREATE TABLE employee (
id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(30) NOT NULL, 
last_name VARCHAR(30) NOT NULL,
salary DOUBLE,
birth_date DATE NOT NULL,
position VARCHAR(30) NOT NULL
);
-- 2. Wstawia do tabeli co najmniej 6 pracowników
INSERT INTO employee (first_name, last_name, salary, birth_date, position)
VALUES ('Adam', 'Nowak', 4200.99, '1990-12-12', 'Driver'),
 ('Igor', 'Kowalski', 5552.30, '1980-08-14', 'Forwarder'),
 ('Ewa', 'Lewandowska', 6100.00, '1975-04-22', 'Accountant'),
 ('Sebastian', 'Kowalski', 7212.55, '1977-01-01', 'Forwarder'),
 ('Maciej', 'Piątek', 4200.99, '1984-11-30', 'Driver'),
 ('Robert', 'Lakowski', 10241.43, '1991-07-20', 'Director'),
 ('Tadeusz', 'Norek', 3500.50, '1998-10-10', 'Driver'),
 ('Karol', 'Krawczyk', 6100.54, '1985-06-13', 'Forwarder'),
 ('Wiktoria', 'Kowal', 8833.33, '1988-02-26', 'Accountant'),
 ('Anna', 'Zielona', 4900.50, '1989-03-19', 'Customer Service');

-- 3. Pobiera wszystkich pracowników i wyświetla ich w kolejności alfabetycznej po nazwisku
SELECT * FROM employee ORDER BY last_name ASC;

-- 4. Pobiera pracowników na wybranym stanowisku
SELECT * FROM employee WHERE position = 'Forwarder';

-- 5. Pobiera pracowników, którzy mają co najmniej 30 lat
SELECT * FROM employee WHERE DATE_FORMAT(FROM_DAYS(DATEDIFF(NOW(), birth_date)), '%Y') + 0 >= 30;

-- 6. Zwiększa wypłatę pracowników na wybranym stanowisku o 10%
UPDATE employee
SET salary = (salary * 1.1)  WHERE id > 0 AND position = 'Driver';

-- 7. Pobiera najmłodszego pracowników (uwzględnij przypadek, że może być kilku urodzonych tego samego dnia)
SELECT * FROM employee WHERE birth_date = (SELECT MAX(birth_date) FROM employee);

-- 8. Usuwa tabelę pracownik
DROP TABLE IF EXISTS employee;

-- 9. Tworzy tabelę stanowisko (nazwa stanowiska, opis, wypłata na danym stanowisku)
CREATE TABLE position (
id INT PRIMARY KEY AUTO_INCREMENT,
title VARCHAR(40) NOT NULL,
description VARCHAR(100) NOT NULL,
salary DOUBLE NOT NULL
);

-- 10. Tworzy tabelę adres (ulica+numer domu/mieszkania, kod pocztowy, miejscowość)
CREATE TABLE address (
id INT PRIMARY KEY AUTO_INCREMENT,
street VARCHAR(45) NOT NULL,
postcode VARCHAR(6) NOT NULL,
city VARCHAR(30) NOT NULL
);

-- 11. Tworzy tabelę pracownik (imię, nazwisko) + relacje do tabeli stanowisko i adres
CREATE TABLE employee (
id INT PRIMARY KEY AUTO_INCREMENT, 
first_name VARCHAR(20) NOT NULL,
last_name VARCHAR(30) NOT NULL
);

ALTER TABLE employee
ADD position_id INT,
ADD FOREIGN KEY (position_id) REFERENCES position (id);

ALTER TABLE employee
ADD address_id INT,
ADD FOREIGN KEY (address_id) REFERENCES address (id);

-- 12. Dodaje dane testowe (w taki sposób, aby powstały pomiędzy nimi sensowne powiązania)

INSERT INTO position (title, description, salary)
VALUES ('Driver', 'Realizuje przewozy', 5000),
('Forwarder', 'Planuje przewozy', 6000), 
('Accountant', 'Realizuje usługi księgowe', 7000),
('Director', 'Menadżer działu', 10000)
;

INSERT INTO address (street, postcode, city)
VALUES ('Krakowska 33/55', '04900', 'Katowice'),
('Zielona 5/12', '22100', 'Siedlce'),
('Nowa 11/12', '33200', 'Gdańsk'),
('Wiejska 7/28', '03125', 'Warszawa'),
('Górna 44/99', '10122', 'Poznań'),
('Wolska 1/3', '00321', 'Warszawa'),
('Dąbrowska 10/20', '44321', 'Kielce'),
('Lubelska 12/54', '65121', 'Rzeszów'), 
('Pomorska 21/37', '32111', 'Gdynia');

INSERT INTO employee (first_name, last_name, position_id, address_id)
VALUES ('Adam', 'Nowak', 2, 1),
('Igor', 'Kowalski', 1, 2),
('Ewa', 'Lewandowska', 3, 3),
('Sebastian', 'Kowalski', 4, 2),
('Maciej', 'Piątek', 1, 5),
('Robert', 'Lakowski', 2, 6),
('Tadeusz', 'Norek', 3, 7),
('Karol', 'Krawczyk', 2, 8),
('Wiktoria', 'Kowal', 1, 9),
('Anna', 'Zielona', 2, 4);

-- 13. Pobiera pełne informacje o pracowniku (imię, nazwisko, adres, stanowisko)
SELECT e.id, first_name, last_name, street, postcode, city FROM employee e
JOIN address a ON e.address_id = a.id
JOIN position p ON e.position_id = p.id;

-- 14. Oblicza sumę wypłat dla wszystkich pracowników w firmie
SELECT SUM(salary) AS 'Total salary' from employee e
JOIN position p ON e.position_id = p.id;

-- 15. Pobiera pracowników mieszkających w lokalizacji z kodem pocztowym 90210 (albo innym, który będzie miał sens dla Twoich danych testowych)
SELECT e.id, first_name, last_name, street, postcode, city FROM employee e
JOIN address a ON e.address_id = a.id
WHERE postcode = '22100';