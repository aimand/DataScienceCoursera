plot3 <- function() { 

	## Read text file
	hpc <- read.csv("../Data/household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                      nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')

	## Get and format Date
	hpc$Date <- as.Date(hpc$Date, format="%d/%m/%Y")

	## Make a subset of dates
	data <- subset(hpc, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
	rm(hpc)

	## Convert Dates
	datetime <- paste(as.Date(data$Date), data$Time)
	data$Datetime <- as.POSIXct(datetime)

	## Make Plot 3
	with(data, 
		{
			plot(Sub_metering_1~Datetime, type="l", ylab="Energy sub metering", xlab="")
    			lines(Sub_metering_2~Datetime,col='Red')
    			lines(Sub_metering_3~Datetime,col='Blue')
		}
	)
	legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       	legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

	## Save Plot 3 to file
	dev.copy(png, file="../Plots/plot3.png", height=480, width=480)
	dev.off()
}