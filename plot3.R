## Read the data from the text file using read.table into edp1.
## there is a header line in the file and the separator is ";"
## Also read "?" as NA in the data frame
## Dont read Date and Time as Factors but Strings
edp1<-read.table("household_power_consumption.txt", sep=";", header=T, na.strings = "?", stringsAsFactors = FALSE)

## Convert the Date variable to Date Class
edp1$Date<-as.Date(edp1$Date,"%d/%m/%Y")

##Select the subset of data that we need for the plots
edp2<-subset(edp1,(edp1$Date>"2007-01-31" & edp1$Date<"2007-02-03"))

## Get rid of large memory
rm(edp1)

## Create a Date/Time Class and add as new column in edp2
x<-paste(edp2$Date, edp2$Time)
dt<-strptime(x, format="%Y-%m-%d %H:%M:%S")
edp2<-cbind(edp2, DateTime=dt)

## Plot 1
png("plot3.png", width=480, height=480)


plot(edp2$DateTime, edp2$Sub_metering_1,  type="n", ylab="Energy sub metering", xlab="")
lines(edp2$DateTime,edp2$Sub_metering_1)
lines(edp2$DateTime,edp2$Sub_metering_2, col="red")
lines(edp2$DateTime,edp2$Sub_metering_3, col="blue")
legend("topright", lty=c(1,1,1), col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))

dev.off()
