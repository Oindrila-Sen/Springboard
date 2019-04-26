/* Welcome to the SQL mini project. For this project, you will use
Springboard' online SQL platform, which you can log into through the
following link:

https://sql.springboard.com/
Username: student
Password: learn_sql@springboard

The data you need is in the "country_club" database. This database
contains 3 tables:
    i) the "Bookings" table,
    ii) the "Facilities" table, and
    iii) the "Members" table.

Note that, if you need to, you can also download these tables locally.

In the mini project, you'll be asked a series of questions. You can
solve them using the platform, but for the final deliverable,
paste the code for each solution into this script, and upload it
to your GitHub.

Before starting with the questions, feel free to take your time,
exploring the data, and getting acquainted with the 3 tables. */



/* Q1: Some of the facilities charge a fee to members, but some do not.
Please list the names of the facilities that do. */

SELECT name
FROM  `Facilities` 
WHERE membercost >0

Output:
Tennis Court 1
Tennis Court 2
Massage Room 1
Massage Room 2
Squash Court


/* Q2: How many facilities do not charge a fee to members? */

SELECT COUNT( * ) 
FROM  `Facilities` 
WHERE membercost =0

Output:4

/* Q3: How can you produce a list of facilities that charge a fee to members,
where the fee is less than 20% of the facility's monthly maintenance cost?
Return the facid, facility name, member cost, and monthly maintenance of the
facilities in question. */

SELECT  `facid` ,  `name` ,  `membercost` ,  `monthlymaintenance` 
FROM  `Facilities` 
WHERE membercost < ( 20 /100 * monthlymaintenance ) 
AND membercost <> 0

Output:

facid	name	membercost	monthlymaintenance	
0	Tennis Court 1	5.0	200
1	Tennis Court 2	5.0	200
4	Massage Room 1	9.9	3000
5	Massage Room 2	9.9	3000
6	Squash Court	3.5	80


/* Q4: How can you retrieve the details of facilities with ID 1 and 5?
Write the query without using the OR operator. */
SELECT * 
FROM `Facilities` 
WHERE facid IN (1,5)

Output:
facid	name	membercost	guestcost	initialoutlay	monthlymaintenance	
1	Tennis Court 2	5.0	    25.0	    8000	        200
5	Massage Room 2	9.9	    80.0	    4000	        3000

/* Q5: How can you produce a list of facilities, with each labelled as
'cheap' or 'expensive', depending on if their monthly maintenance cost is
more than $100? Return the name and monthly maintenance of the facilities
in question. */

SELECT name , 
monthlymaintenance,
CASE WHEN monthlymaintenance > 100
   THEN 'Expensive'
   ELSE 'Cheap' END "Label"
FROM `Facilities` 

Output:

name	              monthlymaintenance	  Label	
Tennis Court 1	        200	                  Expensive
Tennis Court 2	        200	                  Expensive
Badminton Court	        50	                  Cheap
Table Tennis	        10	                  Cheap
Massage Room 1	        3000	              Expensive
Massage Room 2	        3000	              Expensive
Squash Court	        80	                  Cheap
Snooker Table	        15	                  Cheap
Pool Table	            15	                  Cheap


/* Q6: You'd like to get the first and last name of the last member(s)
who signed up. Do not use the LIMIT clause for your solution. */

SELECT firstname, surname
FROM  `Members` 
WHERE joindate = ( SELECT MAX( joindate ) FROM Members )

Output:
firstname   surname
Darren      Smith


/* Q7: How can you produce a list of all members who have used a tennis court?
Include in your output the name of the court, and the name of the member
formatted as a single column. Ensure no duplicate data, and order by
the member name. */

SELECT DISTINCT f.name court_name, concat(m.firstname, ' ', m.surname) member_name
FROM  `Bookings` b, 
      `Facilities` f,
      `Members` m
WHERE  b.facid = f.facid
AND    b.memid = m.memid
AND UPPER( f.name ) LIKE  '%TENNIS%'
order by 2

Output:

court_name     member_name
Table Tennis   Anna Mackenzie
Tennis Court 1 Anne Baker
Tennis Court 2 Anne Baker
Table Tennis   Anne Baker
Tennis Court 2 Burton Tracy
Tennis Court 1 Burton Tracy
Table Tennis   Burton Tracy
Tennis Court 2 Charles Owen
Tennis Court 1 Charles Owen
Table Tennis   Charles Owen
Table Tennis   Darren Smith
Tennis Court 2 Darren Smith
Tennis Court 1 David Farrell
Tennis Court 2 David Farrell
Table Tennis   David Jones
Tennis Court 1 David Jones
Tennis Court 2 David Jones
Table Tennis   David Pinker
Tennis Court 1 David Pinker
Tennis Court 1 Douglas Jones
Table Tennis Erica Crumpet
Tennis Court 1 Erica Crumpet
Tennis Court 2 Florence Bader
Tennis Court 1 Florence Bader
Table Tennis   Florence Bader
Tennis Court 2 Gerald Butters
Tennis Court 1 Gerald Butters
Table Tennis   Gerald Butters
Tennis Court 2 GUEST GUEST
Tennis Court 1 GUEST GUEST

/* Q8: How can you produce a list of bookings on the day of 2012-09-14 which
will cost the member (or guest) more than $30? Remember that guests have
different costs to members (the listed costs are per half-hour 'slot'), and
the guest user's ID is always 0. Include in your output the name of the
facility, the name of the member formatted as a single column, and the cost.
Order by descending cost, and do not use any subqueries. */

SELECT DISTINCT f.name facilty_name, CONCAT( m.firstname,  ' ', m.surname ) AS member_name, 
CASE WHEN m.memid = 0
THEN f.guestcost * b.slots
ELSE f.membercost * b.slots
END AS booking_cost
FROM  `Bookings` b,  `Facilities` f,  `Members` m
WHERE f.facid = b.facid
AND m.memid = b.memid
AND ((b.starttime LIKE  '2012-09-14%'AND m.memid =0 AND (f.guestcost * b.slots) >30)
OR (b.starttime LIKE  '2012-09-14%'AND m.memid <>0 AND (f.membercost * b.slots >30)))
ORDER BY 3 DESC 


Output:

facilty_name	member_name	booking_cost	
Massage Room 2  GUEST GUEST	320.0.0
Massage Room 1	GUEST GUEST	160.0.0
Tennis Court 2	GUEST GUEST	150.0
Tennis Court 1	GUEST GUEST	75.0
Tennis Court 2	GUEST GUEST	75.0
Squash Court    GUEST GUEST 70.0
Massage Room 1  Jemima Farrell 39.6
Squash Court    GUEST GUEST 35.0

/* Q9: This time, produce the same result as in Q8, but using a subquery. */

SELECT distinct facilty_name,member_name,booking_cost
FROM (
SELECT f.name facilty_name, 
     CONCAT( m.firstname,  ' ', m.surname ) AS member_name, 
     CASE WHEN b.memid =0
     THEN f.guestcost * b.slots
     ELSE f.membercost * b.slots
     END AS booking_cost
FROM Bookings b,
     Facilities f, 
    Members m
WHERE b.facid = f.facid
AND b.memid = m.memid
AND b.starttime LIKE  '2012-09-14%'
)sub
WHERE sub.booking_cost >30
ORDER BY sub.booking_cost DESC

Output:

facilty_name	member_name	booking_cost	
Massage Room 2  GUEST GUEST	320.0.0
Massage Room 1	GUEST GUEST	160.0.0
Tennis Court 2	GUEST GUEST	150.0
Tennis Court 1	GUEST GUEST	75.0
Tennis Court 2	GUEST GUEST	75.0
Squash Court    GUEST GUEST 70.0
Massage Room 1  Jemima Farrell 39.6
Squash Court    GUEST GUEST 35.0

/* Q10: Produce a list of facilities with a total revenue less than 1000.
The output of facility name and total revenue, sorted by revenue. Remember
that there's a different cost for guests and members! */
SELECT combined.facility_name,
       combined.total_revenue
  FROM (SELECT f.name AS facility_name,
               SUM(CASE WHEN m.memid = 0
                        THEN (f.guestcost * b.slots)
                        ELSE (f.membercost * b.slots) 
                        END) AS total_revenue
          FROM `Bookings` b,
              `Facilities` f,
              `Members` m
            WHERE f.facid = b.facid
            AND m.memid = b.memid
         GROUP BY 1) combined
 WHERE combined.total_revenue < 1000
 ORDER BY 2 DESC
 
 
 Output:

facility_name	total_revenue	
Pool Table	    270.0
Snooker Table	240.0
Table Tennis	180.0