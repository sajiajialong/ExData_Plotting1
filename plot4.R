data<- read.table("household_power_consumption.txt",header = TRUE, sep = ";")

## turn column Date to "Date"
data$Date<- as.character(data$Date)
data$Date<- strptime(data$Date,"%d/%m/%Y")
data$Date<- as.Date(data$Date)
target<-subset(data, Date>=as.Date("2007-02-01")& Date<=as.Date("2007-02-02"))
target<- target[complete.cases(target), ]

## turn column Global_active_power into numeric
target$Global_active_power<- as.character(target$Global_active_power)
target$Global_active_power<- as.numeric(target$Global_active_power)

## turn column Sub_metering_1,2,3 into numeric
target$Sub_metering_1<-as.numeric(as.character(target$Sub_metering_1))
target$Sub_metering_2<-as.numeric(as.character(target$Sub_metering_2))
target$Sub_metering_3<-as.numeric(as.character(target$Sub_metering_3))

## turn column Voltage into numeric
target$Voltage<-as.numeric(as.character(target$Voltage))

## turn column Global_reactive_power into numeric
target$Global_reactive_power<-as.numeric(as.character(target$Global_reactive_power))


## set label on x-axis
tick1<-min(which(target$Date==as.Date("2007-02-01")))
tick2<-min(which(target$Date==as.Date("2007-02-02")))
tick3<-max(which(target$Date==as.Date("2007-02-02")))
label<-c("Thu","Fri","Sat")

png("plot4.png")
par(mfrow=c(2,2))
with(target, plot(Global_active_power,type="l",xaxt="n",yaxt="n",xlab="",ylab="Global Active Power"))
axis(1,at=c(tick1,tick2,tick3),labels = label)
axis(2,at=seq(0,6,2),labels = c("0","2","4","6"))

with(target,plot(Voltage,type = "l",xaxt="n",yaxt="n",xlab = "datetime",ylab = "Voltage"))
axis(1,at=c(tick1,tick2,tick3),labels = label)
axis(2,at=seq(234,246,4))

plot(target$Sub_metering_1,type="l", col="black",xaxt="n",yaxt="n",xlab="",ylab = "Energy sub metering")
axis(1,at=c(tick1,tick2,tick3),labels = label)
axis(2,at=seq(0,30,10))
lines(target$Sub_metering_2,col="red")
lines(target$Sub_metering_3,col="blue")
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty = c(1,1,1),col = c("black","red","blue"),y.intersp = 0.5,cex=0.6,bty = "n")

with(target,plot(Global_reactive_power,type="l", xaxt="n",yaxt="n",xlab = "datetime",ylab = "Global_reactive_power"))
axis(1,at=c(tick1,tick2,tick3),labels = label)
axis(2,at=seq(0,0.5,0.1))
dev.off()