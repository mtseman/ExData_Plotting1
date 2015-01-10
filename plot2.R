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


#construct plot #2
par(mar=c(4,4,3,2))
with(powerdata, plot(DateTime,Global_active_power,type="n",
    ylab="Global Active Power (kilowatts)",
    xlab=" "))
    )
with(powerdata, lines(DateTime,Global_active_power))
dev.copy(png, height=480, width=480, filename="plot2.png")
dev.off()

