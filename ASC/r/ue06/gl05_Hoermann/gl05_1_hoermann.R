## ------------------------------------------------------------------------
library(data.table)
library(dplyr)


## ----echo=F--------------------------------------------------------------
dtforbes = data.table(fread("./Forbes2000.csv"))

## ------------------------------------------------------------------------
str(dtforbes)

## ------------------------------------------------------------------------
ndtforbes = nrow(dtforbes)


## ------------------------------------------------------------------------
slice(dtforbes, c(1:5, (n() - 5):n()))


## ------------------------------------------------------------------------
dtforbes[,list(
  Min = min(sales),
  Median = median(sales),
  Max = max(sales),
  SD = sd(sales)
)]


## ------------------------------------------------------------------------
dtforbes[,list(
  Min = min(profits),
  Median = median(profits),
  Max = max(profits),
  SD = sd(profits)
)]


## ------------------------------------------------------------------------
dtforbes[,list(
  Min = min(assets),
  Median = median(assets),
  Max = max(assets),
  SD = sd(assets)
)]


## ------------------------------------------------------------------------
dtforbes[,list(
  Min = min(marketvalue),
  Median = median(marketvalue),
  Max = max(marketvalue),
  SD = sd(marketvalue)
)]


## ------------------------------------------------------------------------
setkey(dtforbes, country, assets, category, profits)


## ------------------------------------------------------------------------
dtforbes[("Austria")]


## ------------------------------------------------------------------------
dtforbes[,.(Mittel_Land = mean(assets)), by = country]


## ------------------------------------------------------------------------
dtforbes[,.(Mittel_Land_Kategorie = mean(assets)), by = list(country, category)]


## ------------------------------------------------------------------------
dtforbes[,list(Mittel_assets = mean(assets),Mittel_profit = mean(sales))]


## ------------------------------------------------------------------------
dtforbes[("United States"),
         list(Anzahl = length(name),Mittel_assets = mean(assets),Mittel_profit = mean(sales)),
         by = category]

