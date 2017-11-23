# Analiza podatkov s programom R, 2017/18

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2017/18

## Poroke in razveze v Sloveniji

Analizirala bom poroke in razveze v Sloveniji skozi čas in glede na starost ženina ter neveste. Zanimal me bo tudi zakonski stan ženina in neveste pred poroko torej ali je le-ta vdova/vdovec, samski/a ali pa razvezan/a. Analizirala bom tudi poroke in razveze v slovenskih regijah. Vključila bom tudi podatke o registriranih partnerskih skupnosti med moškima in med ženskama. 

Podatke bom pridobila na podatkovnem portalu Statističnega urada Republike Slovenije (http://pxweb.stat.si/pxweb/Dialog/statfile2.asp; demografsko in socialno področje) 
Podatki so na voljo v obliki tabel kot PC-Axis, Excel, txt., .csv, .htm, .xml ipd.


##### 1. tabela: sklenitve zakonskih zvez po starostnih skupinah ženina in neveste
- spol, starost, leto, sklenitve zakonskih zvez

##### 2. tabela: sklenitve zakonskih zvez po zakonskem stanu ženina in neveste
- spol, leto, starostne skupine, zakonski stan ženina, zakonski stan neveste

##### 3. tabela: Razveze zakonskih zvez po starostnih skupinah moža in žene
- razveze, mož/žena, starostne skupine, leto

##### 4. tabela: razveze zakonskih zvez po starostnih skupinah moža in žene ter trajanju zakonske zveze
- leto, spol, starostne skupine, trajanje zakonske zveze

##### 5. tabela: razveze zakonskih zvez glede na to, komu so bili otroci dodeljeni
- leto, otroci so bili dodeljeni

##### 6.tabela: primerjava števila porok in razvez
- leto, sklenitve zakonskih zvez, razveze



## Program

Glavni program in poročilo se nahajata v datoteki `projekt.Rmd`. Ko ga prevedemo,
se izvedejo programi, ki ustrezajo drugi, tretji in četrti fazi projekta:

* obdelava, uvoz in čiščenje podatkov: `uvoz/uvoz.r`
* analiza in vizualizacija podatkov: `vizualizacija/vizualizacija.r`
* napredna analiza podatkov: `analiza/analiza.r`

Vnaprej pripravljene funkcije se nahajajo v datotekah v mapi `lib/`. Podatkovni
viri so v mapi `podatki/`. Zemljevidi v obliki SHP, ki jih program pobere, se
shranijo v mapo `../zemljevidi/` (torej izven mape projekta).

## Potrebni paketi za R

Za zagon tega vzorca je potrebno namestiti sledeče pakete za R:

* `knitr` - za izdelovanje poročila
* `rmarkdown` - za prevajanje poročila v obliki RMarkdown
* `shiny` - za prikaz spletnega vmesnika
* `DT` - za prikaz interaktivne tabele
* `maptools` - za uvoz zemljevidov
* `sp` - za delo z zemljevidi
* `digest` - za zgoščevalne funkcije (uporabljajo se za shranjevanje zemljevidov)
* `readr` - za branje podatkov
* `rvest` - za pobiranje spletnih strani
* `reshape2` - za preoblikovanje podatkov v obliko *tidy data*
* `dplyr` - za delo s podatki
* `gsubfn` - za delo z nizi (čiščenje podatkov)
* `ggplot2` - za izrisovanje grafov
* `extrafont` - za pravilen prikaz šumnikov (neobvezno)
