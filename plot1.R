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

## plot
png("plot1.png")
hist(target$Global_active_power,xlab = "Global Active Power(kilowatts)", ylab = "Frequency",col = "red",main = "Global Active Power" )
dev.off()
