sqrt(2)^2 == 2
.Machine$double.eps

a <- 10
class(a)
mode(a)
typeof(a)
as.numeric(10)
as.roman(2019)

names = c("G", "A", "T", "C")

M_DNA = matrix(0:0, 4, 4)

row.names(M_DNA) <- names
colnames(M_DNA) <- names

M_DNA[1:2,3:4] = 3
M_DNA[3,4] = M_DNA[1,2] = 1

M_DNA + t(M_DNA)

L1 <- list(1:6,
           "a",
           c(T,F,TRUE,F),
           c(2.3,4.3,5.6),
           matrix(1:6, 2))

str(L1)

L1[[1]]
L1[[5]][1,2]

L1[[c(4,2)]]

L2 <- list(Info="R-Kurs", Liste1=L1)

L2$Info
L2$Liste1

L2$Liste1[[5]][1,2]

iris
head(iris)
class(iris)
str(iris)
summary(iris)
edit(iris)

read.table(header=T, text="
           a b
           1 2
           3 4
           ")

data <- data.frame(var1=c(1:5), var2 = c(10:14))
colnames(data) <- c("VarA", "VarB")
data[,"VarA"]
data[["VarA"]]

data$VarA
data <- rbind(data, c(10,17))

frame <- data.frame(id=integer(3),
                    max1=numeric(3),
                    min1=numeric(3))

frame <- data.frame(matrix(NA, nrow=10, ncol=5))

boston <- read.csv()

data.frame("a", "sex", "cm", "kg")

pers.dat <- data.frame(a=c(21,35,829,2),
           sex=factor(c("m","w","m","e")),
           cm=c(181,173,171,166),
           kg=c(69,58,75,69))

str(pers.dat)

str(iris)
class(iris$Species)
class(iris[["Species"]])

iris[1,"Species"]

iris[1,2]
str(iris)

iris[iris$Species == "setosa",]
pers.dat[pers.dat$sex == "w",]

iris$Species == "setosa"

any(iris$Sepal.Width < 2.4)

all(iris$Sepal.Width < 2.4)

which(iris$Sepal.Width < 2.4)
iris[which(iris$Sepal.Width < 2.4),]

which.max(iris$Sepal.Width)

subset(iris, Species=="setosa")
subset(iris, Species %in% c("setosa", "virginica") &
         Sepal.Width < 2.4)

LSpecies <- split(iris, iris$Species)

str(LSpecies)

LSpecies[2]

class(LSpecies[[1]])

df_a <- as.data.frame(iris[which(iris$Sepal.Width<2.4),])
df_b <- iris[which(iris$Petal.Width==1),]

nrow(df_a)
nrow(df_b)

df_c <- merge(df_a, df_b)
nrow(df_c)

df_c <- merge(df_a, df_b, by = c("Sepal.Width", "Sepal.Length"))
nrow(df_c)

df_c <- merge(df_a, df_b, all=T)

merge(df_a, df_b, by = c("Sepal.Width"), all.y = T)
