####################################################################
# LIBRARY                                                          #
####################################################################
library("readxl")
library("ggplot2")
library("car")
library("ggpubr")
library("mvShapiroTest")

# excel_sheets('BacterialGrowth.xlsx')
bacterial_growth <- read_excel('BacterialGrowth.xlsx', sheet='MANOVA-Data 1')
bacterial_growth <- bacterial_growth[2:7]

# lapply(bacterial_growth, class)
bacterial_growth$Temperature <- as.factor(bacterial_growth$Temperature)
bacterial_growth$`N-source` <- as.factor(bacterial_growth$`N-source`)

head(bacterial_growth)

####################################################################
# EXPLORATORY DATA ANALYSIS                                        #
####################################################################

# Univariate normal distribution test
# Descriptive
sub1.gof.plot <- ggqqplot(bacterial_growth$`Dry weight`, color="#00AFBB")
sub2.gof.plot <- ggqqplot(bacterial_growth$`Optical density`, color="#E7B800")
sub3.gof.plot <- ggqqplot(bacterial_growth$`Product yield`, color="#FC4E07")

ggarrange(sub1.gof.plot, sub2.gof.plot, sub3.gof.plot,
          labels = c("Dry weight", "Optical density", "Product yield"),
          font.label = list(size = 11))
# Inference
shapiro.test(bacterial_growth$`Dry weight`)
shapiro.test(bacterial_growth$`Optical density`)
shapiro.test(bacterial_growth$`Product yield`)

# Univariate equality of variances test
leveneTest(`Dry weight` ~ Temperature * `N-source`, data = bacterial_growth)
leveneTest(`Optical density` ~ Temperature * `N-source`, data = bacterial_growth)
leveneTest(`Product yield` ~ Temperature * `N-source`, data = bacterial_growth)

# Multivariate shapiro wilk test
bacterial_30 <- as.matrix(bacterial_growth[4:6], ncol=3)
mvShapiro.Test(bacterial_30)


####################################################################
# One way ANOVA                                                    #
####################################################################
sub1.plot <- ggboxplot(bacterial_growth, x = "Temperature" , y = "Dry weight", 
          color = "Temperature", palette = c("#00AFBB", "#E7B800", "#FC4E07"),
          order = c("30", "35", "37"),
          ylab = "Dry weight", xlab = "Temperature")

sub2.plot <- ggboxplot(bacterial_growth, x = "Temperature" , y = "Optical density", 
          color = "Temperature", palette = c("#00AFBB", "#E7B800", "#FC4E07"),
          order = c("30", "35", "37"),
          ylab = "Optical density", xlab = "Temperature")

sub3.plot <- ggboxplot(bacterial_growth, x = "Temperature" , y = "Product yield", 
          color = "Temperature", palette = c("#00AFBB", "#E7B800", "#FC4E07"),
          order = c("30", "35", "37"),
          ylab = "Product yield", xlab = "Temperature")

ggarrange(sub1.plot, sub2.plot, sub3.plot)

sub4.plot <- ggboxplot(bacterial_growth, x = "N-source" , y = "Dry weight", 
          color = "N-source", palette = c("#00AFBB", "#E7B800", "#FC4E07"),
          ylab = "Dry weight", xlab = "N-source")

sub5.plot <- ggboxplot(bacterial_growth, x = "N-source" , y = "Optical density", 
          color = "N-source", palette = c("#00AFBB", "#E7B800", "#FC4E07"),
          ylab = "Dry weight", xlab = "N-source")

sub6.plot <- ggboxplot(bacterial_growth, x = "N-source" , y = "Product yield", 
          color = "N-source", palette = c("#00AFBB", "#E7B800", "#FC4E07"),
          ylab = "Dry weight", xlab = "N-source")

ggarrange(sub4.plot, sub5.plot, sub6.plot)

sub1.aov1 <- aov(`Dry weight` ~ Temperature, data = bacterial_growth)
summary(sub1.aov1)
sub2.aov1 <- aov(`Optical density` ~ Temperature, data = bacterial_growth)
summary(sub2.aov1)
sub3.aov1 <- aov(`Product yield` ~ Temperature, data = bacterial_growth)
summary(sub3.aov1)

sub4.aov1 <- aov(`Dry weight` ~ `N-source`, data = bacterial_growth)
summary(sub4.aov1)
sub5.aov1 <- aov(`Optical density` ~ `N-source`, data = bacterial_growth)
summary(sub5.aov1)
sub6.aov1 <- aov(`Product yield` ~ `N-source`, data = bacterial_growth)
summary(sub6.aov1)

####################################################################
# Two way ANOVA                                                    #
####################################################################
sub1.aov2.plot <- ggboxplot(
  bacterial_growth, x = "N-source", y = "Dry weight", color = "Temperature",
  palette = c("#00AFBB", "#E7B800", "#FC4E07"))
sub2.aov2.plot <- ggboxplot(
  bacterial_growth, x = "N-source", y = "Optical density", color = "Temperature",
  palette = c("#00AFBB", "#E7B800", "#FC4E07"))
sub3.aov2.plot <- ggboxplot(
  bacterial_growth, x = "N-source", y = "Product yield", color = "Temperature",
  palette = c("#00AFBB", "#E7B800", "#FC4E07"))

ggarrange(sub1.aov2.plot, sub2.aov2.plot, sub3.aov2.plot)

sub1.aov2 <- aov(
  `Dry weight` ~ `Temperature` + `N-source` + `Temperature`:`N-source`,
  data = bacterial_growth)
summary(sub1.aov2)

sub2.aov2 <- aov(
  `Optical density` ~ `Temperature` + `N-source` + `Temperature`:`N-source`,
  data = bacterial_growth)
summary(sub2.aov2)

sub3.aov2 <- aov(
  `Product yield` ~ `Temperature` + `N-source` + `Temperature`:`N-source`,
  data = bacterial_growth)
summary(sub1.aov2)


####################################################################
# One way MANOVA                                                   #
####################################################################
sub1.man1 <- manova(
  cbind(`Dry weight`, `Optical density`, `Product yield`) ~ Temperature,
  data = bacterial_growth)
summary(sub1.man1)

sub2.man1 <- manova(
  cbind(`Dry weight`, `Optical density`, `Product yield`) ~ `N-source`,
  data = bacterial_growth)
summary(sub2.man1)


####################################################################
# Two way MANOVA                                                  #
####################################################################
sub1.man2 <- manova(
  cbind(`Dry weight`, `Optical density`, `Product yield`) ~ 
    Temperature + `N-source` + Temperature:`N-source`,
  data = bacterial_growth)
summary(sub1.man2)

