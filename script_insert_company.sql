INSERT INTO employee VALUES ('James', 'E', 'Borg', 888665555, '1937-11-10', '450-Stone-Houston-TX', 'M', 55000, NULL, 1);

INSERT INTO employee VALUES ('Franklin', 'T', 'Wong', 333445555, '1955-12-08', '638-Voss-Houston-TX', 'M', 40000, 888665555, 5),
                            ('Jennifer', 'S', 'Wallace', 987654321, '1941-06-20', '291-Berry-Bellaire-TX', 'F', 43000, 888665555, 4);

INSERT INTO employee VALUES ('John', 'B', 'Smith', 123456789, '1965-01-09', '731-Fondren-Houston-TX', 'M', 30000, 333445555, 5);
INSERT INTO employee VALUES	('Ramesh', 'K', 'Narayan', 666884444,'1962-09-15','975-Fire-Oak-Humble-Tx','M', 38000, 333445555, 5);
INSERT INTO employee VALUES ('Joyce', 'A', 'English', 453453453, '1972-07-31', '5631-Rice-Houston-TX', 'F', 25000, 333445555, 5);

INSERT INTO employee VALUES ('Alicia', 'J', 'Zelaya', 999887777, '1968-01-19', '3321-Castle-Spring-TX', 'F', 25000, 987654321, 4),
							('Ahmad', 'V', 'Jabbar', 987987987, '1969-03-29', '980-Dallas-Houston-TX', 'M', 25000, 987654321, 4);

SELECT * FROM employee;

INSERT INTO dependent VALUES (333445555, 'Alice', 'F', '1986-04-05', 'Daughter'),
							 (333445555, 'Theodore', 'M', '1983-10-25', 'Son'),
                             (333445555, 'Joy', 'F', '1958-05-03', 'Spouse'),
                             (987654321, 'Abner', 'M', '1942-02-28', 'Spouse'),
                             (123456789, 'Michael', 'M', '1988-01-04', 'Son'),
                             (123456789, 'Alice', 'F', '1988-12-30', 'Daughter'),
                             (123456789, 'Elizabeth', 'F', '1967-05-05', 'Spouse');
SELECT * FROM dependent;

INSERT INTO department VALUES ('Research', 5, 333445555, '1988-05-22','1986-05-22'),
							   ('Administration', 4, 987654321, '1995-01-01','1994-01-01'),
                               ('Headquarters', 1, 888665555,'1981-06-19','1980-06-19');

SELECT * FROM department;
INSERT INTO dept_locations VALUES (1, 'Houston'),
								 (4, 'Stafford'),
                                 (5, 'Bellaire'),
                                 (5, 'Sugarland'),
                                 (5, 'Houston');
SELECT * FROM dept_locations;

INSERT INTO project VALUES ('ProductX', 1, 'Bellaire', 5),
						   ('ProductY', 2, 'SugarlAND', 5),
						   ('ProductZ', 3, 'Houston', 5),
                           ('Computerization', 10, 'Stafford', 4),
                           ('Reorganization', 20, 'Houston', 1),
                           ('Newbenefits', 30, 'Stafford', 4);
SELECT * FROM project;

INSERT INTO works_on VALUES (123456789, 1, 32.5),
							(123456789, 2, 7.5),
                            (666884444, 3, 40.0),
                            (453453453, 1, 20.0),
                            (453453453, 2, 20.0),
                            (333445555, 2, 10.0),
                            (333445555, 3, 10.0),
                            (333445555, 10, 10.0),
                            (333445555, 20, 10.0),
                            (999887777, 30, 30.0),
                            (999887777, 10, 10.0),
                            (987987987, 10, 35.0),
                            (987987987, 30, 5.0),
                            (987654321, 30, 20.0),
                            (987654321, 20, 15.0),
                            (888665555, 20, 0.0);
SELECT * FROM works_on;
-- *******************************************************
-- CONSULTAS SQL
-- *******************************************************
SELECT * FROM employee;
SELECT SSN, CONCAT(e.Fname, e.Minit, e.Lname) AS 'name', count(E_SSN) AS 'nro dependentes' 
   FROM employee e, dependent d 
   WHERE (e.SSN = d.E_SSN) GROUP BY e.SSN;
   
SELECT * FROM dependent;
SELECT Bdate, Address FROM employee
   WHERE Fname = 'John' AND Minit = 'B' AND Lname = 'Smith';

SELECT * FROM department WHERE Dname = 'Research';

SELECT Fname, Lname, Address
FROM employee e, department d
WHERE Dname = 'Research' AND d.Dnumber = e.Dnumber;

SELECT * FROM project;
-- *******************************************************
-- Expressões e concatenação de strings
-- *******************************************************
-- recuperando informações dos departmentos presentes em Stafford
SELECT Dname AS Department, Mgr_SSN AS Manager FROM department d, dept_locations l
WHERE d.Dnumber = l.Dnumber;

-- padrão sql -> || no MySQL usa a função concat()
SELECT Dname AS Department, CONCAT(Fname, ' ', Lname) FROM department d, dept_locations l, employee e
WHERE d.Dnumber = l.Dnumber AND Mgr_SSN = e.SSN;

-- recuperando info dos projetos em Stafford
SELECT * FROM project, department WHERE project.Dnumber = department.Dnumber AND Plocation = 'Stafford';

-- recuperando info sobre os departmentos e projetos localizados em Stafford
SELECT p.Pnumber AS 'Projeto', d.Dnumber AS 'Departamento', e.Lname AS 'Sobrenome', e.Address, e.Bdate AS 'Aniversário'
FROM project p, department d, employee e
WHERE p.Dnumber = d.Dnumber AND d.Mgr_SSN = e.SSN AND
p.Plocation = 'Stafford';

SELECT * FROM employee WHERE Dnumber IN (3,5,6,9);

-- *******************************************************
-- Operadores lógicos
-- *******************************************************

SELECT Bdate, Address
FROM EMPLOYEE
WHERE Fname = 'John' AND Minit = 'B' AND Lname = 'Smith';

SELECT Fname, Lname, Address
FROM EMPLOYEE e, DEPARTMENT d
WHERE Dname = 'Research' AND d.Dnumber = e.Dnumber;

-- *******************************************************
-- Expressões e alias
-- *******************************************************
-- recolhendo o valor do INSS-*
SELECT Fname, Lname, Salary, Salary*0.011 FROM employee;
SELECT Fname, Lname, Salary, Salary*0.011 AS INSS FROM employee;
SELECT Fname, Lname, Salary, round(Salary*0.011,2) AS INSS FROM employee;

-- definir um aumento de salário para os gerentes que trabalham no projeto associado ao ProdutoX
SELECT e.Fname, e.Lname, 1.1*e.Salary AS increased_sal FROM employee AS e,
works_on AS w, project AS p WHERE e.SSN = w.E_SSN AND w.Pnumber = p.Pnumber AND p.Pname='ProductX';

-- concatenANDo e fornecendo alias
SELECT Dname AS Department, concat(Fname, ' ', Lname) AS Manager FROM department d, dept_locations l, employee e
WHERE d.Dnumber = l.Dnumber AND d.Mgr_SSN = e.SSN;

-- recuperando dados dos empregados que trabalham para o departmento de pesquisa
SELECT Fname, Lname, Address FROM employee e, department d
	WHERE d.Dname = 'Research' AND d.Dnumber = e.Dnumber;

-- definindo alias para legibilidade da consulta
SELECT e.Fname, e.Lname, e.Address FROM employee e, department d
	WHERE d.Dname = 'Research' AND d.Dnumber = e.Dnumber;
