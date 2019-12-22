## ----echo=F--------------------------------------------------------------
library(data.table)
library(plyr)
library(dplyr)
library(tidyr)
library(ggplot2)

## ------------------------------------------------------------------------
dmarketing = data.table(read.csv("./Marketing.csv", sep = ";"))
head(dmarketing)


## ------------------------------------------------------------------------
dmarketingEncoded <- mutate(dmarketing,
  Size = ifelse(MarketSize > 500, "Supermarkt",
                ifelse(MarketSize <= 301, "Geschaeft", "Markt")))
head(dmarketingEncoded)

## ------------------------------------------------------------------------
dSize = dmarketingEncoded %>% group_by(Size) %>% summarize(
  nr = length(LocationID)
)
dSize

## ------------------------------------------------------------------------
dmarketingEncoded %>% group_by(Promotion) %>% summarize(
  nr = length(LocationID)
)


## ------------------------------------------------------------------------
ggplot(dmarketingEncoded, aes(x=Size, fill=Size)) + geom_histogram(position = "dodge",stat = "count")

## ------------------------------------------------------------------------
ggplot(dmarketingEncoded, aes(x=Promotion), fill=Psdfromotion) + geom_histogram(position = "dodge",stat = "count")


## ------------------------------------------------------------------------
dmarketingByLoc = data.table(dmarketingEncoded %>% group_by(LocationID))

calculateSales = function (data, wstart, wend) {
  currentCompany = 0
  dLength = length(data$LocationID)
  data[, Diff := 0]
  index = 4 * currentCompany + 1
  while (index < dLength) {
    index = currentCompany * 4 + 1
    for (week in wstart:wend) {
      index = index + 1
      data[index]$Diff = data[index,]$Sales - data[index - 1,]$Sales
    }
    currentCompany = currentCompany + 1
  }
  data
}
dmarketingDiff = calculateSales(dmarketingByLoc, 2, 4)


## ------------------------------------------------------------------------
msw1 = colMeans(dmarketingByLoc %>% filter(Week == 1) %>% select(Sales))
msw1


## ------------------------------------------------------------------------
sdsw1 = dmarketingByLoc %>% filter(Week == 1) %>% summarize(SD = sd(Sales))

paste(c(round(msw1), " +- ", round(sdsw1)), collapse = '')


## ------------------------------------------------------------------------
msw4 = colMeans(dmarketingByLoc %>% filter(Week == 4) %>% select(Sales))
sdsw4 = dmarketingByLoc %>% filter(Week == 4) %>% summarize(SD = sd(Sales))

paste(c(round(msw4), " +- ", round(sdsw4)), collapse = '')


## ------------------------------------------------------------------------
statw1 = dmarketingByLoc %>% filter(Week == 1) %>% summarize(Median = median(Sales), IQR = IQR(Sales), range = paste(range(Sales), collapse = ' - '))
statw1


## ------------------------------------------------------------------------
mwnum = colMeans(dmarketingByLoc %>% select_if(is.numeric))
mwnum


## ------------------------------------------------------------------------
statgsize = dmarketingByLoc %>% group_by(Size) %>% summarize(Mean = mean(Sales))
statgsize


## ------------------------------------------------------------------------
bySize = dmarketingDiff %>% group_by(Size)

ei = data.table(W1 = bySize %>% filter(Week == 1) %>% summarize(Sales = mean(Sales)),
                W1 = (bySize %>% filter(Week == 2) %>% summarize(Diff = mean(Diff)))[,2],
                W4 = (bySize %>% filter(Week == 4) %>% summarize(Diff = mean(Diff)))[,2])
ei


## ------------------------------------------------------------------------
byPromo = dmarketingDiff %>% group_by(Promotion)

eii = data.table(W1 = byPromo %>% filter(Week == 1) %>% summarize(Sales = mean(Sales)),
                W1 = (byPromo %>% filter(Week == 2) %>% summarize(Diff = mean(Diff)))[,2],
                W4 = (byPromo %>% filter(Week == 4) %>% summarize(Diff = mean(Diff)))[,2])
eii


## ------------------------------------------------------------------------
byPromoAndSize = dmarketingDiff %>% group_by(Promotion, Size)

eiii = data.table(W1 = byPromoAndSize %>% filter(Week == 1) %>% summarize(Sales = mean(Sales)),
                W1 = (byPromoAndSize %>% filter(Week == 2) %>% summarize(Diff = mean(Diff)))[,3],
                W4 = (byPromoAndSize %>% filter(Week == 4) %>% summarize(Diff = mean(Diff)))[,3])
eiii


## ------------------------------------------------------------------------
t.test(ei[,2:4], eii[,2:4])

