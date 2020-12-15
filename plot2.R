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
df <- df %>% mutate(Date = as.Date(Date, "%d/%m/%Y"),
                    Time = format(strptime(Time, "%H:%M:%S"),"%H:%M:%S"),
                    Global_active_power = as.numeric(Global_active_power),
                    DayWithTime = as.POSIXct(paste(Date, Time), "%d-%m-%d %H:%M"))

# graphic device is png
png("plot2.png")

# construct graph
plot(Global_active_power~DayWithTime, 
     data = df, 
     type = "l", 
     ylab = "Global Active Power (kilowatts)", 
     xlab = "")

# close device
dev.off()