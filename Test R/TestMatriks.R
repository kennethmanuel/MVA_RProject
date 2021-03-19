bil <- 1:20
# matriks.bil <- matrix(bil, nrow = 4, byrow = TRUE)
matriks.bil <- matrix(bil, nrow = 4)

# Saham4
TLKM <- c(3000, 3100, 3050, 3020, 3200)
KLBF <- c(324, 343, 300, 321, 355)

saham <- c(TLKM, KLBF)
saham.matrix <- matrix(saham, byrow = TRUE, nrow = 2)

hari <- c('Senin','Selasa','Rabu','Kamis','Jumat')
nama.saham <- c('TLKM','KLBF')

colnames(saham.matrix) <- hari
rownames(saham.matrix) <- nama.saham

BBCA <- c(1501, 1510, 1490, 1520, 1500)
# rbind, tambah baris
# cbind, tambah kolom
saham.baru <- rbind(saham.matrix, BBCA)

# colSums, jumlah semua variabel tiap kolom
colSums(saham.baru)
rowSums(saham.baru)
colMeans(saham.baru)
rowMeans(saham.baru)

Rataan <- rowMeans(saham.baru)
saham.baru <- cbind(saham.baru, Rataan)



