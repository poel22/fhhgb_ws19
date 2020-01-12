# Preparation
library(gdata)
library(plyr)
library(dplyr)
library(data.table)
library(ggplot2)
library(scales)
setwd("./git/fhhgb_ws19/ASC/r/project/")
source = data.table(read.xls("./deposit.xlsx"))
head(source)

unique(source$job)
unique(source$marital)
unique(source$housing)
unique(source$loan)
unique(source$contact)
unique(source$month)
unique(source$day_of_week)
unique(source$campaign)
unique(source$pdays)
unique(source$previous)
unique(source$poutcome)
unique(source$emp.var.rate)
unique(source$cons.price.idx)
unique(source$cons.conf.idx)
unique(source$euribor3m)
unique(source$nr.employed)
unique(source$y)

source = droplevels(source %>% filter(source$loan != 'unknown'))

source %>% group_by(loan) %>% add_tally(name = "Count") %>%
  ggplot(., aes(x = loan, y = Count), fill = loan) +
  geom_bar(stat = "identity") +
  geom_text(aes(x = loan, y = Count, label = Count),
            position = position_dodge(width = 1),
            hjust = -1) + 
  scale_y_continuous(labels = comma) +
  coord_flip()

## Taking a look at Marital Status

pie(prop.table(table(source$loan)))

# Age distribution
hsAge = hist(source$age)

glimpse(source)

fsMarital = droplevels(source %>% filter(source$marital != 'unknown'))

barplot(prop.table(table(fsMarital$marital)))

fsJob = droplevels(source %>% filter(source$job != 'unknown'))

fsMarital$marital+loan

pie(prop.table(table(fsJob$job)))

unique(fsMarital$age)

ks.test(x = hsAge$counts, y = 'pnorm')

unique(fsMarital$nr.employed)

pie(prop.table(table(source$nr.employed)))

cSource = source %>% group_by(nr.employed) %>% add_count() %>% select(nr.employed, n) %>% plot_ly(sort = T, labels = source$nr.employed, values = "n") %>% add_pie()
