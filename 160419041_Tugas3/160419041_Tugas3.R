#### DATA PREPARATION ####
# Import
library(readxl) 
excel_sheets('datasets/UK House price index.xls')
house.price <- read_excel('datasets/UK House price index.xls', sheet="Average price")

lapply(house.price, class) # Cek class tiap kolom pada dataframe
# alternative
#str(house.price)

library(dplyr)
library(tidyr)

### Housing group by Date (year)
price.byHousing <- house.price %>%
  mutate(year = format(Date, "%Y")) %>%
  group_by(year) %>%
  summarise(across('City of London':'Westminster', mean))

# Convert year to POSIXct
price.byHousing$year <- as.POSIXct(price.byHousing$year, format = "%Y")

### Region group by Date (year)
price.byRegion <- house.price %>%
  mutate(year = format(Date,"%Y")) %>%
  group_by(year) %>%
  summarise(across('NORTH EAST':'SOUTH WEST', mean))

# Convert year to POSIXct
price.byRegion$year <- as.POSIXct(price.byRegion$year, format = "%Y")

# Comparing housing price in City of London and Barking & Dagenham
# Melt
price.byHousing.melted <- price.byHousing %>%
  select(year, 'City of London':'Barking & Dagenham') %>%
  gather(key='housing', value='price', -year)

# Comparing housing price in LONDON and NORTH WEST
# Melt
price.byRegion.melted <- price.byRegion %>%
  select(year, c('LONDON','NORTH WEST')) %>%
  gather(key='region', value='price', -year)


#### EDA ####
library(ggplot2)
# Set parameter
housing <- names(price.byHousing[2:34])
region <- names(price.byRegion[2:10])

# Graph price by housing and region
housing.plot1 = ggplot(price.byHousing.melted, aes(x=year, y=price, colour=housing)) +
  geom_line() + theme_bw() + labs(title="Housing price for City of London and Barking 
                                  & Dagenham", x='Year', y='Price', subtitle="")
housing.plot1

region.plot1 = ggplot(price.byRegion.melted, aes(x=year, y=price, colour=region)) +
  geom_line() + theme_bw() + labs(title="Housing price for London and North West Region", 
                                  x='Year', y='Price', subtitle="")
region.plot1

# Boxplot by year
price.byHousing <- house.price %>%
  mutate(year = format(Date, "%Y")) %>%
  group_by(year)

price.byHousing.melted <- price.byHousing %>%
  select(year, 'City of London':'Barking & Dagenham') %>%
  gather(key='housing', value='price', -year)

price.byHousing.melted$year <- as.numeric(price.byHousing.melted$year)
price.byHousing.melted$year <- price.byHousing.melted$year - matrix(1994, ncol=1, nrow=566)
price.byHousing.melted$year <- as.factor(price.byHousing.melted$year)

ggplot(price.byHousing.melted, aes(x=year, y=price, fill=housing)) + 
  geom_boxplot() +
  facet_wrap(~housing)

price.byRegion <- house.price %>%
  mutate(year = format(Date,"%Y")) %>%
  group_by(year)

price.byRegion.melted <- price.byRegion %>%
  select(year, c('LONDON','NORTH WEST')) %>%
  gather(key='region', value='price', -year)

price.byRegion.melted$year <- as.numeric(price.byRegion.melted$year)
price.byRegion.melted$year <- price.byRegion.melted$year - matrix(1994, ncol=1, nrow=566)
price.byRegion.melted$year <- as.factor(price.byRegion.melted$year)

ggplot(price.byRegion.melted, aes(x=year, y=price, fill=region)) + 
  geom_boxplot() +
  facet_wrap(~region)

#### NORMALITY TEST ####
hist(house.price$'City of London', breaks=50, include.lowest = F, right = F)
qqnorm(house.price$`City of London`)
qqline(house.price$`City of London`)

hist(house.price$'Barking & Dagenham', breaks=50, include.lowest = F, right = F)
qqnorm(house.price$`Barking & Dagenham`)
qqline(house.price$`Barking & Dagenham`)

qqplot(house.price$`City of London`, house.price$'Barking & Dagenham')
# Conclusion: not normally distributed

hist(house.price$LONDON, breaks=50, include.lowest = F, right = F)
qqnorm(house.price$LONDON)
qqline(house.price$LONDON)

hist(house.price$`NORTH WEST`, breaks=50, include.lowest = F, right = F)
qqnorm(house.price$`NORTH WEST`)
qqline(house.price$`NORTH WEST`)

qqplot(house.price$LONDON, house.price$`NORTH WEST`)
# Conclusion: not normally distributed

# Kolmogorov smirnov test because the distribution is not normally distributed
library(dgof)
ks.test(house.price$`City of London`, house.price$`Barking & Dagenham`)
ks.test(house.price$LONDON, house.price$`NORTH WEST`)

# Conclusion: p<0.05 reject null hypothesis 
# (two sample does not come from the same population)

#### VARIANCE HOMOGENITY TEST (ANOVA) ####
library(car)

# preparing data
price.byHousing <- house.price %>%
  mutate(year = format(Date, "%Y")) %>%
  group_by(year)
price.byHousing$year <- as.factor(price.byHousing$year)

price.byHousing.melted <- price.byHousing %>%
  select(year, 'City of London':'Barking & Dagenham') %>%
  gather(key='housing', value='price', -year)

price.byRegion <- house.price %>%
  mutate(year = format(Date,"%Y")) %>%
  group_by(year)
price.byRegion.melted$year <- as.factor(price.byRegion.melted$year)

price.byRegion.melted <- price.byRegion %>%
  select(year, c('LONDON','NORTH WEST')) %>%
  gather(key='region', value='price', -year)

# leaveneTest
leveneTest(price ~ year, data = price.byHousing.melted)
leveneTest(price ~ year, data = price.byRegion.melted)

#conclution: data tidak memiliki varian yang sama dengan kata lain harga setiap 
#kategori (tahun) memiliki nilai yang berbeda

