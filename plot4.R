# Explaratory Data Analysis, Project 1

# sqldf package is used to select for the rows of interest while the data was being read into a data table
library(sqldf)
f <- file("household_power_consumption.txt")
# dates "2007-02-01" and "2007-02-02" should be extracted, however the date format of the downloaded file
# is of "1/2/2007" and "2/2/2007" and ";" is used as a separator
dfPow <- sqldf("SELECT * FROM f WHERE Date='1/2/2007' OR Date='2/2/2007'", dbname = tempfile(), file.format = list(header = T, row.names = F, sep =";"))
# the file connection is closed
close(con = f)

# a new column with the date and time information is added
# first the "Date" and "Time" values are combined
combined <- paste(dfPow$Date, dfPow$Time, sep=" ") 
dfPow$DateTime <- strptime(combined, format="%d/%m/%Y %H:%M:%S")

# graph4
png(filename="plot4.png", width = 480, height = 480, units = "px")
par(mfrow=c(2,2))

plot(dfPow$DateTime, dfPow$Global_active_power, type="l", xlab="", ylab="Global Active Power(kilowatts)")

plot(dfPow$DateTime, dfPow$Voltage, xlab="datetime", type="l")

plot(dfPow$DateTime, dfPow$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(dfPow$DateTime, dfPow$Sub_metering_2, type="l", col="red")
lines(dfPow$DateTime, dfPow$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"))

plot(dfPow$DateTime, dfPow$Global_reactive_power, xlab="datetime", ylab="Global_reactive_power", type="l") 

dev.off()

