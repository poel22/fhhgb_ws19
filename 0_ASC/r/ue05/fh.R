setwd("U:\\Lehre\\DSE\\R\\04_Prg")
library(ggplot2)

data <- rnorm(10000,0,1)
head(data)
hist(data, xlim=c(-4,4), ylim=c(0,2000))
par(new=TRUE)
plot(dnorm(seq(-4,4,0.01),0,1), type="l", col="red",
     xaxt="n", yaxt="n", ylab="", xlab="")

# Überprüfen NV
x1 <- rnorm(1000,10,1)
x2 <- rnorm(1000,15,1)
hist(x1, xlim=c(5,20))
par(new=T)
hist(x2, xlim=c(5,20))
par(new=T)
plot(dnorm(seq(5,20,0.01),10,1), type="l", col="red",
     xaxt="n", yaxt="n", ylab="", xlab="")
par(new=T)
plot(dnorm(seq(5,20,0.01),15,1), type="l", col="blue",
     xaxt="n", yaxt="n", ylab="", xlab="")
x3 <- c(x1,x2)
hist(x3, xlim=c(5,20))
shapiro.test(x1)
shapiro.test(x2)
shapiro.test(x3)

sw.s <- iris[which(iris$Species=="setosa"), "Sepal.Width"]
sw.vi <- iris[which(iris$Species=="virginica"), "Sepal.Width"]
pw.vi <- iris[which(iris$Species=="virginica"), "Petal.Width"]
hist(sw.s)
mean(sw.s)
median(sw.s)
boxplot(sw.s)
qqnorm(sw.s)
qqline(sw.s, col="red")

# Tests auf NV
# KS
# betrachtet  v.a. die Mitte flächenmäßige Abweichung
# relativ geringe Güte
ks.test(sw.s, "pnorm", mean(sw.s), sd(sw.s))
install.packages("nortest")
library(nortest)
lillie.test(sw.s)
# anderson-darling
# n>7, paarweiser Vergleich extremer Werte
# v.a. die Ränder
ad.test(sw.s)
cvm.test(sw.s)
# Shapiro-Wilk
# n>=3, n<5000, laut Lit höchste Güte
x<- shapiro.test(sw.s)
x$p.value
shapiro.test(iris$Petal.Length)
shapiro.test(iris$Sepal.Width)
sapply(iris[1:4], shapiro.test)
aggregate(Sepal.Width~Species, iris, shapiro.test)
x <- aggregate(iris[1:4], by=list(iris$Species), 
          FUN=shapiro.test)
x[[3]][1,"p.value"]
         
# TESTS

# tTest
# metrische Skalierung
# NV
# <=2 Gruppen
degf <- c(1,8,30,100)
colors <- c("red","blue","darkgreen","gold")
x <- seq(-4,4,100)
hx <- dnorm(x)
plot(x,hx,type="l")
for(i in 1:4){
  par(new=T)
  plot(dt(seq(-4,4,length=100), df=degf[i]), type="l",
       ylim=c(0, 0.4), lwd=2, col=colors[i])
}

# One Sample t-test
# Gauss-Test (z-test): n>30 & sigma bekannt
z.test = function(a,mu,var,alt=1){
  zeta <- (mean(a)-mu)/sqrt(var/length(a))
  p <- 1-pnorm(zeta)
  if(alt==2) p <- p*2
  return(p)
}

set <- iris[which(iris$Species=="setosa"),]
vir <- iris[which(iris$Species=="virginica"),]
# H0: Sepallänge von Setosa ist =5
z.test(a=set$Sepal.Length, mu=5, var=0.124, 2)

# oder aus package
install.packages("BSDA")
library(BSDA)
BSDA::z.test(set$Sepal.Length, mu=5, sigma.x=0.352,
             alternative = "two.sided")

# auch n<30 oder sigma=?
# -> ttest
t.t <- t.test(set$Sepal.Length, mu=5)
t.t$p.value
t.t$statistic
t.t$parameter

# 2 Gruppen
# unpaired ttest
# Test auf Homoskedasdizität (gleiche Var)
var.test(set$Sepal.Width, vir$Sepal.Width)
bartlett.test(iris$Sepal.Width, iris$Species)
bartlett.test(Sepal.Width~Species, iris)
install.packages("Rcmdr")
library(Rcmdr)
leveneTest(Sepal.Width~Species, iris)
# -> gleiche Varianzen in allen 3 Gruppen

# t.test
# H0 Sepalbreite ist in set und vir gleich
t.test(set$Sepal.Width, vir$Sepal.Width, var.equal=T)

# Effektstärke
install.packages("compute.es")
library(compute.es)
tes(6.4503, 50,50)

# ANOVA
# metrische Daten
# NV
# > 2 Gruppen
aov.iris <- aov(Sepal.Width~Species, iris)
summary(aov.iris)
# -> p<2e-16 -> H1: mind 1 gruppe ist untersch.
# -> Alpha-Fehlerkorrektur + Post-Hoc-Analysen
TukeyHSD(aov.iris)

library(ggplot2)
aov.dia <- aov(price~cut+color, diamonds)
summary(aov.dia)
TukeyHSD(aov.dia)

pairwise.t.test(iris$Sepal.Width, iris$Species,
                p.adj="hochberg")
?pairwise.t.test

# Nichtparameter Test
# U-test 
# ordinal
# Ausreisser
# nicht nV
# unpaired
head(diamonds)
ideal <- as.numeric(unlist(diamonds[which(diamonds$cut=="Ideal"),"price"]))
fair <- as.numeric(unlist(diamonds[which(diamonds$cut=="Fair"),"price"]))
wilcox.test(ideal, fair)
median(ideal)
median(fair)

# Wilcoxon-test
wilcox.test(iris$Sepal.Length, iris$Petal.Length, paired=TRUE)

# Kruskal-Wallis
# ordinal <=2 Gruppen
kruskal.test(iris$Sepal.Width, iris$Species)
install.packages("agricolae")
library(agricolae)
x<-kruskal(iris$Sepal.Width, iris$Species, p.adj="bon", group = FALSE)
x$comparison

# Friedman test
# ordinal
# >2 gruppen
dia <- aggregate(diamonds$price, 
                 by=list(cut=diamonds$cut, color=diamonds$color),
                 FUN=mean)
friedman.test(dia$x, dia$cut, dia$color)

# NOMINALE Daten

# chi-squared
mtcars
x <- table(mtcars$gear, mtcars$cyl)
chisq.test(x)
fisher.test(x)

install.packages("mosaic")
library(mosaic)
xchisq.test(gear~cyl, data=mtcars)

# Effektstärke
compute.es::chies(4,18) # TODO

# McNemar
# 2 Merkmale
# paired
# dichotom (2 Ausprägungen)
# n Fälle > 30
# expected pro Zelle >5
m <- matrix(c(45,4,15,56), nrow=2)
rownames(m) <- c("Verfahren A+", "Verfahren A-")
colnames(m) <- c("Verfahren B+", "Verfahren B-")
m
mcnemar.test(m)

# Stuart-Maxwell test
# 2 merkmale
# >2 Ausprägungen
# paired
install.packages("irr")
library(irr)
x <- as.table(matrix(round(runif(9,10,100)), nrow=3))
stuart.maxwell.mh(x)
