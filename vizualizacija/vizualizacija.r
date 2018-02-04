# 3. faza: Vizualizacija podatkov

library(ggplot2)
library(dplyr)
#========================================================================================================
#GRAFI
st.porok <- ggplot(osnovni.podatki.poroke %>% filter(spremenljivka == "Sklenitve zakonskih zvez - Skupaj"),
                   aes(x = leto, y = vrednost)) + geom_line() + 
  xlab("Leto") + ylab("Stevilo porok") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1))
 
#poskus - ZDRUŽITEV
#========================================================================================================
st.porok1 <- ggplot() + geom_line(data = osnovni.podatki.poroke %>% filter(spremenljivka == "Sklenitve zakonskih zvez - Skupaj"),
                                                            aes(x = leto, y= vrednost), color="red") + 
  geom_line(data = osnovni.podatki.razveze %>% filter(spremenljivka == "Razveze - SKUPAJ"), 
            aes(x = leto, y = vrednost), color="blue") +
  xlab("Leto") + ylab("Število") + 
    theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1))
#manjka še legenda
#========================================================================================================
#######
st.razvez <- ggplot(osnovni.podatki.razveze %>% filter(spremenljivka == "Razveze - SKUPAJ"), 
                    aes(x = leto, y = vrednost)) + geom_line() + 
  xlab("Leto") + ylab("Stevilo razvez") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1))



skupaj <- ggplot() + geom_line(aes(x = leto, y = vrednost)) + geom_line(aes(x = leto, y = vrednost))




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
                             "SVN_adm1", encoding = "") %>% pretvori.zemljevid()


levels(zemljevid$NAME_1)[levels(zemljevid$NAME_1) %in%
                           c("Notranjsko-kraška",
                             "Spodnjeposavska", "Koroška", "Goriška", "Obalno-kraška")] <- c("Primorsko-notranjska",
                                                      "Posavska", "Koroska", "Goriska", "Obalno-kraska")
#========================================================================================================
#POROKE
poroke <- poroke.regije[, names(poroke.regije), drop = F] 

povprecje <- poroke %>% group_by(regija) %>% summarise(poroke = mean(stevilo))

zemljevid.poroke <- ggplot() +
  geom_polygon(data = povprecje %>% right_join(zemljevid, by = c("regija" = "NAME_1")),
               aes(x = long, y = lat, group = group, fill = poroke))+
  xlab("") + ylab("") + ggtitle("Število porok po slovenskih regijah")

#zemljevid.poroke + scale_fill_gradient(low='green', high='red')

zemljevid.poroke + scale_fill_gradient(low = "#132B43", high = "#56B1F7", space = "Lab",
na.value = "grey50", guide = "colourbar")


#========================================================================================================
#RAZVEZE
razveze <- razveze.regije[, names(razveze.regije), drop = F] 

povprecje <- razveze %>% group_by(regija) %>% summarise(razveze = mean(stevilo))

zemljevid.razveze <- ggplot() +
  geom_polygon(data = povprecje %>% right_join(zemljevid, by = c("regija" = "NAME_1")),
               aes(x = long, y = lat, group = group, fill = razveze))+
  xlab("") + ylab("") + ggtitle("Število razvez po slovenskih regijah")


zemljevid.razveze + scale_fill_gradient(low = "#ffb7a8", high = "#bc4229", space = "Lab",
                                       na.value = "grey50", guide = "colourbar")

