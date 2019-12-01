getwd()
setwd("git/fhhgb_ws19/0_ASC/r/ue06")
(.packages())

# data.table
library(data.table)
adt = data.table(a = 1:10, b = LETTERS[1:10],
                 c = rep(c("One", "Two", "Three"), length.out = 10),
                 d = rep(LETTERS[1:2], length.out = 10))
adt
str(adt)
class(adt)
dt.iris = as.data.table(iris)
dt.iris[1:2,]
dt.iris[Petal.Width>2.4,list(Species, Petal.Width)]
dt.iris[Petal.Width>2.4,c("Species", "Petal.Width")]

# keys setzen
setkey(adt, c, d)
key(adt)
adt["One"]
adt["A", on = "d"]
adt[.N-2] # vorletzter
adt[c("One", "Three"),] # or
adt[J("One", "A")] # and
adt[.("One", "A")] # and

library(ggplot2)
class(diamonds)

dt.diamonds = data.table(diamonds)
setkey(dt.diamonds, cut, color, clarity, price)
dt.diamonds[.("Fair")]
dt.diamonds["SI1", on = "clarity"]
dt.diamonds[.("Fair", c("D", "E"))]
# data frame style
dt.diamonds[which(dt.diamonds$cut == "Fair" & (dt.diamonds$color == "D" | dt.diamonds$color == "E"))]

# sort
dt.diamonds[order(price)] # asc
dt.diamonds[order(-price)] # desc
dt.diamonds[order(price, -carat)] # asc for price, desc for carat

# berechnungen
dt.diamonds[,sum(price < 400)]
dt.diamonds[,list(Preis = mean(price),
                  Median = median(price),
                  Tiefe = mean(depth))]

# group_by
dt.diamonds[, .N, by = cut]
dt.diamonds[, list(Preis = mean(price),
                   Median = median(price),
                   by = cut)]
dt.diamonds[, list(Preis = mean(price),
                   Median = median(price),
                   by = list(cut, color))]
dt.diamonds[price > 10000, list(Preis = mean(price),
                   Median = median(price),
                   by = list(cut, color))]
# neue Spalten / Berechnungen
dt.diamonds[, Tiefe := round((z * 200/ (x + y)), 1)]
dt.diamonds[, Tiefe := NULL]

# plyr
# alle plyr fkt haben gleiche syntax
# 1. Buchstabe: input
# 2. Buchstable: output

# Wh
library(plyr)
tapply(iris$Petal.Width, iris$Species, mean)
aggregate(iris$Petal.Width~Species, data = iris, mean)
ddply(.data = iris, .variables = "Species", .fun = summarize,
      PBreite = mean(Petal.Width),
      PLänge = mean(Petal.Length))
ddply(iris, "Species", numcolwise(mean))

# dplyr
# Vokabular
# select: auswahl der spalten
# filter: Auswahl auf Basis logischer Operationen
# arrange: Sortiert die Zeilen
# mutate: neue Variablen oder Veränderungen
# summarize: Zusammenfügen für desk. Stat.
# neu !!! %>% pipe Operator um Daten von einer Dkt. in die nächste überzuführen
# strg + shift + m

library(dplyr)
library(tidyr)

dim(head(iris, n = 4))
iris %>% head(4) %>% dim

class(diamonds)
str(diamonds)
str(iris)
tbl.iris = as.tbl(iris)
glimpse(tbl.iris)

# Select
# subset von spalten
select(diamonds, carat, price)
select(iris, Species, Sepal.Width)

# mit %>% symbol
tbl.iris %>% select(Species, Sepal.Width)
tbl.iris[, c("Species", "Sepal.Width")]
cols <- c("Species", "Sepal.Width")
tbl.iris %>% select(cols)
tbl.iris %>% select(starts_with("S"))
tbl.iris %>% select(matches("a.+e")) # regex
tbl.iris %>% select(-Sepal.Width, -Sepal.Length) # ohne

# filter
# zeilen nach logischem Ausdruck selektieren
tbl.iris %>% filter(Species %in% c("versicolor", "virginica"))
tbl.iris %>% select(Species, Sepal.Width) %>% filter(Species %in% c("versicolor", "virginica"))
tbl.iris %>% filter(Sepal.Width > 4 & Sepal.Length > 4)
tbl.iris %>% filter(between(Sepal.Width, 1, 3))
library(microbenchmark)
microbenchmark(
  filter(tbl.iris, Species == "setosa"),
  tbl.iris %>% filter(Species == "setosa"),
  tbl.iris[which(tbl.iris$Species == "setosa"),],
  tbl.iris[tbl.iris$Species == "setosa",]
)
