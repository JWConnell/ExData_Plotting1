#Download file, extract to local directory.
url1="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("./data")){dir.create("./data")}
download.file(url1, tmp <- tempfile(fileext = ".zip"))
unzip(tmp, exdir = "./data")

hpc <- read.table("./data/household_power_consumption.txt", header=TRUE, sep=";", na.strings="?")
hpc_2days <- hpc[hpc$Date %in% c("1/2/2007","2/2/2007"),]
hpc_2days$DateTime <- (paste(hpc_2days$Date, hpc_2days$Time))
hpc_2days$DateTime <- strptime(hpc_2days$DateTime, format = "%d/%m/%Y %H:%M:%S")

png("plot4.png", width=480, height=480)
n.col <- 2
n.row <- 2
par(mfrow = c(n.col,n.row), mar=c(4.1,4.1,2.1,1.1), oma=c(0,0,2,0), ps=9)
plot(x=hpc_2days$DateTime, y=hpc_2days$Global_active_power, type="l", xlab="", ylab="Global Active Power")
plot(x=hpc_2days$DateTime, y=hpc_2days$Voltage, type="l", xlab="datetime", ylab="Voltage")
plot(x=hpc_2days$DateTime, y=hpc_2days$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(x=hpc_2days$DateTime, y=hpc_2days$Sub_metering_2, type="l", col="red")
lines(x=hpc_2days$DateTime, y=hpc_2days$Sub_metering_3, type="l", col="blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, bty="n", col=c("black", "red", "blue"), cex=.7)
plot(x=hpc_2days$DateTime, y=hpc_2days$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
dev.off()
