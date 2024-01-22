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
  INDEX `fk_artwork_artist1_idx` (`artist_id` ASC) VISIBLE,
  CONSTRAINT `fk_artwork_artist1`
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
  `subject_id` INT NOT NULL,
  PRIMARY KEY (`artwork_id`, `subject_id`),
  INDEX `fk_artwork_has_subject_subject1_idx` (`subject_id` ASC) VISIBLE,
  INDEX `fk_artwork_has_subject_artwork_idx` (`artwork_id` ASC) VISIBLE,
  CONSTRAINT `fk_artwork_has_subject_artwork`
    FOREIGN KEY (`artwork_id`)
    REFERENCES `art_gallery`.`artwork` (`artwork_id`)
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
-- Insert data > DML
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

/*Insert records into ARTWORK table*/
/*Note that a SELECT is utilized to retrieve the ID, so this insertion is not dependant on a fixed value*/
INSERT INTO artwork
  (title,year,style,type,file,artist_id)
VALUES
  ("Irises",1889,"Impressionism","Oil","irises.jpg",(SELECT artist_id FROM artist WHERE fname = "Vincent" and lname = "van Gogh")),
  ("The Starry Night",1889,"Post-Impressionism","Oil","starrynight.jpg",(SELECT artist_id FROM artist WHERE fname = "Vincent" and lname = "van Gogh")),
  ("Sunflowers",1888,"Post-impressionism","Oil","sunflowers.jpg",(SELECT artist_id FROM artist WHERE fname = "Vincent" and lname = "van Gogh")),
  ("Night Watch",1642,"Baroque","Oil","nightwatch.jpg",(SELECT artist_id FROM artist WHERE fname = "Rembrandt" and lname = "van Rijn")),
  ("Storm on the Sea of Galilee",1633,"Dutch Golden Age","Oil","stormgalilee.jpg",(SELECT artist_id FROM artist WHERE fname = "Rembrandt" and lname = "van Rijn")),
  ("Head of a Woman",1508,"High Renaissance","Oil","headwoman.jpg",(SELECT artist_id FROM artist WHERE fname = "Leonardo" and lname = "da Vinci")),
  ("Last Supper",1498,"Renaissance","Tempra ","lastsupper.jpg",(SELECT artist_id FROM artist WHERE fname = "Leonardo" and lname = "da Vinci")),
  ("Mona Lisa",1517,"Renaissance","Oil","monalisa.jpg",(SELECT artist_id FROM artist WHERE fname = "Leonardo" and lname = "da Vinci")),
  ("Hillside Stream",2005,"Modern","Oil","hillsidestream.jpg",(SELECT artist_id FROM artist WHERE fname = "Venture" and lname = "Coy")),
  ("Old Barn",1992,"Modern","Oil","oldbarn.jpg",(SELECT artist_id FROM artist WHERE fname = "Venture" and lname = "Coy")),
  ("Beach Baby",1999,"Modern","Watercolor","beachbaby.jpg",(SELECT artist_id FROM artist WHERE fname = "Deborah" and lname = "Gill")),
  ("Women in the Garden",1866,"Impressionism","Oil","womengarden.jpg",(SELECT artist_id FROM artist WHERE fname = "Claude" and lname = "Monet")),
  ("Old Guitarist",1904,"Modern","Oil","guitarist.jpg",(SELECT artist_id FROM artist WHERE fname = "Pablo" and lname = "Picasso"));

/*Insert records into ARTWORK HAS SUBJECT table*/
INSERT INTO artwork_has_subject
  (artwork_id, subject_id)
VALUES
  ((SELECT artwork_id FROM artwork WHERE title = "Irises"), (SELECT subject_id FROM subject WHERE keyword = "flowers")),
  ((SELECT artwork_id FROM artwork WHERE title = "The Starry Night"), (SELECT subject_id FROM subject WHERE keyword = "blue")),
  ((SELECT artwork_id FROM artwork WHERE title = "The Starry Night"), (SELECT subject_id FROM subject WHERE keyword = "landscape")),
  ((SELECT artwork_id FROM artwork WHERE title = "Sunflowers"), (SELECT subject_id FROM subject WHERE keyword = "flowers")),
  ((SELECT artwork_id FROM artwork WHERE title = "Night Watch"), (SELECT subject_id FROM subject WHERE keyword = "girl")),
  ((SELECT artwork_id FROM artwork WHERE title = "Night Watch"), (SELECT subject_id FROM subject WHERE keyword = "people")),
  ((SELECT artwork_id FROM artwork WHERE title = "Night Watch"), (SELECT subject_id FROM subject WHERE keyword = "battle")),
  ((SELECT artwork_id FROM artwork WHERE title = "Storm on the Sea of Galilee"), (SELECT subject_id FROM subject WHERE keyword = "boat")),
  ((SELECT artwork_id FROM artwork WHERE title = "Storm on the Sea of Galilee"), (SELECT subject_id FROM subject WHERE keyword = "water")),
  ((SELECT artwork_id FROM artwork WHERE title = "Storm on the Sea of Galilee"), (SELECT subject_id FROM subject WHERE keyword = "people")),
  ((SELECT artwork_id FROM artwork WHERE title = "Storm on the Sea of Galilee"), (SELECT subject_id FROM subject WHERE keyword = "Christ")),
  ((SELECT artwork_id FROM artwork WHERE title = "Head of a Woman"), (SELECT subject_id FROM subject WHERE keyword = "girl")),
  ((SELECT artwork_id FROM artwork WHERE title = "Head of a Woman"), (SELECT subject_id FROM subject WHERE keyword = "people")),
  ((SELECT artwork_id FROM artwork WHERE title = "Last Supper"), (SELECT subject_id FROM subject WHERE keyword = "food")),
  ((SELECT artwork_id FROM artwork WHERE title = "Last Supper"), (SELECT subject_id FROM subject WHERE keyword = "people")),
  ((SELECT artwork_id FROM artwork WHERE title = "Last Supper"), (SELECT subject_id FROM subject WHERE keyword = "Christ")),
  ((SELECT artwork_id FROM artwork WHERE title = "Mona Lisa"), (SELECT subject_id FROM subject WHERE keyword = "girl")),
  ((SELECT artwork_id FROM artwork WHERE title = "Mona Lisa"), (SELECT subject_id FROM subject WHERE keyword = "people")),
  ((SELECT artwork_id FROM artwork WHERE title = "Hillside Stream"), (SELECT subject_id FROM subject WHERE keyword = "water")),
  ((SELECT artwork_id FROM artwork WHERE title = "Hillside Stream"), (SELECT subject_id FROM subject WHERE keyword = "landscape")),
  ((SELECT artwork_id FROM artwork WHERE title = "Old Barn"), (SELECT subject_id FROM subject WHERE keyword = "landscape")),
  ((SELECT artwork_id FROM artwork WHERE title = "Beach Baby"), (SELECT subject_id FROM subject WHERE keyword = "water")),
  ((SELECT artwork_id FROM artwork WHERE title = "Beach Baby"), (SELECT subject_id FROM subject WHERE keyword = "people")),
  ((SELECT artwork_id FROM artwork WHERE title = "Beach Baby"), (SELECT subject_id FROM subject WHERE keyword = "baby")),
  ((SELECT artwork_id FROM artwork WHERE title = "Women in the Garden"), (SELECT subject_id FROM subject WHERE keyword = "landscape")),
  ((SELECT artwork_id FROM artwork WHERE title = "Women in the Garden"), (SELECT subject_id FROM subject WHERE keyword = "people")),
  ((SELECT artwork_id FROM artwork WHERE title = "Women in the Garden"), (SELECT subject_id FROM subject WHERE keyword = "flowers")),
  ((SELECT artwork_id FROM artwork WHERE title = "Old Guitarist"), (SELECT subject_id FROM subject WHERE keyword = "blue")),
  ((SELECT artwork_id FROM artwork WHERE title = "Old Guitarist"), (SELECT subject_id FROM subject WHERE keyword = "people"));


-- -----------------------------------------------------
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Define VIEWS and PROCEDURES
-- -----------------------------------------------------
-- -----------------------------------------------------
-- -----------------------------------------------------

-- -----------------------------------------------------
-- For artist interaction
-- -----------------------------------------------------

/*Generate a 'calculated column' into virtual table provided by view to state if artist is local or not*/
CREATE VIEW list_artist_a_to_z 
AS SELECT fname, mname, lname, dob, dod, country, CASE WHEN country = 'United States' THEN "Y" ELSE "N" END AS islocal
FROM artist
ORDER BY fname, lname ASC;

/*Generate a 'calculated column' into virtual table provided by view to state if artist is local or not*/
CREATE VIEW list_artist_sort_by_dob 
AS SELECT fname, mname, lname, dob, dod, country, CASE WHEN country = 'United States' THEN "Y" ELSE "N" END AS islocal
FROM artist
ORDER BY dob ASC;

/*Generate a 'calculated column' into virtual table provided by view to state if artist is local or not*/
CREATE VIEW list_artist_sort_randomly
AS SELECT fname, mname, lname, dob, dod, country, CASE WHEN country = 'United States' THEN "Y" ELSE "N" END AS islocal
FROM artist
ORDER BY RAND();

/*Views do not support parameter so it is implemented procedure*/
CREATE PROCEDURE SelectArtistWithinPeriod(IN StartYear INT, IN EndYear INT)
SELECT fname, mname, lname, dob, dod, country
FROM artist
WHERE dob BETWEEN StartYear AND EndYear;

/*Views do not support parameter so it is implemented procedure*/
CREATE PROCEDURE SelectArtistFromCountry(IN CountrySearch VARCHAR(255))
SELECT fname, mname, lname, dob, dod
FROM artist
WHERE country = CountrySearch;

-- -----------------------------------------------------
-- For artwork interaction
-- -----------------------------------------------------

/*Views do not support parameter so it is implemented procedure*/
CREATE PROCEDURE SelectArtworkByStyle(IN StyleSearch VARCHAR(255))
SELECT title, year, style, type, file
FROM artwork
WHERE style = StyleSearch;

/*Views do not support parameter so it is implemented procedure*/
CREATE PROCEDURE SelectArtworkByType(IN TypeSearch VARCHAR(255))
SELECT title, year, style, type, file
FROM artwork
WHERE type = TypeSearch;

/*Views do not support parameter so it is implemented procedure*/
CREATE PROCEDURE SelectArtworkWithinPeriod(IN StartYear INT, IN EndYear INT)
SELECT title, year, style, type, file
FROM artwork
WHERE year BETWEEN StartYear AND EndYear;