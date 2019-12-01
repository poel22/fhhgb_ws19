## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)


## ------------------------------------------------------------------------
df = data.frame(rnorm(100, mean=50, s=20))
count <- 0;
min(df)
max(df)
for (i in df[[1]]) {
  if (i < 60) {
  } else {
    count <- count + 1
  }
}
count


## ------------------------------------------------------------------------
head(iris)
df_log = cbind(log(iris[,c(1:4)]), Species=iris[,5])
head(df_log)


## ------------------------------------------------------------------------
is.sorted = function(x) {
  index = 1
  toReturn = TRUE
  for (val in tail(x, -1)) {
    if (val < x[index]) toReturn = FALSE
    index = index + 1
  }
  toReturn
  
}
is.sorted(c(1:9))


## ------------------------------------------------------------------------
is.sorted(c(9:1))


## ------------------------------------------------------------------------
is.sorted(c(4:20, 19:4))


## ------------------------------------------------------------------------
ger_comp = data.frame(read.csv(file="./Germany_largest_companies.csv", sep=";"))
head(ger_comp)


## ------------------------------------------------------------------------
boxplot(ger_comp[,c(4, 7)])


## ------------------------------------------------------------------------
boxplot(ger_comp[,6], xlab="Assets")


## ------------------------------------------------------------------------
boxplot(ger_comp[,5], xlab="Profits")

## ------------------------------------------------------------------------
cor(ger_comp[,c(4:7)])


## ------------------------------------------------------------------------
house_prices = data.frame(read.csv(file="./HousePricesAroundtheWorld.csv", sep=";")[,c(1, 2, 4)])
credit_growth = data.frame(read.csv(file="./CreditGrowth.csv", sep=";"))[,3]

head(credit_growth)

combined = cbind(house_prices, credit_growth)

head(combined)

boxplot(combined[,c(3, 4)])


## ------------------------------------------------------------------------
cor(combined[,c(3, 4)])

