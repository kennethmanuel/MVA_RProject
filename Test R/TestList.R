# List = format data yang berisi tipe data campuran (vektor, matriks, data frame, list)
v <- c(1,2,3,4,5)
m <- matrix(1:20, nrow=4)
df <- iris

list.saya <- list(v, m, df)
# With named index
list.baru <- list(nama.v = v, nama.m = m, nama.df = df)

# Indexing

# list.baru[1] SALAH!!! (Menghasilkan tipe data list sehingga tidak bisa melakukan operasi matematika)
list.baru[[1]] # BENAR (Menghasilkan tipe data numeric)
class(list.baru[[1]])

# list.baru['nama.v'] SALAH!!! (Menghasilkan tipe data list sehingga tidak bisa melakukan operasi matematika)
list.baru[['nama.v']] # BENAR
list.baru$nama.v # BENAR