CREATE SCHEMA IF NOT EXISTS azure_company;
USE azure_company;

SELECT * FROM information_schema.TABLE_CONSTRAINTs
	WHERE CONSTRAINT_SCHEMA = 'azure_company';

-- restrição atribuida a um domínio
-- CREATE domain D_num AS INT CHECK(D_num> 0 AND D_num< 21);

CREATE TABLE employee(
	Fname VARCHAR(15) NOT NULL,
    Minit CHAR,
    Lname VARCHAR(15) NOT NULL,
    SSN CHAR(9) NOT NULL, 
    Bdate DATE,
    Address VARCHAR(30),
    Sex CHAR,
    Salary DECIMAL(10,2),
    Super_SSN CHAR(9),
    Dnumber INT NOT NULL,
    CONSTRAINT chk_salary_employee CHECK (Salary> 2000.0),
    CONSTRAINT pk_employee PRIMARY KEY (SSN)
);

ALTER TABLE employee 
	ADD CONSTRAINT fk_employee_employee 
	FOREIGN KEY(Super_SSN) REFERENCES employee(SSN)
    ON DELETE SET NULL
    ON UPDATE CASCADE;

ALTER TABLE employee MODIFY Dnumber INT NOT NULL default 1;

DESC employee;

CREATE TABLE department(
	Dname VARCHAR(15) NOT NULL,
    Dnumber INT NOT NULL,
    Mgr_SSN CHAR(9) NOT NULL,
    Mgr_start_date DATE, 
    Dept_create_date DATE,
    CONSTRAINT chk_date_dept CHECK (Dept_create_date < Mgr_start_date),
    CONSTRAINT pk_dept PRIMARY KEY (Dnumber),
    CONSTRAINT UNIQUE_name_dept UNIQUE(Dname),
    CONSTRAINT fk_department_employee FOREIGN KEY (Mgr_SSN) REFERENCES employee(SSN)
      ON UPDATE CASCADE
);

-- 'DEF', 'company_CONSTRAINTs', 'department_ibfk_1', 'company_CONSTRAINTs', 'department', 'FOREIGN KEY', 'YES'
-- modificar uma CONSTRAINT: DROP e ADD
-- ALTER TABLE department DROP  department_ibfk_1;

-- ALTER TABLE department 
--		ADD CONSTRAINT fk_dept FOREIGN KEY(Mgr_SSN) REFERENCES employee(SSN)
--        ON UPDATE CASCADE;

CREATE TABLE IF NOT EXISTS dept_locations(
	Dnumber INT NOT NULL,
	Dlocation VARCHAR(15) NOT NULL,
    CONSTRAINT pk_dept_locations PRIMARY KEY (Dnumber, Dlocation)
);

ALTER TABLE dept_locations 
	ADD CONSTRAINT fk_dept_locations_department FOREIGN KEY (Dnumber) REFERENCES department(Dnumber)
	ON DELETE CASCADE
    ON UPDATE CASCADE;
    
-- DESC dept_locations;

CREATE TABLE IF NOT EXISTS project(
	Pname VARCHAR(15) NOT NULL,
	Pnumber INT NOT NULL,
    Plocation VARCHAR(15),
    Dnumber INT NOT NULL,
    PRIMARY KEY (Pnumber),
    CONSTRAINT UNIQUE_project UNIQUE (Pname),
    CONSTRAINT fk_project_department FOREIGN KEY (Dnumber) REFERENCES department(Dnumber)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);


ALTER TABLE project
    ADD CONSTRAINT fk_project
    FOREIGN KEY (Dnumber) 
    REFERENCES department(Dnumber)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

CREATE TABLE IF NOT EXISTS  works_on(
	E_SSN CHAR(9) NOT NULL,
    Pnumber INT NOT NULL,
    Hours DECIMAL(3,1) NOT NULL,
    PRIMARY KEY (E_SSN, Pnumber),
    CONSTRAINT fk_works_on_employee FOREIGN KEY (E_SSN) REFERENCES employee(SSN),
    CONSTRAINT fk_works_on_project FOREIGN KEY (Pnumber) REFERENCES project(Pnumber)
);

-- DROP TABLE dependent;
CREATE TABLE IF NOT EXISTS dependent(
	E_SSN CHAR(9) NOT NULL,
    Dname VARCHAR(15) NOT NULL,
    Sex CHAR,
    Bdate DATE,
    Relationship VARCHAR(8) COMMENT 'Tipo de relacionamento: pai, mãe, irmao, etc',
    PRIMARY KEY (E_SSN, Dname),
    CONSTRAINT fk_dependent_employee FOREIGN KEY (E_SSN) REFERENCES employee(SSN)
);
ALTER TABLE dependent
COMMENT = 'Tabela com informações dos dependentes do empregados';

SELECT COLUMN_NAME, COLUMN_COMMENT 
FROM information_schema.COLUMNS 
WHERE TABLE_NAME = 'dependent' AND TABLE_SCHEMA = 'azure_company';

desc dependent;
SHOW TABLES;