# 2. faza: Uvoz podatkov

sl <- locale("sl", decimal_mark = ",", grouping_mark = ".")


# Funkcija, ki uvozi podatke iz datoteke druzine.csv
#CSV TABELE
sl <- locale(encoding = "Windows-1250")

#========================================================================================================
#TABELA1 - sklenitev zakonskih zvez po letih
osnovni.podatki.poroke <- read_csv2(file = "podatki/Tabela1.csv", skip = 2, locale = sl, trim_ws = TRUE) %>%
  .[, 1:9] %>% melt(value.name = "vrednost", variable.name = "spremenljivka", id.vars = 1, na = "-")
colnames(osnovni.podatki.poroke)[1] <- "leto"


#========================================================================================================
#TABELA2
poroke.starost <- read_csv2(file ="podatki/Tabela2.csv", skip = 3, n_max = 13, locale = sl, 
                            trim_ws = TRUE, na = c("-", ""))
stolpci <- data.frame(leto = colnames(poroke.starost) %>% { gsub("X.*", NA, .) } %>% parse_number(),
                      nevesta = unlist(poroke.starost[1, ])) %>% fill(leto) %>%
  apply(1, paste, collapse = ",")
stolpci[1] <- "zenin"
colnames(poroke.starost) <- stolpci
poroke.starost.tidy <- melt(poroke.starost[-1, ], variable.name = "stolpec",
                            value.name = "stevilo", id.vars = "zenin") %>%
  filter(! grepl("SKUPAJ", zenin), ! grepl("SKUPAJ", stolpec)) %>%
  mutate(stolpec = parse_character(stolpec)) %>%
  transmute(leto = stolpec %>% strapplyc("^([0-9]+)") %>% unlist() %>% parse_number(),
            zenin = zenin %>% strapplyc("^(.* let)") %>% unlist(),
            nevesta = stolpec %>% strapplyc(",(.* let)") %>% { gsub("65", "65 +", .) } %>% unlist(),
            stevilo = stevilo %>% parse_number()) %>%
  mutate(zenin = zenin %>% parse_factor(unique(zenin), ordered = TRUE),
         nevesta = nevesta %>% parse_factor(unique(nevesta), ordered = TRUE))
#========================================================================================================
#TABELA3 - število razvez po letih
osnovni.podatki.razveze <- read_csv2(file = "podatki/Tabela3.csv", skip = 3, n_max = 34, locale = sl, trim_ws = TRUE) %>%

  melt(value.name = "vrednost", variable.name = "spremenljivka", id.vars = 1)
colnames(osnovni.podatki.razveze)[1] <- "leto"


#========================================================================================================
#TABELA4
razveze.starost <- read_csv2(file ="podatki/Tabela4.csv", skip = 3, n_max = 253, locale = sl) %>%
  fill(1) %>% drop_na(2) %>% melt(id.vars = 1:2, variable.name = "zena", value.name = "stevilo")
colnames(razveze.starost)[1:2] <- c("leto", "moz")
razveze.starost.tidy <- razveze.starost %>%
  filter(! grepl("SKUPAJ", moz), ! grepl("SKUPAJ", zena)) %>%
  mutate(moz = moz %>% strapplyc("^(.* let)") %>% unlist(),
         zena = zena %>% parse_character() %>% strapplyc("^(.* let)") %>% unlist() %>%
         { gsub("pod", "Pod", .) }) %>%
  mutate(moz = moz %>% parse_factor(unique(moz), ordered = TRUE),
         zena = zena %>% parse_factor(unique(zena), ordered = TRUE))

#========================================================================================================
#TABELA 5 - REGIJE POROKE
poroke.regije <- read_csv2(file = "podatki/Poroke-regije.csv", skip = 4, locale = sl) %>%
  rename(regija = LETO) %>% melt(id.vars = "regija", value.name = "stevilo", variable.name = "leto") %>%
  mutate(leto = parse_number(leto))


#========================================================================================================
#TABELA 6 - REGIJE RAZVEZE
razveze.regije <- read_csv2(file = "podatki/Razveze-regije.csv", skip = 4,locale = sl) %>%
  rename(regija = LETO) %>% melt(id.vars = "regija", value.name = "stevilo", variable.name = "leto") %>%
  mutate(leto = parse_number(leto))

