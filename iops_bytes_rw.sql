-- File name:   iops_bytes_rw.sql
-- Purpose:     display iops info read write and total  
--                                                                                                                
-- Usage:       @iops_bytes_rw.sql
--------------------------------------------------------------------------------
PROMPT IOPS over the he last 60 seconds
PROMPT 
PROMPT rkbs and wrkbs read/wrote bytes per second
PROMPT rtkbs and wtkbs , Total : except to controlfile I/O

select
       round((sum(decode(metric_name, 'Physical Read Bytes Per Sec' , value,0)))/1024,0)  rkbps,
       round((sum(decode(metric_name, 'Physical Read Total Bytes Per Sec' , value,0)))/1024,0) rtkbps,
       round((sum(decode(metric_name, 'Physical Read Total IO Requests Per Sec' , value,0 ))),1) rtops,
       round((sum(decode(metric_name, 'Physical Write Bytes Per Sec' , value,0 )))/1024,0)  wbps,
       round((sum(decode(metric_name, 'Physical Write Total Bytes Per Sec' , value,0 )))/1024,0) wtbps,
       round((sum(decode(metric_name, 'Physical Write Total IO Requests Per Sec', value,0 ))),1) wtops
from  v$sysmetric
where metric_name in (
                    'Physical Read Total Bytes Per Sec' ,
                    'Physical Read Bytes Per Sec' ,
                    'Physical Write Bytes Per Sec' ,
                    'Physical Write Total Bytes Per Sec' ,
                    'Physical Write Total IO Requests Per Sec',
                    'Physical Read Total IO Requests Per Sec'
                    )
and group_id=2;
