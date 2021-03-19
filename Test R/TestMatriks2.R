bil <- matrix(1:25, byrow=TRUE, nrow=5)

bil

# Operasi matriks
bil+bil
bil*bil

# Operasi aljabar linear
bil %*% bil
1/bil
bil^2

# Slicing and Indexing
# bil[baris, kolom]
bil[1,] # baris 1
bil[4:5,] # baris 4 sampai baris 5
bil[c(2,4),] # baris 2 dan baris 4
bil[c(1,3,4),] # baris 1,3, dan 4
bil[c(1,3,4), c(2,4,5)] # baris 1,3, dan 4 dengan kolom 2,4, dan 5
