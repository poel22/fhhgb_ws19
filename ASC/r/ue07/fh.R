setwd("./git/fhhgb_ws19/0_ASC/r/ue07")
source("./packages")

bioethik = fread("./Bioethik.csv")
glimpse(bioethik)
bioethik = na.omit(bioethik[,1:35])

library("psych")
library("REdaS")
be = bioethik[,11:length(bioethik)]

# "ob das Ganze sinnvoll ist"
# Kaiser-Mayer-Olkin-Kriterium soll größer 0.5 sein
KMOS(be)
# Bartlett Test auf Sphärizität p < 0.05
bart_spher(be)
VSS.scree(be)

# PCA
pca.be = principal(be, 4, rotate = "varimax")
dev.new()
fa.diagram(pca.be, cut = 0.5, sort = T, digits = 2)
be$Med_TestMensch
be$Med_TestMensch = be$Med_TestTier*(-1) + 6
be$Suizid_verboten= be$Suizid_verboten*(-1) + 6
be$Leben_Schutz = be$Leben_Schutz*(-1) + 6
head(pca.be$scores)
be.scores = data.frame(pca.be$scores)
names(be.scores) = c("Leben", "Zeugung", "Tierversuche", "Aussehen")

# Cronbachs Alpha 0.6 < x < 0.95
alpha(be[,c("Eizellenspende", "Samenspende", "Abort_erlaubt", "PID_krankeEltern")], check.keys = T)

# Auswertung
bioethik$Zeugung = rowMeans(be[,c("Eizellenspende", "Samenspende", "Abort_erlaubt", "PID_krankeEltern")])
bioethik$Zeugung

boxplot(Zeugung~Atheist, data = bioethik, xlab = "Theist")
axis(side = 1, at = c(1, 2), labels = c("nein", "ja"))
