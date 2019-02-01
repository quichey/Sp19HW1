DROP VIEW IF EXISTS q0, q1i, q1ii, q1iii, q1iv, q2i, q2ii, q2iii, q3i, q3ii, q3iii, q4i, q4ii, q4iii, q4iv, q4v;

-- Question 0
CREATE VIEW q0(era)
AS
  SELECT MAX(era)
  FROM pitching
;

-- Question 1i
CREATE VIEW q1i(namefirst, namelast, birthyear)
AS
  SELECT namefirst, namelast, birthyear
  FROM people
  WHERE weight > 300
;

-- Question 1ii
CREATE VIEW q1ii(namefirst, namelast, birthyear)
AS
  SELECT namefirst, namelast, birthyear
  FROM people
  WHERE namefirst LIKE '% %'
;

-- Question 1iii
CREATE VIEW q1iii(birthyear, avgheight, count)
AS
  SELECT birthyear, AVG(height), COUNT(*)
  FROM people
  GROUP BY birthyear
  ORDER BY birthyear ASC
;

-- Question 1iv
CREATE VIEW q1iv(birthyear, avgheight, count)
AS
  SELECT *
  FROM q1iii
  WHERE avgheight > 70
  ORDER BY birthyear ASC
;

-- Question 2i
CREATE VIEW q2i(namefirst, namelast, playerid, yearid)
AS
  SELECT namefirst, namelast, playerid, yearid
  FROM people NATURAL JOIN halloffame
  WHERE inducted = 'Y'
  ORDER BY yearid DESC
;

-- Question 2ii
CREATE VIEW q2ii(namefirst, namelast, playerid, schoolid, yearid)
AS
  SELECT q.namefirst, q.namelast, q.playerid, c.schoolid, q.yearid
  FROM q2i AS q, collegeplaying AS c, schools AS s
  WHERE q.playerid = c.playerid AND c.schoolid = s.schoolid
    AND s.schoolstate = 'CA'
  ORDER BY q.yearid DESC, c.schoolid ASC, q.playerid ASC
;

-- Question 2iii
CREATE VIEW q2iii(playerid, namefirst, namelast, schoolid)
AS
  SELECT q.playerid, q.namefirst, q.namelast, c.schoolid
  FROM q2i AS q LEFT JOIN collegeplaying AS c
  ON q.playerid = c.playerid
  ORDER BY q.playerid DESC, c.schoolid ASC
;

-- Question 3i
CREATE VIEW q3i(playerid, namefirst, namelast, yearid, slg)
AS
  SELECT b.playerid, p.namefirst, p.namelast, b.yearid,
    CAST(b.h + b.h2b + 2*b.h3b + 3*b.hr AS float)
    / CAST(b.ab AS float) AS slg
  FROM batting AS b, people AS p
  WHERE b.playerid = p.playerid AND b.ab > 50
  ORDER BY slg DESC, b.yearid ASC
  LIMIT 10
;

-- Question 3ii
CREATE VIEW q3ii(playerid, namefirst, namelast, lslg)
AS
  WITH lifetimebat (playerid, h, h2b, h3b, hr, ab) AS
    (SELECT playerid, SUM(h), SUM(h2b), SUM(h3b), SUM(hr), SUM(ab)
    FROM batting
    GROUP BY playerid)
  SELECT b.playerid, p.namefirst, p.namelast,
    CAST(b.h + b.h2b + 2*b.h3b + 3*b.hr AS float)
    / CAST(b.ab AS float) AS lslg
  FROM lifetimebat AS b, people AS p
  WHERE b.playerid = p.playerid AND b.ab > 50
  ORDER BY lslg DESC, b.playerid ASC
  LIMIT 10
;

-- Question 3iii
CREATE VIEW q3iii(namefirst, namelast, lslg)
AS
  WITH lifetimebat (playerid, h, h2b, h3b, hr, ab) AS
    (SELECT playerid, SUM(h), SUM(h2b), SUM(h3b), SUM(hr), SUM(ab)
    FROM batting
    GROUP BY playerid),
    lifetimeslug (playerid, slug, ab) AS
    (SELECT playerid, CAST(h + h2b + 2*h3b + 3*hr AS float)
    / CAST(ab AS float), ab
    FROM lifetimebat
    WHERE ab > 0),
    targetPlayerSlug (slug) AS
    (SELECT slug
    FROM lifetimeslug
    WHERE playerid = 'mayswi01')
  SELECT namefirst, namelast, l.slug
  FROM lifetimeslug AS l, targetPlayerSlug AS t, people AS p
  WHERE l.slug > t.slug AND l.playerid = p.playerid AND ab > 50
;

-- Question 4i
CREATE VIEW q4i(yearid, min, max, avg, stddev)
AS
  SELECT 1, 1, 1, 1, 1 -- replace this line
;

-- Question 4ii
CREATE VIEW q4ii(binid, low, high, count)
AS
  SELECT 1, 1, 1, 1 -- replace this line
;

-- Question 4iii
CREATE VIEW q4iii(yearid, mindiff, maxdiff, avgdiff)
AS
  SELECT 1, 1, 1, 1 -- replace this line
;

-- Question 4iv
CREATE VIEW q4iv(playerid, namefirst, namelast, salary, yearid)
AS
  SELECT 1, 1, 1, 1, 1 -- replace this line
;
-- Question 4v
CREATE VIEW q4v(team, diffAvg) AS
  SELECT 1, 1 -- replace this line
;
