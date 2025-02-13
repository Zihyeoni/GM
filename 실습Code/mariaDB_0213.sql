-- [ALTER TABLE]
CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    department VARCHAR(50) NOT NULL,
    salary DECIMAL(10,2) NOT NULL,
    hire_date DATE NOT NULL
);

INSERT INTO employees (name, department, salary, hire_date) VALUES
('김철수', '개발', 5000000, '2022-01-15'),
('이영희', '마케팅', 4500000, '2021-07-22'),
('박지성', '인사', 4000000, '2023-03-10'),
('손흥민', '개발', 6000000, '2020-12-01');

ALTER TABLE employees ADD COLUMN email VARCHAR(100) AFTER name;

ALTER TABLE employees DROP COLUMN department;

ALTER TABLE employees CHANGE COLUMN salary monthly_salary DECIMAL(10,2) NOT NULL;

ALTER TABLE employees MODIFY COLUMN monthly_salary BIGINT NOT NULL;

ALTER TABLE employees MODIFY id INT;  -- AUTO_INCREMENT 제거
ALTER TABLE employees DROP PRIMARY KEY;
ALTER TABLE employees ADD PRIMARY KEY (name);

ALTER TABLE employees RENAME TO staff;

ALTER TABLE staff ADD INDEX idx_name (name);
ALTER TABLE staff DROP INDEX idx_name;

-- [연습문제]
CREATE TABLE company_data (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    department VARCHAR(50) NOT NULL,
    salary DECIMAL(10,2) NOT NULL,
    hire_date DATE NOT NULL
);

INSERT INTO company_data (emp_name, department, salary, hire_date) VALUES
('김철수', '개발', 5000000, '2022-01-15'),
('이영희', '마케팅', 4500000, '2021-07-22'),
('박지성', '인사', 4000000, '2023-03-10'),
('손흥민', '개발', 6000000, '2020-12-01');

ALTER TABLE company_data ADD COLUMN email VARCHAR(100) AFTER emp_name;

ALTER TABLE company_data DROP COLUMN department;

ALTER TABLE company_data CHANGE COLUMN salary monthly_salary DECIMAL(10,2) NOT NULL;

ALTER TABLE company_data MODIFY COLUMN monthly_salary BIGINT NOT NULL;

ALTER TABLE company_data RENAME TO staff_info;

ALTER TABLE staff_info MODIFY COLUMN emp_name VARCHAR(150) NOT NULL;

ALTER TABLE staff_info MODIFY COLUMN hire_date DATE NOT NULL DEFAULT CURRENT_DATE;

ALTER TABLE staff_info MODIFY COLUMN emp_id INT;

ALTER TABLE staff_info ADD CONSTRAINT unique_emp_name UNIQUE (emp_name);

ALTER TABLE staff_info ADD CONSTRAINT check_salary CHECK (monthly_salary >= 3000000);