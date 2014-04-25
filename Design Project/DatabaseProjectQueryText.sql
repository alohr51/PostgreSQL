--Andrew Lohr--
--Final Databse Project--
--4/21/14


--Clear--
DROP TABLE IF EXISTS playerTeam;
DROP TABLE IF EXISTS refField;
DROP TABLE IF EXISTS teamHomeField;
DROP TABLE IF EXISTS administration;
DROP TABLE IF EXISTS field;
DROP TABLE IF EXISTS teamRecord;
DROP TABLE IF EXISTS referee;
DROP VIEW IF EXISTS generalUser;
DROP TABLE IF EXISTS teamCoach;
DROP TABLE IF EXISTS teamLog;
DROP TABLE IF EXISTS team;
DROP TABLE IF EXISTS coach;
DROP TABLE IF EXISTS player;
DROP TABLE IF EXISTS people;
DROP TABLE IF EXISTS zipcode;
DROP ROLE IF EXISTS Administrator;
DROP FUNCTION IF EXISTS winlossratio(text);
DROP FUNCTION IF EXISTS auditTeam();
DROP FUNCTION IF EXISTS bestTeam();


    
-- zipcodes --
CREATE TABLE zipcode (
  zip        	 varchar(10) not null,
  town		 text,
  stateAbbrv     text
  check (length(stateAbbrv)=2),
  primary key(zip)
);


INSERT INTO zipcode(zip,town,stateAbbrv)
  VALUES('07452','Glen Rock','NJ');
  
INSERT INTO zipcode(zip,town,stateAbbrv)
  VALUES('07450','Ridgewood','NJ');
  
INSERT INTO zipcode(zip,town,stateAbbrv)
  VALUES('07652','Paramus','NJ');


-- People --
CREATE TABLE people (
  pid                char(3) not null,
  fname              text not null,
  lname	             text not null,
  age                smallint,
  address            varchar(255),
  zipcode	     varchar(10) references zipcode(zip),
  phoneNum           varchar(10) not null,
  email		     varchar(99),
 primary key(pid)
);        


INSERT INTO people(pid,fname,lname, age, address, zipcode, phoneNum, email)
  VALUES('p01','Andrew','Lohr',21,'555 Doremus Ave', '07452' ,'2013456789','andrew@me.com');
  
INSERT INTO people(pid,fname,lname, age, address, zipcode, phoneNum, email)
  VALUES('p02','Sean','Miller',21,'615 Radburn Road', '07452' ,'2017888485','swMiller@yoohoo.com');
  
INSERT INTO people(pid,fname,lname, age, address, zipcode, phoneNum, email)
  VALUES('p03','Matt','Howard',22,'66 Harristown Road', '07452' ,'2014546689','maHow@aol.com');
  
INSERT INTO people(pid,fname,lname, age, address, zipcode, phoneNum, email)
  VALUES('p04','William','Spichiger',20,'10 Rodney St', '07452' ,'2016827764','spich@optonline.com');
  
INSERT INTO people(pid,fname,lname, age, address, zipcode, phoneNum, email)
  VALUES('p05','Jon','Suarez',23,'789 Doremus Ave', '07452' ,'2013456456','footballJon51@gmail.com');

-- coach --
CREATE TABLE coach (
  isCertified boolean default FALSE,
 primary key(pid),
 foreign key (zipcode) references zipcode(zip)
)inherits(people);

INSERT INTO coach(pid,fname,lname, age, address, zipcode, phoneNum, email)
  VALUES('p06','Joe','Schmo',43,'229 Doremus Ave', '07452' ,'2546786456','coachJoe@gmail.com');

INSERT INTO coach(pid,fname,lname, age, address, zipcode, phoneNum, email)
  VALUES('p07','Ray','Charles',58,'229 Main st', '07652' ,'2115846589','Rayyyy@gmail.com');

INSERT INTO coach(pid,fname,lname, age, address, zipcode, phoneNum, email,isCertified)
  VALUES('p08','Paul','Rudd',46,'229 noFriend Ave', '07450' ,'2534777456','PaulieR@aol.com',true);

INSERT INTO coach(pid,fname,lname, age, address, zipcode, phoneNum, email,isCertified)
  VALUES('p09','Jason','Segal',41,'229 Marshall Lane', '07450' ,'2655255456','McClarens@optonline.com',true);

  
-- player -- 
CREATE TABLE player(
  skill1Low10High    smallint not null
  check (skill1Low10High between 0 and 10),
  allergies	     text,
  medicalConditions text,
  foreign key(zipcode) references zipcode(zip),  
  primary key(pid)
)inherits (people);

INSERT INTO player(pid,fname,lname, age, address, zipcode, phoneNum, email,skill1Low10High, allergies,medicalConditions)
  VALUES('p10','Jennifer','Anniston',24,'229 friends rd', '07450' ,'2653455456','iloveross@optonline.com',2,'leather','asthma');

INSERT INTO player(pid,fname,lname, age, address, zipcode, phoneNum, email,skill1Low10High)
  VALUES('p11','Leonardo','Dicaprio',29,'229 inception ave', '07452' ,'262355456','theHeartGoesOn@titanic.com',8);

INSERT INTO player(pid,fname,lname, age, address, zipcode, phoneNum, email,skill1Low10High, allergies,medicalConditions)
  VALUES('p12','Jonny','Depp',28,'229 secret rd', '07452' ,'2653455444','YoHoYoHo@blackPerl.com',1,'black powder','schizophrenia');

--Administration -- 
CREATE TABLE administration (
  title			text not null,
  salaryPerSeasonUSD	numeric(12,2) not null,
  foreign key(zipcode) references zipcode(zip), 
  primary key(pid)
)inherits (people);

INSERT INTO administration(pid,fname,lname, age, address, zipcode, phoneNum, email,title, salaryPerSeasonUSD)
  VALUES('p13','Johnny','Cash',58,'55 fire ring rd', '07450' ,'3653455455','CashMoney@aol.com','president',6000.00);

INSERT INTO administration(pid,fname,lname, age, address, zipcode, phoneNum, email,title, salaryPerSeasonUSD)
  VALUES('p14','Mila','Kunis',23,'101 Hawaiian lane', '07452' ,'9646773252','forgetSarah@msn.com','vice president',4800.00);

INSERT INTO administration(pid,fname,lname, age, address, zipcode, phoneNum, email,title, salaryPerSeasonUSD)
  VALUES('p15','Kate','Austen',28,'Lost court', '07652' ,'4815162342','BlackMist@yahoo.com','secretary',3500.00);

-- referee -- 
CREATE TABLE referee (
 foreign key(zipcode) references zipcode(zip), 
 primary key(pid)
)inherits(people);

INSERT INTO referee(pid,fname,lname, age, address, zipcode, phoneNum, email)
  VALUES('p16','Peter','Griffin',35,'35 Quohog St', '07652' ,'1115162388','PeaTearGriffin@hotmail.com');

INSERT INTO referee(pid,fname,lname, age, address, zipcode, phoneNum, email)
  VALUES('p17','Glen','Quagmire',30,'39 Quohog St', '07652' ,'9288736647','GiggidyGiggidy@gmail.com');

INSERT INTO referee(pid,fname,lname, age, address, zipcode, phoneNum, email)
  VALUES('p18','Joe','Swanson',36,'99 Quohog St', '07652' ,'8277632343','WheelchairWonder@hotmail.com');


-- field -- 
CREATE TABLE field (
  fid              char(3) not null,
  name             text,
  address          text,
  zipcode 	   varchar(10) references zipcode(zip),
  primary key(fid)
);

INSERT INTO field(fid,name,address,zipcode)
  VALUES('f01','faber field','845 Doremus Ave','07452');

INSERT INTO field(fid,name,address,zipcode)
  VALUES('f02','Main st field','22 Main St','07652');
  
INSERT INTO field(fid,name,address,zipcode)
  VALUES('f03','Alan Deaett field','45 Harristown Road','07450');

-- team -- 
CREATE TABLE team (
  tid              char(3) not null,
  name             text not null,
  mascot           text,
  zipcode 	   varchar(10) references zipcode(zip),
  primary key(tid)
);

--Drop Trigger--
DROP TRIGGER IF EXISTS teamAudit on team;

-- teamLog -- 
CREATE TABLE teamLog (
  logid            serial primary key,
  tid              char(3) references team(tid) not null,
  entryDate 	   text not null
);


--procedure for trigger--
CREATE FUNCTION auditTeam() RETURNS TRIGGER AS $doAudit$
    BEGIN
        INSERT INTO teamLog(tid, entryDate) VALUES (new.tid, current_timestamp);
        RETURN NEW;
    END;
$doAudit$ LANGUAGE plpgsql;


--team Trigger--
CREATE TRIGGER teamAudit AFTER INSERT ON team
FOR EACH ROW EXECUTE PROCEDURE auditTeam();

INSERT INTO team(tid,name,mascot,zipcode)
  VALUES('t01','Glen Rock','Panthers','07452');

INSERT INTO team(tid,name,mascot,zipcode)
  VALUES('t02','Big Bad Men','lumberjack','07450');

INSERT INTO team(tid,name,mascot,zipcode)
  VALUES('t03','Doughboys','Pillsbury Dough Boy','07652');

INSERT INTO team(tid,name,mascot,zipcode)
  VALUES('t04','Rockers','A rock','07652');


-- refField -- 
CREATE TABLE refField (
  pid              char(3) references referee(pid),
  fid              char(3) references field(fid),
  primary key(pid,fid)
);

INSERT INTO refField(pid,fid)
  VALUES('p16','f01');

INSERT INTO refField(pid,fid)
  VALUES('p18','f03');

INSERT INTO refField(pid,fid)
  VALUES('p17','f02');


-- teamHomeField -- 
CREATE TABLE teamHomeField (
  tid             char(3) references team(tid),
  fid             char(3) references field(fid),
  primary key(tid, fid)
);

INSERT INTO teamHomeField(tid,fid)
  VALUES('t01','f02');

INSERT INTO teamHomeField(tid,fid)
  VALUES('t03','f01');

INSERT INTO teamHomeField(tid,fid)
  VALUES('t02','f03');

--teamCoach--
CREATE TABLE teamCoach (
  pid     char(3) references coach(pid),
  tid	  char(3) references team(tid),
 primary key(pid,tid)
);

INSERT INTO teamCoach(pid,tid)
  VALUES('p06', 't01');
  
INSERT INTO teamCoach(pid,tid)
  VALUES('p08', 't02');

INSERT INTO teamCoach(pid,tid)
  VALUES('p09', 't03');
  
--playerTeam--
CREATE TABLE playerTeam (
  pid     char(3) references player(pid),
  tid	  char(3) references team(tid),
 primary key(pid,tid)
);

INSERT INTO playerTeam(pid,tid)
  VALUES('p10', 't03');

INSERT INTO playerTeam(pid,tid)
  VALUES('p12', 't03');

INSERT INTO playerTeam(pid,tid)
  VALUES('p11', 't01');

--teamRecords--
CREATE TABLE teamRecord (
  tid     char(3) references team(tid),
  win	  int check(win >= 0),
  loss    int check(loss >= 0),
 primary key(tid)
);

INSERT INTO teamRecord(tid,win,loss)
  VALUES('t03', 4, 7);

INSERT INTO teamRecord(tid,win,loss)
  VALUES('t01', 7, 4);

INSERT INTO teamRecord(tid,win,loss)
  VALUES('t02', 0, 0);

INSERT INTO teamRecord(tid,win,loss)
  VALUES('t04', 0, 0);
 

--Sample Queries--

--List all teams who have no players assigned to them.--

select name
from team
where tid
not in(
select tid
from playerTeam
);

--List all players and the team assigned to them.--

select people.fname,people.lname, team.name as TeamName
from people
inner join playerTeam
	on people.pid = playerTeam.pid
inner join team
	on team.tid = playerTeam.tid;


--List homefields of each team--

select team.name as teamname, field.name as fieldname
from field
inner join teamHomeField
	on field.fid = teamHomeField.fid
inner join team
	on team.tid = teamHomeField.tid;


--List the coaches of each team--
select team.name as teamname, coach.fname,coach.lname,coach.phoneNum, coach.email
from coach
inner join teamCoach
	on coach.pid = teamCoach.pid
inner join team
	on team.tid = teamCoach.tid;


--teams and their records--
select team.name,teamRecord.win,teamRecord.loss
from team
inner join teamRecord
	on team.tid = teamRecord.tid;


--Create Win/Loss Ratio function--
CREATE FUNCTION winLossRatio(teamName text) RETURNS numeric AS $$

Declare
	winLossRatio numeric(4,3);
	wins integer :=(select win
		    from teamRecord
		    where tid
		    in(	
		    Select tid
		    from team
		    where teamName = team.name
		    ));
	losses integer :=(select loss
		    from teamRecord
		    where tid
		    in(	
		    Select tid
		    from team
		    where teamName = team.name
		    ));
	begin
	--do not want to divide by 0!!--
	if losses != 0 then
		select(wins::float / losses) into winLossRatio;
	else
		winLossRatio := 0;
	end if;
	
	return winLossRatio;
	end;

$$ LANGUAGE plpgsql;



--Best Team()--

CREATE FUNCTION bestTeam() RETURNS text AS $$

Declare
	aTeam record;
	bestTeam text;
	maxRatio numeric(4,3);
	tempRatio numeric(4,3);
begin
	tempRatio := 0;
	maxRatio := 0;
	bestTeam := 'test';
	for aTeam in select name from team
	loop
		tempRatio := winLossRatio(aTeam.name);
		
		if tempRatio >= maxRatio then
			bestTeam := aTeam.name;
			maxRatio := tempRatio;
		end if;
	end loop;

	return bestTeam;
end;
$$ LANGUAGE plpgsql;

--View team and coach for gen user--
create view generalUser as
	Select team.name, coach.fname,coach.lname
	from team
	inner join teamCoach
		on team.tid = teamCoach.tid
	inner join coach
		on coach.pid = teamCoach.pid;

--League Admin--
create user Administrator with password '@dm!n';
Grant select, insert,update,delete on coach, player,team,referee,field,refField,
teamHomefield,teamCoach,playerTeam,teamRecord,administration,people,zipcode to Administrator;

--Basic Queries--
select * from zipcode;
select * from people;
select * from coach;
select * from player;
select * from administration;
select * from referee;
select * from field;
select * from team;
select * from teamLog;
select * from refField;
select * from teamHomeField;
select * from teamCoach;
select * from playerTeam;
select * from teamRecord;
select winLossRatio('Rockies');
select bestTeam();
