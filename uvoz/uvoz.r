# 2. faza: Uvoz podatkov

sl <- locale("sl", decimal_mark = ",", grouping_mark = ".")


# Funkcija, ki uvozi podatke iz datoteke druzine.csv
#CSV TABELE
sl <- locale(encoding = "Windows-1250")

#========================================================================================================
#TABELA1 - sklenitev zakonskih zvez po letih
osnovni.podatki.poroke <- read_csv2(file = "podatki/Tabela1.csv", skip = 2, locale = sl, trim_ws = TRUE) %>%
  melt(value.name = "vrednost", variable.name = "spremenljivka", id.vars = 1)
colnames(osnovni.podatki.poroke)[1] <- "leto"

#POPRAVI: poimenovanje stolpcev

#========================================================================================================
#TABELA2
poroke.starost <- read_csv2(file ="podatki/Tabela2.csv", skip = 3, n_max = 13, locale = sl, 
                            trim_ws = TRUE, na = c("-", ""))
stolpci <- data.frame()

#========================================================================================================
#TABELA3 - število razvez po letih
osnovni.podatki.razveze <- read_csv2(file = "podatki/Tabela3.csv", skip = 3, n_max = 34, locale = sl, trim_ws = TRUE) %>%
 melt()
colnames(data) <- c("leto", "spremenljivka", "vrednost")
  
#  melt(value.name = "vrednost", variable.name = "spremenljivka", id.vars = 1)
#colnames(osnovni.podatki.poroke)[1] <- "leto"


#POPRAVI: poimenovanje stolpcev


#========================================================================================================
#TABELA4
razveze.starost <- read_csv2(file ="podatki/Tabela4.csv", skip = 2, n_max = 254, locale = sl)

#========================================================================================================

