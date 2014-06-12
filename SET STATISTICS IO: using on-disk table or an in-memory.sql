 -- Test whether SQL Server used an on-disk work table or an in-memory one
 
 SET STATISTICS IO ON; 
 Select #1
 Select #2
 SET STATISTICS IO OFF; 
-- 9999 PRECEDING AND 9999 PRECEDING, 6 seconds Table 'Worktable'. Scan count 0, ...
-- 10000 PRECEDING AND 10000 PRECEDING, 33 seconds Table 'Worktable'. Scan count 2000100, logical reads 12086700, ...
