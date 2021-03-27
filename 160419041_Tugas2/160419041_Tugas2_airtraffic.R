################################## NOTES ##################################
### Examine multivariate data ###
### Three broad classes of multivariate analysis:
# 1. Relationship between one categorical variable and one continuous variable
# 2. Relationship between two categorical variables
# 3. Relationship between two continuous variables

# You're wanting to find relationships between variables
# You aren't worried about the WHY right now, just the WHAT

## Graphs to use:
# scatter plot
# density plots
# box plots
################################## NOTES ##################################

# Import data
air_traffic <- read.csv('datasets/Air_Traffic_Landings_Statistics-2019.csv', sep=';')
# Check class
sapply(air_traffic, class)
# Convert to appropiate class
air_traffic$Activity.Period <- as.character(air_traffic$Activity.Period)
air_traffic$GEO.Summary <- as.factor(air_traffic$GEO.Summary)
air_traffic$GEO.Region <- as.factor(air_traffic$GEO.Region)
air_traffic$Landing.Aircraft.Type <- as.factor(air_traffic$Landing.Aircraft.Type)
air_traffic$Aircraft.Body.Type <- as.factor(air_traffic$Aircraft.Body.Type)

# Sumarry
summary(air_traffic)

#################### Comparing categorical and continuous

# Comparing aircraft body type and total landed weight
by(air_traffic$Total.Landed.Weight, air_traffic$Aircraft.Body.Type, summary)
by(air_traffic$Total.Landed.Weight, air_traffic$Aircraft.Body.Type, mean)
by(air_traffic$Total.Landed.Weight, air_traffic$Aircraft.Body.Type, median)

# boxplot(air_traffic$Total.Landed.Weight~air_traffic$Aircraft.Body.Type, notch=TRUE, col=c("grey","grey","grey","grey"), main = "Total landed weight by aircraft body type")
# install.packages("sm")
# library(sm)
# sm.density.compare(air_traffic$Total.Landed.Weight, air_traffic$Aircraft.Body.Type, xlab="Total landed weight")


#################### Comparing categorical and categorical
###### Comparing aircraft type and aircraft body type
xtabs(~Landing.Aircraft.Type+Aircraft.Body.Type, air_traffic)
plot(xtabs(~Landing.Aircraft.Type+Aircraft.Body.Type, air_traffic), main="Aircraft Body Type and Landing Type")

#xtabs(~Aircraft.Body.Type+Landing.Aircraft.Type, air_traffic)
#plot(xtabs(~Aircraft.Body.Type+Landing.Aircraft.Type, air_traffic), main="Aircraft Body Type and Landing Type")

###### Comparing GEO Summary and Aircraft.Body.Type
xtabs(~GEO.Summary+Landing.Aircraft.Type, air_traffic)
plot(xtabs(~GEO.Summary+Landing.Aircraft.Type, air_traffic), main="Aircraft Body Type and GEO Summary")

#xtabs(~Landing.Aircraft.Type+GEO.Summary, air_traffic)
#plot(xtabs(~Landing.Aircraft.Type+GEO.Summary, air_traffic), main="Aircraft Body Type and GEO Summary")

###### Comparing GEO Summary and Landing.Aircraft.Type
xtabs(~Landing.Aircraft.Type+GEO.Summary, air_traffic)
plot(xtabs(~Landing.Aircraft.Type+GEO.Summary, air_traffic), main="Landing Aircraft Type and GEO Summary")

#################### Comparing continuous and continuous
# Comparing Landing.Count dan Total.Landed.Weight
scatter.smooth(air_traffic$Landing.Count, air_traffic$Total.Landed.Weight, main="Landing Count and Landing Weight Relationship", xlab="Landing Count", ylab="Landed Weight")

