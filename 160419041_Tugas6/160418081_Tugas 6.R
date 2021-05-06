# cek wd
getwd()

# ganti wd jika perlu
setwd("E:/MAHASISWA/Semester 6/1604B341 Applied Multivariate Analysis A/W07")

# baca data
library("readxl")
SP_data <- read_excel("Salespeople-data.xlsx")


# i. Tentukan nilai eigenvalue berdasarkan matrik korelasinya.

# matrik korelasi
SP_cor <- cor(SP_data)

# nilai eigenvalue
SP_eig <- eigen(SP_cor)
SP_eig[["values"]]
SP_eig[["vectors"]]


# ii. Berdasarkan eigenvlue (nomo i.), putuskan berapa kluster.

plot(SP_eig[["values"]]) # 2 kluster


# iii. Buat klusternya sesuai keputusan nomor ii. dengan:

#   a. Non-hierarchy (K-Means - sesuai jumlah kluster hasil anda di nomor ii.)
SP_kmeans <- kmeans(SP_data, centers = 2)
SP_kmeans
# plotting
library(factoextra)
fviz_cluster(SP_kmeans, data = SP_data)


#   b. Hierarchy dengan jarak Euclidean dan metode single linkage. https://www.datacamp.com/community/tutorials/hierarchical-clustering-R

dist_mat <- dist(SP_data, method = 'euclidean')
SingleLink <- hclust(dist_mat, method = 'single')
#simpan hasil pemotongan kluster
cut_avg <- cutree(SingleLink, k = 2)
cut_avg
#plotting
plot(SingleLink) 
rect.hclust(SingleLink , k = 2, border = 3:33)


#   Simpanlah label kluster membership hasil iii.a. maupun iii.b.
SP_labelKM <-
  cbind(SP_data, `kmeans` = SP_kmeans[["cluster"]])
SP_labelSL <-
  cbind(SP_data, `SingeLink` = cut_avg)

# iv. Buatkan analisis diskriminan untuk memperoleh:

#   a. Prosentase ketepatan klasifikasi 50 slaesman ke hasil iii.a. maupun ke hasil iii.b.
#   b. fungsi diskriminan berdasarkan hasil iii.a. maupun ke hasil iii.b.

#kmeans
set.seed(123)
#Membagi dataset ke dalam Training dan Test.
train_index_kmeans <-
  sample(seq(nrow(SP_labelKM)), size = floor(0.75 * nrow(SP_labelKM)), replace = F)
training_data_kmeans <- SP_labelKM[train_index_kmeans,]
test_data_kmeans <- SP_labelKM[-train_index_kmeans,]
#Fungsi diskriminan analisis
library(MASS)   
linearDA_kmeans <- lda(formula = kmeans ~ ., data = training_data_kmeans)
linearDA_kmeans
#plot
plot(linearDA_kmeans, col = as.integer(training_data_kmeans$kmeans))
#prediksi
predicted <- predict(object = linearDA_kmeans, newdata = test_data_kmeans)
table(actual = test_data_kmeans$kmeans, predicted = predicted$class)
mean(predicted$class==test_data_kmeans$kmeans) #presentase

#SingleLink
set.seed(123)
#Membagi dataset ke dalam Training dan Test.
train_index_SL <-
  sample(seq(nrow(SP_labelSL)), size = floor(0.75 * nrow(SP_labelSL)), replace = F)
training_data_SL <- SP_labelSL[train_index_SL,]
test_data_SL <- SP_labelSL[-train_index_SL,]
#Fungsi diskriminan analisis
library(MASS)   #Fungsi diskriminan analisis
linearDA_SL <- lda(formula = SingeLink ~ ., data = training_data_SL)
linearDA_SL
#plot
plot(linearDA_SL, col = as.integer(training_data_SL$SingeLink))
#prediksi
predicted <- predict(object = linearDA_SL, newdata = test_data_SL)
table(actual = test_data_SL$SingeLink, predicted = predicted$class)
mean(predicted$class==test_data_SL$SingeLink) #presentase


# v. Lengkapi semua hasil analisis anda dengan interpretasi yang mudah dimengerti oleh orang awam.
# ...
