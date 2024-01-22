
-- -----------------------------------------------------
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Create database and tables > DDL
-- -----------------------------------------------------
-- -----------------------------------------------------
-- -----------------------------------------------------

-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema art_gallery
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema art_gallery
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `art_gallery` DEFAULT CHARACTER SET utf8 ;
USE `art_gallery` ;

-- -----------------------------------------------------
-- Table `art_gallery`.`artist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `art_gallery`.`artist` (
  `artist_id` INT NOT NULL AUTO_INCREMENT,
  `fname` VARCHAR(30) NOT NULL,
  `mname` VARCHAR(30) NULL,
  `lname` VARCHAR(30) NOT NULL,
  `dob` INT NOT NULL,
  `dod` INT NULL,
  `country` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`artist_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `art_gallery`.`subject`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `art_gallery`.`subject` (
  `subject_id` INT NOT NULL AUTO_INCREMENT,
  `keyword` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`subject_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `art_gallery`.`artwork`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `art_gallery`.`artwork` (
  `artwork_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(60) NOT NULL,
  `year` INT NOT NULL,
  `style` VARCHAR(30) NOT NULL,
  `type` VARCHAR(30) NOT NULL,
  `file` VARCHAR(60) NOT NULL,
  `artist_id` INT NOT NULL,
  PRIMARY KEY (`artwork_id`, `artist_id`),
  INDEX `fk_artwork_artist_idx` (`artist_id` ASC) VISIBLE,
  CONSTRAINT `fk_artwork_artist`
    FOREIGN KEY (`artist_id`)
    REFERENCES `art_gallery`.`artist` (`artist_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `art_gallery`.`artwork_has_subject`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `art_gallery`.`artwork_has_subject` (
  `artwork_id` INT NOT NULL,
  `artist_id` INT NOT NULL,
  `subject_id` INT NOT NULL,
  PRIMARY KEY (`artwork_id`, `artist_id`, `subject_id`),
  INDEX `fk_artwork_has_subject_subject1_idx` (`subject_id` ASC) VISIBLE,
  INDEX `fk_artwork_has_subject_artwork1_idx` (`artwork_id` ASC, `artist_id` ASC) VISIBLE,
  CONSTRAINT `fk_artwork_has_subject_artwork1`
    FOREIGN KEY (`artwork_id` , `artist_id`)
    REFERENCES `art_gallery`.`artwork` (`artwork_id` , `artist_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_artwork_has_subject_subject1`
    FOREIGN KEY (`subject_id`)
    REFERENCES `art_gallery`.`subject` (`subject_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- -----------------------------------------------------
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Create database and tables > DML
-- -----------------------------------------------------
-- -----------------------------------------------------
-- -----------------------------------------------------


USE art_gallery;

/*Insert records into ARTIST table*/
INSERT INTO artist
	(fname,mname,lname,dob,dod,country)
VALUES 
	("Vincent",NULL,"van Gogh",1853,1890,"France"),
	("Rembrandt","Harmenszoon","van Rijn",1606,1669,"Netherlands"),
	("Leonardo",NULL,"da Vinci",1452,1519,"Italy"),
	("Venture","Lonzo","Coy",1965,NULL,"United States"),
	("Deborah",NULL,"Gill",1970,NULL,"United States"),
	("Claude",NULL,"Monet",1840,1926,"France"),
	("Pablo",NULL,"Picasso",1904,1973,"Spain"),
	("Michelangelo","di Lodovico","Simoni",1475,1564,"Italy");

/*Insert records into SUBJECT table*/
INSERT INTO subject
	(keyword)
VALUES
	("flowers"),
	("blue"),
	("landscape"),
	("girl"),
	("people"),
	("battle"),
	("boat"),
	("water"),
	("Christ"),
	("food"),
	("baby");