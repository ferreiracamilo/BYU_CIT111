-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema university
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema university
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `university` DEFAULT CHARACTER SET utf8 ;
USE `university` ;

-- -----------------------------------------------------
-- Table `university`.`teacher`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`teacher` (
  `teacher_id` INT NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `capacity` INT NOT NULL,
  PRIMARY KEY (`teacher_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`period`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`period` (
  `period_id` INT NOT NULL,
  `year` VARCHAR(45) NOT NULL,
  `term` ENUM('Fall', 'Winter', 'Summer', 'Spring') NOT NULL,
  PRIMARY KEY (`period_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`department` (
  `department_id` INT NOT NULL,
  `department_name` VARCHAR(45) NOT NULL,
  `department_code` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`department_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`college`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`college` (
  `college_id` INT NOT NULL,
  `college_name` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`college_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`course` (
  `course_id` INT NOT NULL,
  `course_title` VARCHAR(30) NOT NULL,
  `credits` INT NOT NULL,
  `department_id` INT NOT NULL,
  `college_id` INT NOT NULL,
  `course_num` INT NOT NULL,
  PRIMARY KEY (`course_id`),
  INDEX `fk_course_department_idx` (`department_id` ASC) VISIBLE,
  INDEX `fk_course_college1_idx` (`college_id` ASC) VISIBLE,
  CONSTRAINT `fk_course_department`
    FOREIGN KEY (`department_id`)
    REFERENCES `university`.`department` (`department_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_course_college1`
    FOREIGN KEY (`college_id`)
    REFERENCES `university`.`college` (`college_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`section`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`section` (
  `section_id` INT NOT NULL,
  `teacher_id` INT NOT NULL,
  `period_id` INT NOT NULL,
  `course_id` INT NOT NULL,
  `batch` INT NOT NULL,
  PRIMARY KEY (`section_id`),
  INDEX `fk_section_teacher1_idx` (`teacher_id` ASC) VISIBLE,
  INDEX `fk_section_period1_idx` (`period_id` ASC) VISIBLE,
  INDEX `fk_section_course1_idx` (`course_id` ASC) VISIBLE,
  CONSTRAINT `fk_section_teacher1`
    FOREIGN KEY (`teacher_id`)
    REFERENCES `university`.`teacher` (`teacher_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_section_period1`
    FOREIGN KEY (`period_id`)
    REFERENCES `university`.`period` (`period_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_section_course1`
    FOREIGN KEY (`course_id`)
    REFERENCES `university`.`course` (`course_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`student` (
  `student_id` INT NOT NULL,
  `first_name` VARCHAR(20) NOT NULL,
  `last_name` VARCHAR(20) NOT NULL,
  `gender` ENUM('F', 'M') NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(2) NOT NULL,
  `birthdate` DATE NOT NULL,
  PRIMARY KEY (`student_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`student_enrolls_section`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`student_enrolls_section` (
  `student_id` INT NOT NULL,
  `section_id` INT NOT NULL,
  PRIMARY KEY (`student_id`, `section_id`),
  INDEX `fk_student_has_section_section1_idx` (`section_id` ASC) VISIBLE,
  INDEX `fk_student_has_section_student1_idx` (`student_id` ASC) VISIBLE,
  CONSTRAINT `fk_student_has_section_student1`
    FOREIGN KEY (`student_id`)
    REFERENCES `university`.`student` (`student_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_student_has_section_section1`
    FOREIGN KEY (`section_id`)
    REFERENCES `university`.`section` (`section_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

/*
################################################
################################################
          ADD DATA TO THE DB
################################################
################################################
*/

--DONE
INSERT INTO university.college
VALUES
  (1,"College of Physical Science and Engineering"),
  (2,"College of Business and Communication"),
  (3,"College of Language and Letters");

--DONE
INSERT INTO university.department
VALUES 
  (1, "Computer Information Technology", "CIT"),
  (2, "Economics", "ECON"),
  (3, "Humanities and Philosophy", "HUM");

--DONE
INSERT INTO university.course
VALUES
  (1, "Intro to Databases", 3, 1, 1, 111),
  (2, "Econometrics", 4, 2, 2, 388),
  (3, "Micro Economics", 3, 2, 2, 150),
  (4, "Classical Heritage", 2, 3, 3, 376);

--DONE
INSERT INTO university.student
VALUES
  (1, "Paul", "Miller", "M", "Dallas", "TX", "1996-02-22"),
  (2, "Katie", "Smith", "F", "Provo", "UT", "1995-07-22"),
  (3, "Kelly", "Jones", "F", "Provo", "UT", "1998-06-22"),
  (4, "Devon", "Merrill", "M", "Mesa", "AZ", "2000-07-22"),
  (5, "Mandy", "Murdock", "F", "Topeka", "KS", "1996-11-22"),
  (6, "Alece", "Adams", "F", "Rigby", "ID", "1997-05-22"),
  (7, "Bryce", "Carlson", "M", "Bozeman", "MT", "1997-11-22"),
  (8, "Preston", "Larsen", "M", "Decatur", "TN", "1996-09-22"),
  (9, "Julia",	"Madsen", "F", "Rexburg", "ID", "1998-09-22"),
  (10, "Susan", "Sorensen", "F", "Mesa", "AZ", "1998-08-09");

--DONE
INSERT INTO university.teacher
VALUES
  (1, "Marty", "Morring", 30),
  (2, "Nate", "Norris", 50),
  (3, "Ben", "Barrus", 35),
  (4, "John", "Jensen", 30),
  (5, "Bill", "Barney", 35);

--DONE
INSERT INTO university.period
VALUES
  (1, 2019, "Fall"),
  (2, 2018, "Winter");

INSERT INTO university.section
VALUES
  (1, 1, 1, 1, 1),
  (2, 2, 1, 3, 1),
  (3, 2, 1, 3, 2),
  (4, 3, 1, 2, 1),
  (5, 4, 1, 4, 1),
  (6, 1, 2, 1, 2),
  (7, 5, 2, 1, 3),
  (8, 2, 2, 3, 1),
  (9, 2, 2, 3, 2),
  (10, 4, 2, 4, 1);

INSERT INTO university.student_enrolls_section
VALUES
  (6, 7),
  (7, 6),
  (7, 8),
  (7, 10),
  (4, 5),
  (9, 9),
  (2, 4),
  (3, 4),
  (5, 4),
  (5, 5),
  (1, 1),
  (1, 3),
  (8, 9),
  (10, 6);

/*
################################################
################################################
          QUERIES WK6 PROJECT
################################################
################################################
*/

/*
 !!! QUERY 1 !!!
Students, and their birthdays, of students born in September.
Format the date to look like it is shown in the result set. Sort by the student's last name.
*/

SELECT first_name, last_name, DATE_FORMAT(birthdate, '%M %e, %Y') AS "Sept Birthdays"
FROM university.student
WHERE MONTH(birthdate) = 9
ORDER BY last_name;

/*
 !!! QUERY 2 !!!
Student's age in years and days as of Jan. 5, 2017.
Sorted from oldest to youngest. (You can assume a 365 day year and ignore leap day.)
Hint: Use modulus for days left over after years. The 5th column is just the 3rd and 4th column combined with labels.
*/
SELECT last_name,
       first_name,
       TIMESTAMPDIFF(YEAR, birthdate, "2017-01-05") AS "Years",
       MOD(TIMESTAMPDIFF(DAY, birthdate, '2017-01-05'), 365) AS "Days",
       CONCAT(
          TIMESTAMPDIFF(YEAR, birthdate, "2017-01-05"),
          " - Yrs, ",
          MOD(TIMESTAMPDIFF(DAY, birthdate, '2017-01-05'), 365),
          " - Days"
       ) AS "Years and Days"
FROM university.student
ORDER BY birthdate;

/*
 !!! QUERY 3 !!!
Students taught by John Jensen. Sorted by student's last name
*/
SELECT stu.first_name, stu.last_name
FROM university.student stu
  JOIN university.student_enrolls_section ses
  ON stu.student_id = ses.student_id
  JOIN university.section sec
  ON ses.section_id = sec.section_id
  JOIN university.teacher tea
  ON tea.teacher_id = sec.teacher_id
WHERE tea.first_name = "John" AND tea.last_name = "Jensen"
ORDER BY stu.last_name;

/*
 !!! QUERY 4 !!!
Instructors Bryce will have in Winter 2018. Sort by the faculty's last name.
*/
SELECT tea.first_name, tea.last_name
FROM university.student stu
  JOIN university.student_enrolls_section ses
  ON stu.student_id = ses.student_id
  JOIN university.section sec
  ON ses.section_id = sec.section_id
  JOIN university.teacher tea
  ON tea.teacher_id = sec.teacher_id
  JOIN university.period p
  ON sec.period_id = p.period_id
WHERE stu.first_name = "Bryce" AND p.year = 2018 AND p.term = "Winter"
ORDER BY tea.last_name;

/*
 !!! QUERY 5 !!!
Students that take Econometrics in Fall 2019. Sort by student last name.
*/
SELECT stu.first_name, stu.last_name
FROM university.student stu
  JOIN university.student_enrolls_section ses
  ON stu.student_id = ses.student_id
  JOIN university.section sec
  ON ses.section_id = sec.section_id
  JOIN university.period p
  ON sec.period_id = p.period_id
  JOIN university.course c
  ON sec.course_id = c.course_id
WHERE p.year = 2019 AND p.term = "Fall" AND c.course_title = "Econometrics" 
ORDER BY stu.last_name;

/*
 !!! QUERY 6 !!!
Report showing all of Bryce Carlson's courses for Winter 2018. Sort by the name of the course.
*/
SELECT d.department_code, c.course_num, c.course_title
FROM university.student stu
  JOIN university.student_enrolls_section ses
  ON stu.student_id = ses.student_id
  JOIN university.section sec
  ON ses.section_id = sec.section_id
  JOIN university.period p
  ON sec.period_id = p.period_id
  JOIN university.course c
  ON sec.course_id = c.course_id
  JOIN university.department d
  ON c.department_id = d.department_id
WHERE p.year = 2018 AND p.term = "Winter" AND stu.first_name = "Bryce" AND stu.last_name = "Carlson"
ORDER BY c.course_title;

/*
 !!! QUERY 7 !!!
The number of students enrolled for Fall 2019
*/
SELECT p.term, p.year, COUNT(stu.first_name) AS "Enrollment"
FROM university.student stu
  JOIN university.student_enrolls_section ses
  ON stu.student_id = ses.student_id
  JOIN university.section sec
  ON ses.section_id = sec.section_id
  JOIN university.period p
  ON sec.period_id = p.period_id
WHERE p.year = 2019 AND p.term = "Fall";

/*
 !!! QUERY 8 !!!
The number of courses in each college. Sort by college name.
*/
SELECT colg.college_name, COUNT(cour.course_id)
FROM university.course cour
  JOIN university.college colg
  ON cour.college_id = colg.college_id
GROUP BY colg.college_name
ORDER BY colg.college_name;

/*
 !!! QUERY 9 !!!
The total number of students each professor can teach in Winter 2018.
Sort by that total number of students (teaching capacity).

ASSUMPTION DONE: Based on the information given I realize all professors had the same capacity in each wave/batch/section. Besides was stated professor/teacher/faculty
is the one who assigned the capacity. So capacity was placed within teacher entity thinking was going to be FIX VALUE as data given displayed
*/
SELECT tea.first_name, tea.last_name, tea.capacity
FROM university.teacher tea
  JOIN university.section sec
  ON sec.teacher_id = tea.teacher_id
  JOIN university.period p
  ON sec.period_id = p.period_id
WHERE p.year = 2018 AND p.term = "Winter"
GROUP BY tea.first_name, tea.last_name, tea.capacity
ORDER BY capacity;

/*
 !!! QUERY 10 !!!
Each student's total credit load for Fall 2019,
but only students with a credit load greater than three.
Sort by credit load in descending order. 
*/
SELECT stu.last_name, stu.first_name, SUM(c.credits) AS "Credits"
FROM university.student stu
  JOIN university.student_enrolls_section stuenroll
  ON stuenroll.student_id = stu.student_id
  JOIN university.section sec
  ON sec.section_id = stuenroll.section_id
  JOIN university.period p
  ON p.period_id = sec.period_id
  JOIN university.course c
  ON c.course_id = sec.course_id
WHERE p.year = 2019 AND p.term = "Fall"
GROUP BY stu.first_name, stu.last_name
HAVING Credits > 3
ORDER BY Credits DESC;