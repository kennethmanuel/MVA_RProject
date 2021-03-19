# CSV

# Import csv
baru <- read.csv('example_datasets/kapal_titanic.csv')
head(baru) # 6 data pertama
tail(baru) # 6 data kedua

# Export csv
write.csv(baru, 'example_datasets/testExport.csv')
help("write.csv")

# XLSX
# ada 2 library opsional: readxl, xlsx

# install readxl 
install.packages("readxl")
# enable readxl
library(readxl)
# check sheet
excel_sheets('example_datasets/dataexcel.xlsx')
# import
excelbaru <- read_excel('example_datasets/dataexcel.xlsx', sheet = "Sheet1") # NOTE: TIDAK MENGHASILKAN FORMAT DATAFRAME TETAPI MENGHASILKAN FORMAT TIBBLE (TBL)



# install xlsx (Memerlukan JAVA)
install.packages("xlsx")
# enable xlsx
library(xlsx)
# Import
exceldua <- read.xlsx('example_datasets/dataexcel.xlsx', sheetName = 'Sheet1') # NOTE: menghasilkan format dataframe
# Export
write.xlsx(excelbaru, 'example_datasets/excelTestExport.xlsx')

