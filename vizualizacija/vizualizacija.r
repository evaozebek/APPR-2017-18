# 3. faza: Vizualizacija podatkov

library(ggplot2)
library(dplyr)

st.porok <- ggplot(osnovni.podatki.poroke %>% filter(spremenljivka == "Sklenitve zakonskih zvez - Skupaj"),
                   aes(x = leto, y = vrednost)) + geom_line() + 
  xlab("Leto") + ylab("Stevilo porok") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1))



st.razvez <- ggplot(osnovni.podatki.razveze %>% filter(spremenljivka == "Razveze - SKUPAJ"), 
                    aes(x = leto, y = vrednost)) + geom_line() + 
  xlab("Leto") + ylab("Stevilo razvez") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1))





# Uvozimo zemljevid.
#zemljevid <- uvozi.zemljevid("http://baza.fmf.uni-lj.si/OB.zip",
 #                            "OB/OB", encoding = "Windows-1250")
#levels(zemljevid$OB_UIME) <- levels(zemljevid$OB_UIME) %>%
 # { gsub("Slovenskih", "Slov.", .) } %>% { gsub("-", " - ", .) }
#zemljevid$OB_UIME <- factor(zemljevid$OB_UIME, levels = levels(obcine$obcina))
#zemljevid <- pretvori.zemljevid(zemljevid)

# Izračunamo povprečno velikost družine
#povprecja <- druzine %>% group_by(obcina) %>%
#  summarise(povprecje = sum(velikost.druzine * stevilo.druzin) / sum(stevilo.druzin))
