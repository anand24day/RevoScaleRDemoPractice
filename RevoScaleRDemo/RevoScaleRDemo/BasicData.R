# string Connection
connStr <- 'Driver={SQL Server};Server=192.168.142.185;Database=RProject;Uid=sa;Pwd=ANAND2day'

# Query for data 

sampleDataQuery <- "SELECT TOP 1000 tipped, fare_amount, 
       passenger_count,trip_time_in_secs,trip_distance,   
       pickup_datetime, dropoff_datetime, pickup_longitude, 
       pickup_latitude, dropoff_longitude,    
       dropoff_latitude 
FROM nyctaxi_sample "

# assining Remote SQL Call for defining the data set to a variable  
inDataSource <- RxSqlServerData(sqlQuery = sampleDataQuery, connectionString = connStr,
colClasses = c(pickup_longitude = "numeric", pickup_latitude = "numeric",
     dropoff_longitude = "numeric", dropoff_latitude = "numeric"),
     rowsPerRead = 500)


rxGetVarInfo(data = inDataSource)

# Start. time is to Record the Proc start time of the data set.
# used.time is current proc.time - start time is total resources utilized time.

start.time <- proc.time()

rxSummary( ~ fare_amount:F(passenger_count, 1, 6), data = inDataSource)

used.time <- proc.time() - start.time

print(paste("It takes CPU Time=", round(used.time[1] + used.time[2], 2), " seconds,
   Elapsed Time=", round(used.time[3], 2),
 " seconds to summarize the inDataSource.", sep = ""))
