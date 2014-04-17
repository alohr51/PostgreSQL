--Andrew Lohr--

--Drop PreReqsFor--
DROP FUNCTION PreReqsFor(integer);

--Create--
CREATE OR REPLACE FUNCTION PreReqsFor(courseNumber integer)
RETURNS SETOF integer AS $$
	Select prereqnum
	from Prerequisites
	where coursenum = courseNumber;

$$ LANGUAGE sql;

--Query Test--
select PreReqsFor(499);



--Drop IsPreReqsFor--
DROP FUNCTION IsPrereqsFor(integer);

--Create--
CREATE OR REPLACE FUNCTION IsPreReqsFor(courseNumber integer)
RETURNS SETOF integer AS $$

	Select coursenum
	from Prerequisites
	where prereqnum = courseNumber;

$$ LANGUAGE sql;

--Query Test--
select IsPreReqsFor(220);