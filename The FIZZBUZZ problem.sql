-- Write a program that prints the numbers from 1 to 100.
-- But for multiples of three print “Fizz” instead of the number 
-- and for the multiples of five print “Buzz”.
-- For numbers which are multiples of both three and five print “FizzBuzz”.

WITH L0(Id) AS (SELECT 1 UNION ALL SELECT 1) -- Returns 2^1 Rows
	,L1(Id) AS (SELECT Lst.Id FROM L0 AS Lst CROSS JOIN L0) -- Returns 2^2 Rows -- 4
	,L2(Id) AS (SELECT Lst.Id FROM L1 AS Lst CROSS JOIN L1) -- Returns 2^2^2 Rows -- 16
	,L3(Id) AS (SELECT Lst.Id FROM L2 AS Lst CROSS JOIN L2) -- Returns 2^2^2^2 Rows -- 256
--	,L4(Id) AS (SELECT Lst.Id FROM L3 AS Lst CROSS JOIN L3) -- Returns 2^2^2^2^2 Rows

SELECT CASE WHEN Id % 3 = 0 THEN 'Fizz' ELSE '' END + 
	   CASE WHEN Id % 5 = 0 THEN 'Buzz' ELSE '' END +
	   CASE WHEN Id % 3 <> 0 
	         AND Id % 5 <> 0 THEN CAST(Id AS VARCHAR(3)) ELSE '' END
FROM 
(
	SELECT TOP 100 ROW_NUMBER() OVER ( ORDER BY ( SELECT (NULL) ) ) AS Id
	  FROM L3
) Z
 
