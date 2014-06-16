/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*\
	Id	Value ===> Id  Value ===> Id  Value	
	1	A	  	   1   A		  1   A
	1	B		   2   A   		  1   B
	2	A		   3   C		  2   A
	2	A		      			  2   C
	2	A					      3   C
	2	C		    		      3   Z
	2	C	
	2	C	
	3	C	  
	3	Z	
\*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
WITH ListOfData AS (
SELECT DISTINCT 
	   Id, Value
  FROM (
VALUES (1, 'A'),
	   (1, 'B'),
	   (2, 'A'),
	   (2, 'C'),
	   (2, 'A'),
	   (2, 'C'),
	   (2, 'A'),
	   (2, 'C'),
	   (3, 'C'),
	   (3, 'Z') ) AS Tab( Id, Value)
) 

, OrderedList AS (
	SELECT Id
		 , Value
		 , ROW_NUMBER() OVER ( PARTITION BY Id ORDER BY Value) AS RN
	  FROM ListOfData )

, Results AS (
	-- Get the first row for each Id, ordered by value
	SELECT Id
		 , Value
		 , RN
	  FROM OrderedList
	 WHERE RN = 1

	UNION ALL -- Recursion 
	SELECT A.Id
		 , Z.Value
		 , Z.RN
	  FROM Results A
CROSS APPLY ( SELECT B.Value , B.RN FROM OrderedList B WHERE A.Id = B.Id AND A.RN + 1 = B.RN ) Z

) 

	SELECT Id
		 , Value 
	  FROM Results
  ORDER BY Id
		 , Value




--==========================================================================================
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*\
| Another way to run the cursor's update over an index "INDEX(1)"
\*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
DECLARE @prevaccount AS INT,
        @prevbalance AS MONEY;

UPDATE X
SET    @prevbalance = balance = CASE
                                  WHEN actid = @prevaccount THEN @prevbalance + val
                                  ELSE val
                                END,
       @prevaccount = actid
FROM   #Transactions X WITH(INDEX(1), TABLOCKX)
OPTION (MAXDOP 1); 

