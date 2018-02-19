# 4. faza: Analiza podatkov
# 
# podatki <- obcine %>% transmute(obcina, povrsina, gostota,
#                                 gostota.naselij = naselja/povrsina) %>%
#   left_join(povprecja, by = "obcina")
# row.names(podatki) <- podatki$obcina
# podatki$obcina <- NULL
# 
# # Število skupin
# n <- 5
# skupine <- hclust(dist(scale(podatki))) %>% cutree(n)

osnovni.podatki <- rbind(osnovni.podatki.poroke, osnovni.podatki.razveze)

ociscena <- subset(osnovni.podatki, spremenljivka == "Sklenitve zakonskih zvez - Skupaj")
fit <- lm(data = ociscena, vrednost ~ leto)
a <- data.frame(leto=seq(1990, 2016, 1))
predict(fit, a)
napoved <- a %>% mutate(vrednost=predict(fit, .))
graf5 <- ggplot(ociscena, aes(x=leto, y=vrednost)) +
  geom_smooth(method=lm, se=FALSE) +
  geom_point(data=napoved, aes(x=leto, y=vrednost), color="blue", size=3) +
  labs(title="Napoved števila porok", y="Število porok")

