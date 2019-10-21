## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)


## ----cars, echo=F--------------------------------------------------------
summary(cars, echo=TRUE)


## ---- echo=FALSE---------------------------------------------------------
plot(cars$speed, cars$dist, ylab="Entfernung", xlab="Geschwindigkeit")


## ----overview, echo=F----------------------------------------------------
library(knitr)
kable(summary(cars))


## ----norm, echo=F--------------------------------------------------------
library(plyr)
x <- round((rnorm(1000)), digits=1)
hist(x)

