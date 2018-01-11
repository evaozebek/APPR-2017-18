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

zemljevid <- uvozi.zemljevid("http://biogeo.ucdavis.edu/data/gadm2.8/shp/SVN_adm_shp.zip",
                             "SVN_adm1", encoding = "UTF-8") %>% pretvori.zemljevid()


levels(zemljevid$NAME_1)[levels(zemljevid$NAME_1) %in%
                           c("Spodnjeposavska")] <- c("Posavska")
poroke <- poroke.regije[, names(poroke.regije), drop = F] 

povprecje <- poroke %>% group_by(regija) %>% summarise(poroke = mean(stevilo))

zemljevid.poroke <- ggplot() +
  geom_polygon(data = povprecje %>% right_join(zemljevid, by = c("regija" = "NAME_1")),
               aes(x = long, y = lat, group = group, fill = poroke), color = "black")+
  xlab("") + ylab("") + ggtitle("Stevilo porok na slovenske regije")

