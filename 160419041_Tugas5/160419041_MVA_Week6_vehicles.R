#install library 
library("readxl")
library("ggplot2")
library("car")
library("ggpubr")
library("mvShapiroTest")
library(stats)
library(dplyr)


#import file
vehicles <- read.csv("vehicles.csv")
names(vehicles)
vehicles$drive <- factor(vehicles$drive, levels = c("Rear-Wheel Drive","Front-Wheel Drive","4-Wheel or All-Wheel Drive"),labels = c("Rear-Wheel Drive","Front-Wheel Drive","4-Wheel or All-Wheel Drive"))

#lappy
vehicles$barrels08 <- as.factor(vehicles$fuelCost08)
vehicles$drive <- as.factor(vehicles$drive)
head(vehicles)

#eda
#descriptive
sub1.gof.plot <- ggqqplot(vehicles$fuelCost08, color = "#00AFBB")
sub2.gof.plot <-ggqqplot(vehicles$highway08, color = "#FC4E07")
ggarrange(sub1.gof.plot, sub2.gof.plot, labels = c("fuelcost08", "highway08"))

#univariate
leveneTest(`fuelCost08` ~ drive, data = vehicles)
leveneTest(`highway08` ~ drive, data = vehicles)

#Manova
glimpse(vehicles)
levels(vehicles$drive)
vehicles %>%
  group_by(vehicles$drive) %>%
  summarise(
    count_drive = n(),
    mean_fuelCost08 = mean(fuelCost08, na.rm = TRUE)
  )

ggplot(vehicles, aes(x = `drive`,y=fuelCost08, fill =`drive`)) +
  geom_boxplot() +
  geom_jitter(shape = 15,
              position = position_jitter(0.21)) +
  theme_classic()


#one way
anovaOne <- aov(fuelCost08~drive, data = vehicles)
summary(anovaOne)
TukeyHSD(anovaOne)
#TWO WAY
anovaTwo <- aov(fuelCost08~drive + make , data = vehicles)
summary(anovaTwo)
TukeyHSD(anovaTwo)

#MANOVA
set.seed(1234)
dplyr::sample_n(vehicles,5000)
# MANOVA test
res.man <- manova(cbind(fuelCost08, drive) ~ drive, data = vehicles)
summary.aov(res.man) 

