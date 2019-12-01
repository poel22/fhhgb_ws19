a1a = c(4:20)
a1b = c(20:4)
a1c = c(4:20, 19:4)

# a1d
temp <- c(5,3,9)

a1e <- rep(temp, times=10)
a1f <- rep(temp, times=11, length=31)
a1g <- c(rep(5, times=5), rep(3, times=3), rep(9, times=9))

x <- seq(3.0,6.0,0.5)
a1h_result <- c(exp(x) * sin(x))

x <- seq(3, 34, 3)
a2a <- c(2^x * 0.1^(x-2))

i <- c(10:25)
a2b <- c(i^2 + 5*i^3)

i <- c(1:10)
a2c <- c((2^i/i^3) + (i^2/3^i))

# a2d
set.seed(1)
xVec <- sample(1:100,100,replace=T)
i <- c(1:99)
sumX <- sum(c(exp(-xVec[i + 1])/xVec[i] + 2))

xVec[xVec > 90]
which(xVec > 90)
length(which(xVec > max(xVec) - 20))

xVec[seq(1, 100, 3)]

a3a <- matrix(ncol = 3, nrow = 3)
a3a[,1] = c(4, 12, 16)
a3a[,2] = c(10, 20, 10)
a3a[,3] = c(10, 5, 15)

colnames(a3a) <- c("Abt1", "Abt2", "Abt3")

a3b <- cbind(a3a, c(16, 63, 9))

a3c <- rowSums(a3b)

a3d <- a3c^-1 * diag(3) * a3a

a3e <- diag(3) - a3d

a3f <- a3e * a3c

a3f

a3g <- (diag(3) - a3d)^-1

a3h <- a3g * c(16,40,40)

a3h
