--Clear--
DROP TABLE IF EXISTS casting;
DROP TABLE IF EXISTS actors;
DROP TABLE IF EXISTS movieDirectorConnection;
DROP TABLE IF EXISTS movies;
DROP TABLE IF EXISTS directors;


-- Actors --
CREATE TABLE actors (
  aid            char(3) not null,
  fname          text,
  lname	         text,
  address        text,
  birthDate      date,
  hairColor      text,
  eyeColor       text,
  HeightInches   integer,
  weightLbs      integer,
  sagAnniversary date,
 primary key(aid)
);


-- Directors --
CREATE TABLE directors (
  did                char(3) not null,
  fname              text,
  lname	             text,
  address            text,
  filmSchoolAttended text,
  dgAnniversary      date,
 primary key(did)
);        


-- Movies --
CREATE TABLE movies (
  mid                    char(3) not null,
  title                  text,
  yearReleased           text,
  domesticBoxOfficeSales numeric(15,2),
  foreignBoxOfficeSales  numeric(15,2),
  dvdAndBluRaySales      numeric(15,2),
 primary key(mid)
);


-- Casting -- 
CREATE TABLE casting (
  cid        char(3) not null,
  aid        char(3) not null references actors(aid),    
  mid        char(3) not null references movies(mid),
  rating     integer,
  CONSTRAINT rating CHECK (rating BETWEEN 1 AND 10),
 primary key(cid)
);

--movieDirectorConnection--
CREATE TABLE movieDirectorConnection (
  mdid    char(6) not null,
  did     char(3) not null references directors(did),    
  mid     char(3) not null references movies(mid),
 primary key(mdid)
);


-- actors --
INSERT INTO actors( aid, fname, lname, address, birthDate, hairColor, eyeColor, heightInches, weightLbs,sagAnniversary)
  VALUES('a01', 'Sean', 'Connery', '32 bond lane', '19300825','white','brown',72,207,'19950215');
  
INSERT INTO actors( aid, fname, lname, address, birthDate, hairColor, eyeColor, heightInches, weightLbs,sagAnniversary)
  VALUES('a02', 'Jennifer', 'Aniston', '111 cary drive', '19690211','dirty blonde','brown',65,120,'19991102');
  
INSERT INTO actors( aid, fname, lname, address, birthDate, hairColor, eyeColor, heightInches, weightLbs,sagAnniversary)
  VALUES('a03', 'Andrew', 'Lohr', '3399 North Road', '19911118','brown','blue',70,225,'20140401');
  
INSERT INTO actors( aid, fname, lname, address, birthDate, hairColor, eyeColor, heightInches, weightLbs,sagAnniversary)
  VALUES('a04', 'Chris', 'Pratt', '26 opera road', '19790621','dirty blonde','brown',73,200,'20140126');
  
--directors--
INSERT INTO directors( did, fname, lname, address, filmSchoolAttended,dgAnniversary)
  VALUES('d01', 'John', 'McTiernan', '44 red circle', 'Center for kids who cant read good','19920317');

INSERT INTO directors( did, fname, lname, address, filmSchoolAttended,dgAnniversary)
  VALUES('d02', 'Lewis', 'Gilbert', '007 gun court', 'You Only Direct Twice','19670611');

INSERT INTO directors( did, fname, lname, address, filmSchoolAttended,dgAnniversary)
  VALUES('d03', 'Chris', 'Buck', '344 froze road', 'Let It Go Institute','20140219');

INSERT INTO directors( did, fname, lname, address, filmSchoolAttended,dgAnniversary)
  VALUES('d04', 'Jenn', 'Lee', '500 castle lane', 'Love is an open door Institute','20140219');

INSERT INTO directors( did, fname, lname, address, filmSchoolAttended,dgAnniversary)
  VALUES('d05', 'Spike', 'Jonze', '15 op road', 'Operating Systems School','20130522');

--Movies--
INSERT INTO movies( mid, title, yearReleased, domesticBoxOfficeSales,foreignBoxOfficeSales,dvdAndBluRaySales)
  VALUES('m01', 'Frozen', '2014', 398000000.00, 674000000.00,125000000.00);

INSERT INTO movies( mid, title, yearReleased, domesticBoxOfficeSales,foreignBoxOfficeSales,dvdAndBluRaySales)
  VALUES('m02', 'You Only Live Twice', '1967', 43084787.00, 68500000.00,12000000.00);

INSERT INTO movies( mid, title, yearReleased, domesticBoxOfficeSales,foreignBoxOfficeSales,dvdAndBluRaySales)
  VALUES('m03', 'Her', '2013', 25481216.00, 16779074.00,8000000.00);

INSERT INTO movies( mid, title, yearReleased, domesticBoxOfficeSales,foreignBoxOfficeSales,dvdAndBluRaySales)
  VALUES('m04', 'The Hunt for Red October', '1990', 120709868.00, 78500000.00,25000000.00);

INSERT INTO movies( mid, title, yearReleased, domesticBoxOfficeSales,foreignBoxOfficeSales,dvdAndBluRaySales)
  VALUES('m05', 'Were The Millers', '2013', 26419396.00, 35000000.00,15000000.00);

--Casting-
INSERT INTO casting( cid, aid, mid, rating)
  VALUES('c01', 'a01', 'm02', 6);

INSERT INTO casting( cid, aid, mid, rating)
  VALUES('c02', 'a01', 'm04', 8);

INSERT INTO casting( cid, aid, mid, rating)
  VALUES('c03', 'a02', 'm05', 7);

 INSERT INTO casting( cid, aid, mid, rating)
  VALUES('c04', 'a03', 'm01', 10);

 INSERT INTO casting( cid, aid, mid, rating)
  VALUES('c05', 'a04', 'm03', 7);

--MovieDirectorConnection--
INSERT INTO MovieDirectorConnection( mdid, did, mid)
  VALUES('mdid01', 'd01', 'm04');

INSERT INTO MovieDirectorConnection( mdid, did, mid)
  VALUES('mdid02', 'd02', 'm02');

INSERT INTO MovieDirectorConnection( mdid, did, mid)
  VALUES('mdid03', 'd03', 'm01');

INSERT INTO MovieDirectorConnection( mdid, did, mid)
  VALUES('mdid04', 'd04', 'm01');

INSERT INTO MovieDirectorConnection( mdid, did, mid)
  VALUES('mdid05', 'd05', 'm03');


/*Query to find all directors Sean Connery worked with
Finds Seans aid, the searches casting for that aid to
get all movies Sean was in. Then it searchers MovieDirectorConnection
to find which directors directed those movies-only gets the id (did)
so one final search to get the name of the directors in the directors
table using the did, too much?
*/

select fname,lname
from directors
where did
in(
select did
from MovieDirectorConnection
where mid
in(  
select mid
from casting
where aid 
in(
   select aid 
  from actors
  where fname = 'Sean' and lname = 'Connery')))
