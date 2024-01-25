/*
##############
##############

INSERT SAMPLES TO UNDERSTAND WHICH TABLES ARE AND HOW THEY ARE ASSEMBLED

##############
##############
*/


/*## ARTWORK TABLE ##*/
INSERT INTO artwork
	(artist_id, title, year, period, description, type, location, donated, file)
VALUES
	(?, ?, ?, ?, ?, ?, ?, ?, ?);

/*## KEYBRIDGE TABLE (many to many rel table) ##*/
INSERT INTO keybridge
	(keyword_id, artwork_id)
VALUES
	(?, ?);

/*## KEYWORD TABLE ##*/
INSERT INTO keyword
	(keyword)
VALUES
	(?);



/*

## REQS ##
1) Add a new artist
2) Edit an existing artist
3) Delete an existing artist
4) Add a new artwork > COVERED by SQL statement displayed applied within PHP Code. Besides artwork table is mentioned on an INSERT INTO with its columns
5) Edit an existing artwork > COVERED by SQL statement displayed applied within PHP Code. Besides artwork table is mentioned on an INSERT INTO with its columns
6) Delete an existing artwork > COVERED by SQL statement displayed applied within PHP Code. Besides artwork table is mentioned on an INSERT INTO with its columns
*/

/*

In order to accomplish the points 1,2 & 3 is needed
- Creating ARTIST table
- Add at least one artist
- Edit an existing artist
- Delete an existing artist

*/

-- I guess artist table does not exist because SQL command is not displayed --
-- So I created artist table --
CREATE TABLE 'artist'(
	'artist_id' INT NOT NULL AUTO_INCREMENT,
	'first_name' VARCHAR(30) NOT NULL,
	'last_name' VARCHAR(30) NOT NULL,
	'year_birth' INT NOT NULL,
	'country' VARCHAR(60) NOT NULL,
	PRIMARY KEY ('artist_id')
);

--Based on previous assumption I added a foreign key and reference to ARTWORK table--
ALTER TABLE artwork
ADD CONSTRAINT fk_artist
FOREIGN KEY (artist_id) REFERENCES artist(artist_id);

--In order to delete an artist follow template below--
DELETE FROM artist
WHERE artist_id = ?;

--In Order to update an artist follow template below--
UPDATE artist SET
	first_name = ?,
	last_name = ?,
	year_birth = ?,
	country = ?
WHERE artist_id = ?;