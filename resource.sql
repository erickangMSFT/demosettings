SELECT TOP 100  
  'cpu_percent' as type,
  end_time as time,
  avg_cpu_percent as resource
FROM sys.dm_db_resource_stats 
where avg_cpu_percent > 0
union
SELECT TOP 100
  'data_io_percent' as type,
  end_time as time,
  avg_data_io_percent as resource
FROM sys.dm_db_resource_stats 
where avg_data_io_percent > 0
union
SELECT TOP 100
  'log_write_percent' as type,
  end_time as time,
  avg_log_write_percent as resource
FROM sys.dm_db_resource_stats 
where avg_log_write_percent > 0
order by end_time desc;