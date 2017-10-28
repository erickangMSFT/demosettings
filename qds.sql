WITH SlowestQry AS( 
    SELECT TOP 5  
        q.query_id, 
        --MAX(rs.max_duration ) max_duration 
        rs.max_duration max_duration
    FROM sys.query_store_query AS q     
    JOIN sys.query_store_plan AS p ON q.query_id = p.query_id    
    JOIN sys.query_store_runtime_stats AS rs ON p.plan_id = rs.plan_id   
    WHERE rs.last_execution_time > DATEADD(week, -1, GETUTCDATE()) 
    AND is_internal_query = 0 
    --GROUP BY q.query_id 
    --ORDER BY MAX(rs.max_duration ) DESC
    ORDER BY rs.max_duration DESC
    ) 
SELECT  
    tq.query_id,  
    format(rs.last_execution_time,'yyyy-MM-dd hh:mm:ss') as [last_execution_time],
    rs.max_duration  
--    p.plan_id 
FROM SlowestQry tq       
    JOIN sys.query_store_plan AS p ON tq.query_id = p.query_id    
    JOIN sys.query_store_runtime_stats AS rs ON p.plan_id = rs.plan_id   
WHERE rs.last_execution_time > DATEADD(week, -1, GETUTCDATE())    
order by format(rs.last_execution_time,'yyyy-MM-dd hh:mm:ss') DESC

