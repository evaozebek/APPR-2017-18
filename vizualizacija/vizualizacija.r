# 3. faza: Vizualizacija podatkov

library(ggplot2)
library(dplyr)
#========================================================================================================
#GRAFI
st.porok <- ggplot(osnovni.podatki.poroke %>% filter(spremenljivka == "Sklenitve zakonskih zvez - Skupaj"),
                   aes(x = leto, y = vrednost)) + geom_line() + 
  xlab("Leto") + ylab("Stevilo porok") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1))



st.razvez <- ggplot(osnovni.podatki.razveze %>% filter(spremenljivka == "Razveze - SKUPAJ"), 
                    aes(x = leto, y = vrednost)) + geom_line() + 
  xlab("Leto") + ylab("Stevilo razvez") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1))

prve.zveze <-ggplot(osnovni.podatki.poroke %>% filter(spremenljivka == "Prve sklenitve zakonskih zvez"), 
                                 aes(x = leto, y = vrednost)) + geom_line() + 
  xlab("Leto") + ylab("Prve sklenitve zakonskih zvez") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1))

razveze.z.otroki <- ggplot(osnovni.podatki.razveze %>% filter(spremenljivka == "Razveze zakonskih zvez z otroki"), 
                           aes(x = leto, y = vrednost)) + geom_line() + 
  xlab("Leto") + ylab("Razveze zakonskih zvez z otroki") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1))

razveze.brez.otrok <- ggplot(osnovni.podatki.razveze %>% filter(spremenljivka == "Razveze zakonskih zvez brez otrok"), 
                           aes(x = leto, y = vrednost)) + geom_line() + 
  xlab("Leto") + ylab("Razveze zakonskih zvez brez otrok") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1))


#še primerjava med zakonskim stanom ženina in neveste pred poroko(vdova,samski...)
#========================================================================================================
#ZEMLJEVID
library(sp)
library(maptools)
library(digest)
gpclibPermit()


