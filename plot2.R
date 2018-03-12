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

## set label on x-axis
tick1<-min(which(target$Date==as.Date("2007-02-01")))
tick2<-min(which(target$Date==as.Date("2007-02-02")))
tick3<-max(which(target$Date==as.Date("2007-02-02")))
label<-c("Thu","Fri","Sat")

## plot
png("plot2.png")
plot(target$Global_active_power,type="l",xaxt="n",yaxt="n",xlab="",ylab="Global Active Power(kilowatts)")
axis(1,at=c(tick1,tick2,tick3),labels = label)
axis(2,at=seq(0,6,2))
dev.off()