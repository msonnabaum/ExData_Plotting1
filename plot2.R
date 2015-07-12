library(readr)
library(dplyr)

df <- read_delim("household_power_consumption.txt", ";", col_types = list(
  Date = col_character(),
  Time = col_character(),
  Global_active_power = col_numeric(),
  Global_reactive_power = col_numeric(),
  Voltage  = col_numeric(),
  Global_intensity  = col_numeric(),
  Sub_metering_1  = col_numeric(),
  Sub_metering_2  = col_numeric(),
  Sub_metering_3  = col_numeric()
))

df <- df %>% 
  mutate(datetime = parse_datetime(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")) %>% 
  filter(
    datetime > parse_datetime("2007-02-01"),
    datetime < parse_datetime("2007-02-03")
  )

png("plot2.png", width = 480, height = 480)

plot(df$datetime, df$Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "l")

dev.off()