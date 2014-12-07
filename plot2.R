library("dplyr")
library("lubridate")

setwd("C:\\Users\\Faisal\\Dropbox\\DataScience\\04-Exploratory\\Project1\\") #at home

if(!file.exists("data")){
    dir.create("data")
}

URLFile<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(URLFile,destfile="./data/ElectricPower.zip")
dateDownloaded<-date()
unzip("./data/ElectricPower.zip", files = NULL, list = FALSE, overwrite = TRUE,
      junkpaths = FALSE, exdir = "./data", unzip = "internal",
      setTimes = FALSE)

#Data sample
#Date;Time;Global_active_power;Global_reactive_power;Voltage;Global_intensity;Sub_metering_1;Sub_metering_2;Sub_metering_3
#16/12/2006;17:24:00;4.216;0.418;234.840;18.400;0.000;1.000;17.000
#16/12/2006;17:25:00;5.360;0.436;233.630;23.000;0.000;1.000;16.000

consumption <- read.table("./data/household_power_consumption.txt",header=T, sep=";",
                          stringsAsFactors = FALSE, na.strings= "?")
head(consumption)
subCon <- tbl_df(consumption[as.character(consumption$Date) %in% c("1/2/2007", "2/2/2007"),])

#mutate(subCon,DayTime=as.Date(Date, format = "%d/%m/%Y"))
subCon<-transform(subCon, DateTime=paste0(Date,Time))
subCon$DateTime <- strptime(subCon$DateTime, "%d/%m/%Y %H:%M:%S")
subCon$DateTime <- as.POSIXct(subCon$DateTime)

# Plot 2
png("plot2.png", width=480, height=480, units="px")
# Plot of Global active power minute by minute
plot(subCon$DateTime, as.numeric(subCon$Global_active_power),type="l", xlab="",
     ylab="Global Active Power (kilowatts)")
dev.off()
