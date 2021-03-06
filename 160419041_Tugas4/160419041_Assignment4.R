#### DATA PREPARATION ####

# Library for importing excel file
library("readxl")
# Library for ploting
library("ggplot2")
library("ggpubr")
# Library for clustering
library("pvclust")


# Check sheets
excel_sheets('datasets/_Index_Crimes_by_County_and_Agency__Beginning_1990.xlsx')
# Create dataframe
us_crime <- 
  read_excel('datasets/_Index_Crimes_by_County_and_Agency__Beginning_1990.xlsx', 
             sheet='Index_Crimes_by_County_and_Agen')

us_crime <- 
  subset(us_crime, !`Agency` == "County Total" & 
           !`Agency` == "Region Total" 
         & !is.na(`Murder`))

# Remove 'Months Reported', 'Index Total', 'Violent Total', 'Region'
us_crime <- us_crime[c(1:3, 7:10, 12:14)]
# Change n/a data to 0
us_crime[is.na(us_crime)] <- 0

# fungsi Uji multivariate normal
mnorm.test <- function(x)
{
  rata2 <- apply(x, 2, mean)
  mcov <- var(x)
  ds <- sort(mahalanobis(
    x,
    center = rata2,
    cov = mcov,
    tol = 1e-20
  ))
  n <- length(ds)
  p <- (1:n - 0.5) / n
  chi <- qchisq(p, df = ncol(x))
  win.graph()
  plot(ds, chi, type = "p")
  return(ks.test(ds, chi, df = ncol(x)))
}


#### Columbia ####
# Subset Columbia
us_crime_columbia <- subset(us_crime, `County` == 'Columbia')

# Plot (Descriptive)
columbia_hist1 <- ggplot(data = us_crime_columbia, aes(x=Year, y=Murder)) + geom_bar(stat='identity') + theme_bw() 
columbia_hist2 <- ggplot(data = us_crime_columbia, aes(x=Year, y=Rape)) + geom_bar(stat='identity') + theme_bw()
columbia_hist3 <- ggplot(data = us_crime_columbia, aes(x=Year, y=Robbery)) + geom_bar(stat='identity') + theme_bw()
columbia_hist4 <- ggplot(data = us_crime_columbia, aes(x=Year, y=`Aggravated Assault`)) + geom_bar(stat='identity') + theme_bw()
columbia_hist5 <- ggplot(data = us_crime_columbia, aes(x=Year, y=Burglary)) + geom_bar(stat='identity') + theme_bw()
columbia_hist6 <- ggplot(data = us_crime_columbia, aes(x=Year, y=Larceny)) + geom_bar(stat='identity')+ theme_bw()
columbia_hist7 <- ggplot(data = us_crime_columbia, aes(x=Year, y=`Motor Vehicle Theft`)) + geom_bar(stat='identity') + theme_bw()

# make list
columbia_crime_list <- list(columbia_hist1, columbia_hist2, columbia_hist3, columbia_hist4, 
                            columbia_hist5, columbia_hist6, columbia_hist7)
# arrange to 1 plot
ggarrange(plotlist = columbia_crime_list,
          ncol = 2, nrow = 4)

# univariate test
# KS Test (Inference)
# H0: distribusi crime dengan kategori x normal terhadap keseluruhan di us
# H1: distribusi crime memiliki differ terhadap kategori crime tsb di us
ks.test(us_crime_columbia$Murder, us_crime$Murder)
ks.test(us_crime_columbia$Rape, us_crime$Rape)
ks.test(us_crime_columbia$Robbery, us_crime$Robbery)
ks.test(us_crime_columbia$`Aggravated Assault`, us_crime$`Aggravated Assault`)
ks.test(us_crime_columbia$Burglary, us_crime$Burglary)
ks.test(us_crime_columbia$Larceny, us_crime$Larceny)
ks.test(us_crime_columbia$`Motor Vehicle Theft`, us_crime$`Motor Vehicle Theft`)
# Kesimpulan: distribusi crime murder sama dengan keseluruhan us sedangkan yang lainnya tidak normal

# convert and subset to matrix
matrix_us_columbia = data.matrix(us_crime_columbia[c(4:10)])

# multivariate test
mnorm.test(matrix_us_columbia)
# Kesimpulan: tolak H0, data tidak terdistribusi normal dan memiliki 
# banyak deviasi terhadap data crime pada seluruh 
# us sesuai dengan analisis univariate 
# yang sudah dilakukan terhadap masing - masing crime category

#### St Lawrence ####
# subset
us_crime_stlawrence <- subset(us_crime, `County` == 'St Lawrence')

# Plot (Descriptive)
stlawrence_hist1 <- ggplot(data = us_crime_stlawrence, aes(x=Year, y=Murder)) + geom_bar(stat='identity') + theme_bw()
stlawrence_hist2 <- ggplot(data = us_crime_stlawrence, aes(x=Year, y=Rape)) + geom_bar(stat='identity') + theme_bw()
stlawrence_hist3 <- ggplot(data = us_crime_stlawrence, aes(x=Year, y=Robbery)) + geom_bar(stat='identity') + theme_bw()
stlawrence_hist4 <- ggplot(data = us_crime_stlawrence, aes(x=Year, y=`Aggravated Assault`)) + geom_bar(stat='identity') + theme_bw()
stlawrence_hist5 <- ggplot(data = us_crime_stlawrence, aes(x=Year, y=Burglary)) + geom_bar(stat='identity') + theme_bw()

stlawrence_hist6 <- ggplot(data = us_crime_stlawrence, aes(x=Year, y=Larceny)) + geom_bar(stat='identity') + theme_bw()
stlawrence_hist7 <- ggplot(data = us_crime_stlawrence, aes(x=Year, y=`Motor Vehicle Theft`)) + geom_bar(stat='identity') + theme_bw()
# make list
stlawrence_crime_list <- list(stlawrence_hist1, stlawrence_hist2, stlawrence_hist3, stlawrence_hist4, 
                              stlawrence_hist5, stlawrence_hist6, stlawrence_hist7)
# arrange to 1 plot
ggarrange(plotlist = stlawrence_crime_list, 
          ncol = 2, nrow=4)

# univariate test
# KS Test (Inference)
# H0: distribusi crime dengan kategori x normal terhadap keseluruhan di us
# H1: distribusi crime memiliki differ terhadap kategori crime tsb di us
ks.test(us_crime_stlawrence$Murder, us_crime$Murder)
ks.test(us_crime_stlawrence$Rape, us_crime$Rape)
ks.test(us_crime_stlawrence$Robbery, us_crime$Robbery)
ks.test(us_crime_stlawrence$`Aggravated Assault`, us_crime$`Aggravated Assault`)
ks.test(us_crime_stlawrence$Burglary, us_crime$Burglary)
ks.test(us_crime_stlawrence$Larceny, us_crime$Larceny)
ks.test(us_crime_stlawrence$`Motor Vehicle Theft`, us_crime$`Motor Vehicle Theft`)
# Kesimpulan: distribusi crime Aggravated Assault dan Burglary sama dengan keseluruhan us 
# dan banyak deviasi terhadap crime lain

# convert and subset to matrix
matrix_us_stlawrence = data.matrix(us_crime_stlawrence[c(4:10)])
# multivariate test
mnorm.test(matrix_us_stlawrence)

# Kesimpulan: tolak H0, data tidak terdistribusi normal dan memiliki 
# banyak deviasi terhadap data crime pada seluruh 
# us sesuai dengan analisis univariate 
# yang sudah dilakukan terhadap masing - masing crime category

#### Washington ####
# Subset Washington
us_crime_washington <- subset(us_crime, `County` == 'Washington')

# Plot (Descriptive)
washington_hist1 <- ggplot(data = us_crime_washington, aes(x=Year, y=Murder)) + geom_bar(stat='identity') + theme_bw() 
washington_hist2 <- ggplot(data = us_crime_washington, aes(x=Year, y=Rape)) + geom_bar(stat='identity') + theme_bw()
washington_hist3 <- ggplot(data = us_crime_washington, aes(x=Year, y=Robbery)) + geom_bar(stat='identity') + theme_bw()
washington_hist4 <- ggplot(data = us_crime_washington, aes(x=Year, y=`Aggravated Assault`)) + geom_bar(stat='identity') + theme_bw()
washington_hist5 <- ggplot(data = us_crime_washington, aes(x=Year, y=Burglary)) + geom_bar(stat='identity') + theme_bw()
washington_hist6 <- ggplot(data = us_crime_washington, aes(x=Year, y=Larceny)) + geom_bar(stat='identity')+ theme_bw()
washington_hist7 <- ggplot(data = us_crime_washington, aes(x=Year, y=`Motor Vehicle Theft`)) + geom_bar(stat='identity') + theme_bw()


# make list
washington_crime_list <- list(washington_hist1, washington_hist2, washington_hist3, washington_hist4, 
                            washington_hist5, washington_hist6, washington_hist7)
# arrange to 1 plot
ggarrange(plotlist = washington_crime_list,
          ncol = 2, nrow = 4)

# univariate test
# KS Test (Inference)
# H0: distribusi crime dengan kategori x normal terhadap keseluruhan di us
# H1: distribusi crime memiliki differ terhadap kategori crime tsb di us
ks.test(us_crime_washington$Murder, us_crime$Murder)
ks.test(us_crime_washington$Rape, us_crime$Rape)
ks.test(us_crime_washington$Robbery, us_crime$Robbery)
ks.test(us_crime_washington$`Aggravated Assault`, us_crime$`Aggravated Assault`)
ks.test(us_crime_washington$Burglary, us_crime$Burglary)
ks.test(us_crime_washington$Larceny, us_crime$Larceny)
ks.test(us_crime_washington$`Motor Vehicle Theft`, us_crime$`Motor Vehicle Theft`)
#Kesimpulan: distribusi murder dan aggravate assault sama dengan keseluruhan us
#dan banyak deviasi terhadap crime lain

# convert and subset to matrix
matrix_us_washington = data.matrix(us_crime_washington[c(4:10)])

# multivariate test
mnorm.test(matrix_us_washington)
# Kesimpulan: tolak H0, data tidak terdistribusi normal dan memiliki 
# banyak deviasi terhadap data crime pada seluruh 
# us sesuai dengan analisis univariate 
# yang sudah dilakukan terhadap masing - masing crime category

#### Westchester ####
# Subset Westchester
us_crime_westchester <- subset(us_crime, `County` == 'Westchester')

# Plot (Descriptive)
westchester_hist1 <- ggplot(data = us_crime_westchester, aes(x=Year, y=Murder)) + geom_bar(stat='identity') + theme_bw() 
westchester_hist2 <- ggplot(data = us_crime_westchester, aes(x=Year, y=Rape)) + geom_bar(stat='identity') + theme_bw()
westchester_hist3 <- ggplot(data = us_crime_westchester, aes(x=Year, y=Robbery)) + geom_bar(stat='identity') + theme_bw()
westchester_hist4 <- ggplot(data = us_crime_westchester, aes(x=Year, y=`Aggravated Assault`)) + geom_bar(stat='identity') + theme_bw()
westchester_hist5 <- ggplot(data = us_crime_westchester, aes(x=Year, y=Burglary)) + geom_bar(stat='identity') + theme_bw()
westchester_hist6 <- ggplot(data = us_crime_westchester, aes(x=Year, y=Larceny)) + geom_bar(stat='identity')+ theme_bw()
westchester_hist7 <- ggplot(data = us_crime_westchester, aes(x=Year, y=`Motor Vehicle Theft`)) + geom_bar(stat='identity') + theme_bw()

# make list
westchester_crime_list <- list(westchester_hist1, westchester_hist2, westchester_hist3, westchester_hist4, 
                            westchester_hist5, westchester_hist6, westchester_hist7)
# arrange to 1 plot
ggarrange(plotlist = westchester_crime_list,
          ncol = 2, nrow = 4)

# univariate test
# KS Test (Inference)
# H0: distribusi crime dengan kategori x normal terhadap keseluruhan di us
# H1: distribusi crime memiliki differ terhadap kategori crime tsb di us
ks.test(us_crime_westchester$Murder, us_crime$Murder)
ks.test(us_crime_westchester$Rape, us_crime$Rape)
ks.test(us_crime_westchester$Robbery, us_crime$Robbery)
ks.test(us_crime_westchester$`Aggravated Assault`, us_crime$`Aggravated Assault`)

ks.test(us_crime_westchester$Burglary, us_crime$Burglary)
ks.test(us_crime_westchester$Larceny, us_crime$Larceny)
ks.test(us_crime_westchester$`Motor Vehicle Theft`, us_crime$`Motor Vehicle Theft`)
#Kesimpulan distribusi murder rape dan aggravated assault sama dengan us
#banyak deviasi terhadap crime lain

# convert and subset to matrix
matrix_us_westchester = data.matrix(us_crime_westchester[c(4:10)])

# multivariate test
mnorm.test(matrix_us_westchester)
# Kesimpulan: tolak H0, data tidak terdistribusi normal dan memiliki 
# banyak deviasi terhadap data crime pada seluruh 
# us sesuai dengan analisis univariate 
# yang sudah dilakukan terhadap masing - masing crime category


#### Cluster analysis ####


fit <- pvclust(matrix_us_columbia, method.hclust="ward.D",
               method.dist = "manhattan")
plot(fit)

fit2 <- pvclust(matrix_us_columbia, method.hclust="ward.D",
               method.dist = "euclidean")
plot(fit2)
