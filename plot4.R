#Project #1 from Coursera class Explortory Data Analysis


#set wd and read in the whole file
setwd("~/R/R_class_John_Hopkins_EDA")
#designate missing values as "?" by setting na.trings
allpowerdata<-read.csv('./household_power_consumption.txt',sep=';',header=TRUE,na.strings="?")
str(allpowerdata)
head(allpowerdata)

#subset the two days we want to look at and remove incomplete cases
allpowerdata[,1]<-as.Date(allpowerdata[,1], format="%d/%m/%Y")
powerdata<-allpowerdata[allpowerdata$Date >= "2007/02/01" & allpowerdata$Date<="2007/02/02",]
#keep only complete cases, set ?'s -> NA in the read.csv funcion
good<-complete.cases(powerdata)
powerdata<-powerdata[good,]
#change global acive power to numeric class
powerdata$Global_active_power<-as.numeric(powerdata$Global_active_power)

#need to get a "DateTime" column that is elapsed seconds
powerdata$DateTime <- paste(powerdata$Date, powerdata$Time) 
powerdata$DateTime <- as.POSIXct(powerdata$DateTime, format="%Y-%m-%d %H:%M:%S")

#store defaults in old.par
old.par<-par()
#run this line to recover defaults
par(old.par)


#construct 4th plot there are 4 plots
png(file="plot4.png", height=480, width=480)
par(mar=c(4,4,2,1),oma=c(0,0,2,0),mfcol=c(2,2))

#Top left Plot
with(powerdata, plot(DateTime,Global_active_power,type="n",
                     ylab="Global Active Power (kilowatts)",
                     xlab=" "))
with(powerdata, lines(DateTime,Global_active_power))

#Bottom Left Plot
with(powerdata, plot(DateTime,Sub_metering_1,type="n", 
                     ylab = "Energy Sub Metering"))  
with(powerdata, lines(DateTime,Sub_metering_1,col="Black"))
with(powerdata, lines(DateTime,Sub_metering_2,col="Red"))
with(powerdata, lines(DateTime,Sub_metering_3,col="Blue"))
legend("topright", lty=1, col=c("Black","Red","Blue"), cex=0.9,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#Construct the 3rd Plot
with(powerdata, plot(DateTime,Voltage,type="n",
                     ylab="Voltage",
                     xlab="DateTime"))
with(powerdata, lines(DateTime,Voltage))

#Construct the 4th plot
with(powerdata, plot(DateTime,Global_reactive_power,type="n",
                     ylab="Global_reactive_power",
                     xlab="DateTime"))
with(powerdata, lines(DateTime,Global_reactive_power))

dev.off()




