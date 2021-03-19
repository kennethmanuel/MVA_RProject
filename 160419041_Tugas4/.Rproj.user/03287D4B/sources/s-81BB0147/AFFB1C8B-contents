# TUGAS 4
# Lakukan pengujian dan analisis Multivariate Normal seoptimal yang anda bisa
# lakukan pada data Kriminal di USA dari tahun 1990 sd 2019, baik tahunan maupun
# secara keseluruhan panel datanya. Gunakan 8 variabel yang ada dalam data
# tersebut semuanya.

library(readxl)

# Baca data
CrimeData_All <-
  read_excel("datasets/_Index_Crimes_by_County_and_Agency__Beginning_1990.xlsx")

# Filter baris (tanpa total)
CrimeData_Filter1 <-
  subset(
    CrimeData_All,
    !`Agency` == "County Total" &
      !`Agency` == "Region Total" & !is.na(`Murder`)
  )
# Filter kolom (sisakan yang diperlukan saja)
CrimeData_Filter2 <- CrimeData_Filter1[c(1:3, 7:14)]
# Ganti semua NA jadi 0
CrimeData_Filter2[is.na(CrimeData_Filter2)] <- 0
# Grouping tahunan
group_tahunan <- aggregate(CrimeData_Filter2[c(4:11)],
                           by = list(Year = CrimeData_Filter2$Year),
                           FUN = sum)

# Rumus multivariate normal
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

matrix_1 = data.matrix(group_tahunan[c(2:9)])
mnorm.test(matrix_1)

