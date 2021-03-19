# Matriks memiliki 1 tipe data
# Dataframe memiliki lebih dari 1 tipe data
df <- iris
str(df)
summary(df)

df2 <- mtcars
str(df2)
summary(df2)

df3 <- state.x77
str(df3)
summary(df3)

# Contoh pembuatan dataframe
cowok <- c('Bambang', 'Joko', 'Budi', 'Anton', 'Koko')
berat <- c(100, 50, 60, 70, 86)
golongan <- factor(c('gemuk', 'kurus', 'kurus', 'sedang', 'sedang'))

kelompok <- data.frame(cowok, berat, golongan)
str(kelompok)
summary(kelompok)

# Slicing
kelompok[3,2] #menghasilkan numerik 
kelompok[3,] #menghasilkan dataframe 
kelompok[c(1,3,4), c(1,3)]
kelompok['berat']
kelompok$berat #menghasilkan vektor
subset(kelompok, golongan == 'kurus') #menghasilkan dataframe
subset(kelompok, berat<80) 
