# 2. faza: Uvoz podatkov

sl <- locale("sl", decimal_mark = ",", grouping_mark = ".")

# Funkcija, ki uvozi občine iz Wikipedije
# uvozi.obcine <- function() {
#   link <- "http://sl.wikipedia.org/wiki/Seznam_ob%C4%8Din_v_Sloveniji"
#   stran <- html_session(link) %>% read_html()
#   tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable sortable']") %>%
#     .[[1]] %>% html_table(dec = ",")
#   for (i in 1:ncol(tabela)) {
#     if (is.character(tabela[[i]])) {
#       Encoding(tabela[[i]]) <- "UTF-8"
#     }
#   }
#   colnames(tabela) <- c("obcina", "povrsina", "prebivalci", "gostota", "naselja",
#                         "ustanovitev", "pokrajina", "regija", "odcepitev")
#   tabela$obcina <- gsub("Slovenskih", "Slov.", tabela$obcina)
#   tabela$obcina[tabela$obcina == "Kanal ob Soči"] <- "Kanal"
#   tabela$obcina[tabela$obcina == "Loški potok"] <- "Loški Potok"
#   for (col in c("povrsina", "prebivalci", "gostota", "naselja", "ustanovitev")) {
#     tabela[[col]] <- parse_number(tabela[[col]], na = "-", locale = sl)
#   }
#   for (col in c("obcina", "pokrajina", "regija")) {
#     tabela[[col]] <- factor(tabela[[col]])
#   }
#   return(tabela)
# }

# Funkcija, ki uvozi podatke iz datoteke druzine.csv
#CSV TABELE
sl <- locale(encoding = "Windows-1250")

#TABELA1
osnovni.podatki.poroke <- read_csv2(file = "podatki/Tabela1.csv", skip = 2, locale = sl) %>%
  melt(value.name = "vrednost", variable.name = "spremenljivka", id.vars = 1)
colnames(osnovni.podatki.poroke)[1] <- "leto"

#TABELA2(zajebana)
poroke.starost <- read_csv2(file ="podatki/Tabela2.csv", skip = 3, n_max = 14, locale = sl)

#TABELA3
osnovni.podatki.razveze <- read_csv2(file = "podatki/Tabela3.csv", skip = 3, n_max = 34, locale = sl) %>%
  melt(value.name = "vrednost", variable.name = "spremenljivka", id.vars = 1)
colnames(osnovni.podatki.poroke)[0] <- "leto"

#TABELA4
razveze.starost <- read.csv(file ="Tabela4.csv",header = FALSE,sep = ";",encoding = "UTF-8" )


#   data$obcina <- data$obcina %>% strapplyc("^([^/]*)") %>% unlist() %>%
#     strapplyc("([^ ]+)") %>% sapply(paste, collapse = " ") %>% unlist()
#   data$obcina[data$obcina == "Sveti Jurij"] <- "Sveti Jurij ob Ščavnici"
#   data <- data %>% melt(id.vars = "obcina", variable.name = "velikost.druzine",
#                         value.name = "stevilo.druzin")
#   data$velikost.druzine <- parse_number(data$velikost.druzine)
#   data$obcina <- factor(data$obcina, levels = obcine)
#   return(data)


# Zapišimo podatke v razpredelnico obcine
obcine <- uvozi.obcine()

# Zapišimo podatke v razpredelnico druzine.
druzine <- uvozi.druzine(levels(obcine$obcina))

# Če bi imeli več funkcij za uvoz in nekaterih npr. še ne bi
# potrebovali v 3. fazi, bi bilo smiselno funkcije dati v svojo
# datoteko, tukaj pa bi klicali tiste, ki jih potrebujemo v
# 2. fazi. Seveda bi morali ustrezno datoteko uvoziti v prihodnjih
# fazah.
