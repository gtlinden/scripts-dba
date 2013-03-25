-- File name:   backup_size.sql
-- Purpose:     Check the size of backup x days past 
--                                                                                                                
-- Usage:       @backup_size.sql
--------------------------------------------------------------------------------
PROMPT 
PROMPT Provide days back in history:
PROMPT 
set linesize 400 heading off
set heading on pagesize 200
column status format a10;
column comamnd_id for a32;
column input_type format a10;
column time_taken_display format a10;
column input_bytes_display format a12;
column output_bytes_display format a12;
column Start_Time format a15;
column output_bytes_per_sec_display format a10;
column ses_key format 9999999;
column ses_recid format 9999999;
column device_type format a10;

SELECT b.session_key ses_key,
       b.session_recid ses_recid,
       b.command_id,
       b.input_type,
       b.status,
       to_char(b.start_time,'DD-MM-YY HH24:MI') Start_Time,
       b.time_taken_display,
       b.output_device_type device_type,
       b.input_bytes_display
FROM   v$rman_backup_job_details b
WHERE  b.start_time > (SYSDATE - &amp)
ORDER BY b.start_time desc
/

