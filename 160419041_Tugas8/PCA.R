# Pricipal Components Analysis
# entering raw data and extracting PCs from the correlation matrix
#
# Matrix correlation
install.packages("corrplot")
library(corrplot)
#
iris.cor=cor(iris[-5])
iris.cor
corrplot(iris.cor)
corrplot.mixed(iris.cor)

#
# eigenvalue and eigenvector

eigen(iris.cor)

#
# Principal Component Analysis
# ++++++++++++++++++++++++++
fit <- princomp(iris[-5], cor=TRUE)
summary(fit) # print variance accounted for
#
loadings(fit) # pc loadings -- Eigenvectors
#
plot(fit,type="lines") # scree plot
#
fit$scores # the principal components score
biplot(fit) 
  
