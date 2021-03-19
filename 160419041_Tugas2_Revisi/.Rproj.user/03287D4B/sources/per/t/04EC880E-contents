#################### Comparing average prize of London vs England
# Import
#install.packages("readxl")
library(readxl)
excel_sheets('datasets/UK House price index.xls')
house.price <- read_excel('datasets/UK House price index.xls', sheet = "Average price")

# Formatting
names(house.price)[names(house.price) == "...1"] <- "Date"

# Quick summary
by(house.price$LONDON, house.price$England, summary)

sapply(house.price, mean)
sapply(house.price, sd)
sapply(house.price, median)

ts.plot(house.price$LONDON)
ts.plot(house.price$England)

# Multiple time series plot
library("tidyverse")
library("ggplot2")
library("dplyr")
library("tidyr")

# Melt
house.price.melted <- house.price %>% 
  select(Date, LONDON, England) %>% 
  gather(key='variable', value="value", -Date)
head(house.price.melted)

# Plot
ggplot(house.price.melted, aes(x=Date, y=value)) + 
  geom_line(aes(color=variable, linetype=variable)) +
  scale_color_manual(values = c("darkred", "steelblue")) +
  ggtitle("Average house prize in London and England") +
  theme(plot.title = element_text(hjust = 0.5))

#################### Sales volume in London vs England (NOT USED)
# Import
# excel_sheets('datasets/SalesVolume.xlsx')
# house.sales <- read_excel('datasets/SalesVolume.xlsx', sheet = "Sheet1") 

# Group by year 
# house.sales.melted <- house.sales %>%
#   mutate(year = format(Date,"%Y")) %>%
#   group_by(year) %>%
#   summarise(across(`NORTH EAST`:`SOUTH WEST`, mean))
# 
# house.sales.melted$year <- as.POSIXct(house.sales.melted$year, "%Y")
# class(house.sales.melted$year)
# Add mean
# house.sales.melted <- cbind(house.sales.melted, England=rowMeans(house.sales.melted[,-1]))

# Melt
#house.sales.melted <- house.sales.melteyd %>% 
 # select(year, LONDON, England) %>% 
  #gather(key='variable', value="value", -year)
#head(house.sales.melted)

# xtabs(~LONDON+England, house.sales.melted)
# plot(xtabs(~LONDON+England, house.sales.melted), main="")




