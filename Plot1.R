#Download file, extract to local directory.
url1="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("./data")){dir.create("./data")}
download.file(url1, tmp <- tempfile(fileext = ".zip"))
unzip(tmp, exdir = "./data")

hpc <- read.table("./data/household_power_consumption.txt", header=TRUE, sep=";", na.strings="?")
hpc_2days <- hpc[hpc$Date %in% c("1/2/2007","2/2/2007"),]
hpc_2days$DateTime <- (paste(hpc_2days$Date, hpc_2days$Time))
hpc_2days$DateTime <- strptime(hpc_2days$DateTime, format = "%d/%m/%Y %H:%M:%S")

png("plot1.png", width=480, height=480)
par(mar=c(4.1,4.1,4.1,2.1),ps=9)
with(hpc_2days, hist(Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency"))
title("Plot 1", adj=-1, line=3)
dev.off()

