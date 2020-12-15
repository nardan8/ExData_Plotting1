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
                    Global_active_power = as.numeric(Global_active_power))

# graphic device is png
png("plot1.png")

# construct graph
hist(df$Global_active_power, 
     col = "red", 
     xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power")

# close device
dev.off()

