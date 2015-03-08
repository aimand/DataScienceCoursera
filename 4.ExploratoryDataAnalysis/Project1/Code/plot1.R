plot1 <- function() { 
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

	## Make Plot 1
	hist(data$Global_active_power, main="Global Active Power", 
     		xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

	## Save Plot 1 to file
	dev.copy(png, file="../Plots/plot1.png", height=480, width=480)
	dev.off()
}
