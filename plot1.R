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




# PLOT --------
par(mar = c(4.2,3,2,2))
par(mfrow = c(1, 1))


png(filename="plot1.png", 
    units="px", 
    width=480, 
    height=480,
    res=72)
hist(dat$Global_active_power,
     main = "Global Active Power",
     col="red",
     xlab = "Global Active Power (kilowatts)")
dev.off()

