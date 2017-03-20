connStr <- 'Driver={SQL Server};Server=XXX.xxx.xxx.xxx;Database=RProject;Uid=sa;Pwd=XXXXXXX'

sampleDataQuery <- "SELECT TOP 1000 tipped, fare_amount, 
      passenger_count,trip_time_in_secs,trip_distance,  
      pickup_datetime, dropoff_datetime, pickup_longitude, 
       pickup_latitude, dropoff_longitude,    
        dropoff_latitude 
FROM nyctaxi_sample 
"
inDataSource <- RxSqlServerData(sqlQuery = sampleDataQuery, connectionString = connStr,
colClasses = c(pickup_longitude = "numeric", pickup_latitude = "numeric",
     dropoff_longitude = "numeric", dropoff_latitude = "numeric"),
     rowsPerRead = 500)

rxHistogram( ~ fare_amount, data = inDataSource, title = "Fare Amount Histogram")


rxGetVarInfo(data = inDataSource)