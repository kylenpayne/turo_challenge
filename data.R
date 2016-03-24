## ---- data.R
## ----script for loading data


library(plyr)

reserves <- read.csv("~/Desktop/turo_challenge/reservations_(5).csv")
res <- ddply(reserves, .(reservation_type, vehicle_id),nrow )
colnames(res)[3] <- "total"
vehicles <- read.csv("~/Desktop/turo_challenge/vehicles_(6).csv")

data_m <- merge(res, vehicles, by = "vehicle_id")

