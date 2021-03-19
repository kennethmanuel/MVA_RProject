# Nominal (makanan & minuman)
barang <- c('makanan', 'minuman', 'minuman', 'minuman', 'makanan', 'makanan', 'minuman')
kategori.barang <- factor(barang)

# Ordinal (memiliki tingkat)
rasa <- c('payah', 'maknyus', 'mantap', 'biasa', 'biasa', 'tidak enak', 'payah')
kategori.rasa <- factor(rasa, ordered = TRUE, 
                        levels = c('payah', 'tidak enak', 'biasa', 'mantap', 'maknyus'))