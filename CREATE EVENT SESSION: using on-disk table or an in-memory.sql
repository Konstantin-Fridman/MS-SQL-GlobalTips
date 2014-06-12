CREATE EVENT SESSION ES_window_spool ON SERVER 
    ADD EVENT sqlserver.window_spool_ondisk_warning 
  ( ACTION (sqlserver.plan_handle, sqlserver.sql_text) ) 
    ADD TARGET package0.asynchronous_file_target   
  ( SET FILENAME = N'E:\ES_window_spool.xel'
	   , metadatafile = 'E:\ES_window_spool.xem' );

ALTER EVENT SESSION ES_window_spool ON SERVER STATE = START;

	SELECT #1
	SELECT #2
DROP EVENT SESSION ES_window_spool ON SERVER

-- Read file E:\ES_window_spool.xel
