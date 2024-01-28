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