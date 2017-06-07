# John Hopkins Data Science 
# Course 04 Exploratory Data Analysis
# Week 1 Assignment

# DOWNLOAD AND UNZIP -------------

# set working directory to path of current file
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# URL of zip-file
fileUrl <- paste("https://d396qusza40orc.cloudfront.net/exdata%2F",
                 "data%2Fhousehold_power_consumption.zip", sep = "")

# download the file
download.file(fileUrl,destfile = "./data.zip")

# unzip the files
unzip("./data.zip",exdir=".")

# read in data
rawData <- read.table("./household_power_consumption.txt",
                      sep = ";", 
                      header = TRUE,
                      stringsAsFactors = FALSE)

# subsetting for two dates
dat <- rawData[rawData$Date=="1/2/2007"|rawData$Date=="2/2/2007",]


# ADJUST DATE + SUBSETTING ------

# convert 'Date' column to type date
dat$Date <- as.Date(paste(dat$Date,
                          dat$Time),"%d/%m/%Y")

dat$Date2 <- strptime(paste(dat$Date,dat$Time),"%Y-%m-%d %H:%M:%S")

# convert time 
dat$Time <- strptime(paste(dat$Time,
                           dat$Time),"%H:%M:%S")


# are there missing values? ---> No
table(grepl("\\?",dat))

# convert subsetted to numeric for plotting
indx <- sapply(dat, is.character)
dat[indx] <- lapply(dat[indx], 
                    function(x) as.numeric(x))

# PLOT -----------


png(filename="plot3.png",
    units="px",
    width=480,
    height=480,
    res=72)


par(mar = c(4.2,4,2,2))

plot(dat$Date2,dat$Sub_metering_1,
     type = "l",
     col  = "black",
     ylab = "Energy sub metering",
     xlab = "")
lines(dat$Date2,dat$Sub_metering_2,type = "l",col  = "red")
lines(dat$Date2,dat$Sub_metering_3,type = "l",col  = "blue")
legend("topright", lty = 1, 
       col = c("black","red","blue"), 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()

