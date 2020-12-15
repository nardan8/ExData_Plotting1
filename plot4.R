# data url
dataUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
fileName <- "exdata_data_household_power_consumption.zip"

# if file already exist
if (!file.exists(fileName)) {
        download.file(dataUrl, fileName, mode = "wb")
}

# unzip if directory doesn't already exist
if (!file.exists("household_power_consumption.txt")) {
        unzip(fileName)
}

# read data
df <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")[66637:69516,]

# convert values
df <- df %>% mutate(Date = as.Date(Date, "%d/%m/%y"),
                    Time = format(strptime(Time, "%H:%M:%S"),"%H:%M:%S"),
                    Global_active_power = as.numeric(Global_active_power),
                    Global_reactive_power = as.numeric(Global_reactive_power),
                    DayWithTime = as.POSIXct(paste(Date, Time), "%d-%m-%d %H:%M"),
                    Sub_metering_1 = as.numeric(Sub_metering_1),
                    Sub_metering_2 = as.numeric(Sub_metering_2),
                    Sub_metering_3 = as.numeric(Sub_metering_3))

# graphic device is png
png("plot4.png")

# columnwise positioning [2, 2] multiple plots
par(mfcol = c(2, 2))

# construct 1st graph
plot(Global_active_power~DayWithTime, 
     data = df, 
     type = "l", 
     ylab = "Global Active Power (kilowatts)", 
     xlab = "")

# construct 2nd graph
plot(Sub_metering_1~DayWithTime, data = df, type = "l", ylab = "EnergySubMetering", xlab = "")
lines(Sub_metering_2~DayWithTime, data = df, col = "red")
lines(Sub_metering_3~DayWithTime, data = df, col = "blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty = 1, lwd = 2, cex = 0.8)

# construct 3rd graph
plot(Voltage~DayWithTime, data = df, type = "l", xlab = "datetime")

# construct 4th graph
plot(Global_reactive_power~DayWithTime, data = df, type = "l", xlab = "datetime")

# close device
dev.off()