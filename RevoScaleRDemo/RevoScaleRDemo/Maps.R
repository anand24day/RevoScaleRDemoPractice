connStr <- 'Driver={SQL Server};Server=XXX.XXX.XXX;Database=RProject;Uid=sa;Pwd=XXXXXX'

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


rxGetVarInfo(data = inDataSource)


mapPlot <- function(inDataSource, googMap) {
    library(ggmap)
    library(mapproj)
    ds <- rxImport(inDataSource)
    p <- ggmap(googMap) +
    geom_point(aes(x = pickup_longitude, y = pickup_latitude), data = ds, alpha = .5,
    color = "darkred", size = 1.5)
    return(list(myplot = p))
}

library(ggmap)
library(mapproj)
gc <- geocode("Times Square", source = "google")
googMap <- get_googlemap(center = as.numeric(gc), color = 'color', maptype = "roadmap", zoom = 12, Size = c(1024, 1024));


mapPlot(inDataSource, googMap)


plot(myplots[[1]][["myplot"]]);