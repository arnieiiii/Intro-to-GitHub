#Rough Estimate
#2075259 * 9 * 8 bytes/numeric = 149418648 bytes
# 149418648 / 2^20 bytes/MB = 142.4967 MB = 0.14 GB

#Reading the data
reading.data <- read.table("./specdata/household_power_consumption.txt", sep = ";", na.strings = "?", header = TRUE)
reading.data$Date <- as.Date(reading.data$Date, "%d/%m/%Y")
hpc.data <- subset(reading.data, Date == "2007-02-01" | Date == "2007-02-02")

date.time <- strptime(paste(hpc.data$Date, hpc.data$Time), "%F %T")
hpc.data <- cbind(date.time, hpc.data)

#Plot 1
hist(hpc.data$Global_active_power, col = "red", 
     main = paste("Global Active Power"), 
     xlab = "Global Active Power (kilowatts)",
     ylab = "")
dev.copy(png,"plot1.png", width = 500, height = 500)
dev.off()

#Plot 2
plot(hpc.data$date.time, hpc.data$Global_active_power, type = "l",
     ylab = "Global Active Power (kilowatts)", xlab = "")
dev.copy(png,"plot2.png", width = 500, height = 500)
dev.off()

#Plot 3
par(mar = c(5,5,2,2))
plot(hpc.data$date.time, hpc.data$Sub_metering_1, ylab = "Energy sub metering", 
     xlab = "", type = "l", col = "black")
points(hpc.data$date.time, hpc.data$Sub_metering_2, col = "red", type = "l")
points(hpc.data$date.time, hpc.data$Sub_metering_3, col = "blue", type = "l")
legend("topright", lwd = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1     ", "Sub_metering_2     ", "Sub_metering_3     "))
dev.copy(png,"plot3.png", width = 500, height = 500)
dev.off()

#Plot 4
par(mfrow = c(2,2), mar = c(5,4,2,2))

# Plot 4a (1st row, 1st col)
plot(hpc.data$date.time, hpc.data$Global_active_power, ylab = "Global Active Power", 
     xlab = "", pch = ".", type = "l")

# Plot 4b (1st row, 2nd col)
plot(hpc.data$date.time, hpc.data$Voltage, ylab = "Voltage", xlab = "datetime", type = "l")

# Plot 4c (2nd row, 1st col)
plot(hpc.data$date.time, hpc.data$Sub_metering_1, ylab = "Energy sub metering", xlab = "", 
     type = "l", col = "black")
points(hpc.data$date.time, hpc.data$Sub_metering_2, col = "red", type = "l")
points(hpc.data$date.time, hpc.data$Sub_metering_3, col = "blue", type = "l")
legend("topright", lwd = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1     ", "Sub_metering_2     ", "Sub_metering_3     "), 
       bty = "n")

# Plot 4d (2nd row, 2nd col)
plot(hpc.data$date.time, hpc.data$Global_reactive_power, ylab = "Global_reactive_power", 
     xlab = "datetime", type = "l")
dev.copy(png,"plot4.png", width = 500, height = 500)
dev.off()




