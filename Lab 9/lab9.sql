--Andrew Lohr--
--4/14/14


--Clear--
DROP TABLE IF EXISTS crew;
DROP TABLE IF EXISTS catalog;
DROP TABLE IF EXISTS engineers;
DROP TABLE IF EXISTS flightControlOperators;
DROP TABLE IF EXISTS astronauts;
DROP TABLE IF EXISTS spacecrafts;
DROP TABLE IF EXISTS systems;
DROP TABLE IF EXISTS suppliers;
DROP TABLE IF EXISTS parts;


-- engineers --
CREATE TABLE engineers (
  eid            char(3) not null,
  fname          text,
  lname	         text,
  age		 smallint,
  sex		 text,
  highestDegree  text,
  favVideoGame   text,
 primary key(eid)
);


-- astronauts --
CREATE TABLE astronauts (
  aid                char(3) not null,
  fname              text,
  lname	             text,
  age                smallint,
  yearsFlying        smallint,
  golfHandicap       smallint,
 primary key(aid)
);        


-- flightControlOperators --
CREATE TABLE flightControlOperators (
  fid              char(3) not null,
  fname            text,
  lname	           text,
  age              smallint,
  drinkChoice      text,
  chairChoice      text,
 primary key(fid)
);


-- spacecrafts -- 
CREATE TABLE spacecrafts (
  sid              char(3) not null,
  name             text,
  tailNumber	   text,
  weightTons       int,
  fuelType         text,
  crewCapacity     int,
 primary key(sid)
);

-- crew (which astronauts flew on which spaceships) -- 
CREATE TABLE crew (
  cid      char(3) not null,
  aid      char(3) not null references astronauts(aid),    
  sid      char(3) not null references spacecrafts(sid),
 primary key(cid)
);

-- systems -- 
CREATE TABLE systems (
  sysid            char(5) not null,
  name             text,
  description      text,
  warnings         text,
 primary key(sysid)
);

-- parts -- 
CREATE TABLE parts (
  pid              char(3) not null,
  name             text,
  description      text,
 primary key(pid)
);

-- suppliers -- 
CREATE TABLE suppliers (
  supid            char(5) not null,
  name             text,
  stNumber         varchar(10),
  stName	   text,
  city		   text,
  zipCode	   varchar(5),
  paymentTerms     text,
  primary key(supid)
);

--who supplied what parts--
CREATE TABLE catalog (
  catid    char(5) not null,
  supid   char(5) not null references suppliers(supid),    
  pid      char(3) not null references parts(pid),
 primary key(catid)
);

--INSERT STATEMENTS--

-- engineers --
INSERT INTO engineers(eid, fname, lname, age, highestDegree, favVideoGame)
  VALUES('e01', 'Son', 'Goku', 42, 'some elementary','DBZ:Raging Blast');
  
INSERT INTO engineers(eid, fname, lname, age, sex, highestDegree, favVideoGame)
  VALUES('e02', 'Austin', 'Powers', 36,'yes please', 'Spy Academy','Goldeneye 007');
  
--astronauts--
INSERT INTO astronauts(aid, fname, lname, age, yearsFlying, golfHandicap)
  VALUES('a01', 'Sterling', 'Archer', 34, 0, 36);

INSERT INTO astronauts(aid, fname, lname, age, yearsFlying, golfHandicap)
  VALUES('a02', 'Lana', 'Kane', 32, 1, 36);

--Flight Control Operators--
INSERT INTO flightControlOperators(fid, fname, lname, age, drinkChoice,chairChoice)
  VALUES('f01', 'Barney', 'Stinson', 31, 'scotch straight', 'office chair');

INSERT INTO flightControlOperators(fid, fname, lname, age, drinkChoice,chairChoice)
  VALUES('f02', 'James', 'Bond', 37, 'Vodka Martini, shaken not stirred', 'none');

  
--spacecrafts-
INSERT INTO spacecrafts(sid, name, tailNumber, weightTons,fuelType,crewCapacity)
  VALUES('s01', 'The Moon Beamer', 2112, 5, 'monomethyl hydrazine', 6);

INSERT INTO spacecrafts(sid, name, tailNumber, weightTons,fuelType,crewCapacity)
  VALUES('s02', 'The Rocket In Your Pocket', 311, 3.4, 'hope', 10);


--crew--
INSERT INTO crew(cid, aid,sid)
  VALUES('c01', 'a01','s01');
  
INSERT INTO crew(cid, aid,sid)
  VALUES('c02', 'a01','s02');

INSERT INTO crew(cid, aid,sid)
  VALUES('c03', 'a02','s01');

--systems--
INSERT INTO systems(sysid, name, description,warnings)
  VALUES('sys01', 'HeartBleed','keeps track of fuel intake','do not touch');

INSERT INTO systems(sysid, name, description,warnings)
  VALUES('sys02', 'Hyrule','filters dark energy out of spacecraft','do not use the triforce of power for dark things');

--parts--
INSERT INTO parts(pid, name, description)
  VALUES('p01', 'master sword','in case of emergency');

INSERT INTO parts(pid, name, description)
  VALUES('p02', 'engine','makes you fly');

--suppliers--
INSERT INTO suppliers(supid, name,stNumber,stName,city,zipCode,paymentTerms)
  VALUES('sup01', 'Marist College',3399,'North Road','poughkeepsie','12601','all your money');

INSERT INTO suppliers(supid, name,stNumber,stName,city,zipCode,paymentTerms)
  VALUES('sup02','Boeing','12','Boeing Dr.','detroit','65821','cash');

--catalog--
INSERT INTO catalog(catid, supid,pid)
  VALUES('cat01','sup01','p01');

INSERT INTO catalog(catid, supid,pid)
  VALUES('cat02','sup01','p02');

INSERT INTO catalog(catid, supid,pid)
  VALUES('cat03','sup02','p02');
 

--QUERIES--
select * 
from engineers;

select * 
from astronauts;

select * 
from flightControlOperators;

select * 
from spacecrafts;

select * 
from crew;

select * 
from systems;

select * 
from parts;

select * 
from suppliers;

select * 
from catalog;
