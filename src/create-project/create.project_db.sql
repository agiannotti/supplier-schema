-- first remove the foreign key constraint from department
ALTER TABLE IF EXISTS department
  DROP COLUMN manager;

-- DROP the tables and constraints
DROP TABLE IF EXISTS employee_project;
DROP TABLE IF EXISTS project;
DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS department;

-- create the project table, it depends on no other
CREATE TABLE project (
  id INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
  project_name TEXT NOT NULL,
  budget NUMERIC DEFAULT 0,
  start_date DATE
);

-- create the department table without the foreign key
CREATE TABLE department (
  id INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
  dept_name TEXT NOT NULL
);

-- create the employee table
-- make the foreign keys immediately as the two
-- dependencies exist

CREATE TABLE employee (
  id INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
  emp_name TEXT NOT NULL,
  phone TEXT,
  title TEXT,
  salary NUMERIC,
  department INTEGER REFERENCES department(id)
);

-- now the manager relationship between department and
-- employee is possible, alter the table and add the constraint

ALTER TABLE department
  ADD COLUMN manager INTEGER REFERENCES employee(id);

-- create the employee_project table with references
-- to both employee and project
-- the primary key is made up of two columns

CREATE TABLE employee_project (
  emp_id INTEGER REFERENCES employee(id),
  project_id INTEGER REFERENCES project(id),
  start_date DATE,
  end_date DATE,
  PRIMARY KEY (emp_id, project_id)
);

-- Join tables to query data from multiple tables
-- SELECT <columns>
-- FROM <table1> JOIN <table2> ON <related columns>;

-- notes on using alias for query table joining
-- SELECT
--   d.id,
--   d.dept_name,
--   e.emp_name,
--   e.phone,
--   e.title,
--   e.salary
-- FROM
--   department d
--   JOIN
--   employee e
--   ON d.manager = e.id;

--  id |    dept_name    |    emp_name     |  phone  |          title          | salary
-- ----+-----------------+-----------------+---------+-------------------------+--------
--   1 | Development     | Edgar Djikstra  | 5554567 | Lead Software Developer | 120000
--   2 | Sales           | Jim Halpert     | 5555678 | Salesman                |  50000
--   3 | Human Resources | Toby Flenderson | 5558769 | Head Human Resources    |  60000
--   4 | Warehouse       | Meredith Palmer | 5559876 | Supplier Relations      |  30000
-- (4 rows)

-- alternatively, to provide table alias


-- SELECT
--   d.id as department_id,
--   d.dept_name as department,
--   e.emp_name as Full_Name,
--   e.phone,
--   e.title,
--   e.salary
-- FROM
--   department d
--   JOIN
--   employee e
--   ON d.manager = e.id;

--  department_id |   department    |    full_name    |  phone  |          title          | salary
-- ---------------+-----------------+-----------------+---------+-------------------------+--------
--              1 | Development     | Edgar Djikstra  | 5554567 | Lead Software Developer | 120000
--              2 | Sales           | Jim Halpert     | 5555678 | Salesman                |  50000
--              3 | Human Resources | Toby Flenderson | 5558769 | Head Human Resources    |  60000
--              4 | Warehouse       | Meredith Palmer | 5559876 | Supplier Relations      |  30000
-- (4 rows)