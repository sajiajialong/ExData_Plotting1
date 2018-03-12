data<- read.table("household_power_consumption.txt",header = TRUE, sep = ";")

## turn column Date to "Date"
data$Date<- as.character(data$Date)
data$Date<- strptime(data$Date,"%d/%m/%Y")
data$Date<- as.Date(data$Date)
target<-subset(data, Date>=as.Date("2007-02-01")& Date<=as.Date("2007-02-02"))
target<- target[complete.cases(target), ]

## turn column Sub_metering_1,2,3 into numeric
target$Sub_metering_1<-as.numeric(as.character(target$Sub_metering_1))
target$Sub_metering_2<-as.numeric(as.character(target$Sub_metering_2))
target$Sub_metering_3<-as.numeric(as.character(target$Sub_metering_3))

## set label on x-axis
tick1<-min(which(target$Date==as.Date("2007-02-01")))
tick2<-min(which(target$Date==as.Date("2007-02-02")))
tick3<-max(which(target$Date==as.Date("2007-02-02")))
label<-c("Thu","Fri","Sat")

##plot
png("plot3.png")
plot(target$Sub_metering_1,type="l", col="black",xaxt="n",yaxt="n",xlab="",ylab = "Energy sub metering")
axis(1,at=c(tick1,tick2,tick3),labels = label)
axis(2,at=seq(0,30,10))
lines(target$Sub_metering_2,col="red")
lines(target$Sub_metering_3,col="blue")
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty = c(1,1,1),col = c("black","red","blue"))
dev.off()