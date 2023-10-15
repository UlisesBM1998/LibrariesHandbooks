data = read.csv("Churn.csv", sep = ";", na.strings = "", stringsAsFactors =  T)
head(data)

colnames(data) = c("Id","Score","Estado","Genero","Idade","Patrimonio",
                   "Saldo", "Produtos","TemCartCredito", "Ativo",
                   "Salario", "Saiu")
head(data)

counts = table(data$Estado)
barplot(counts, main = "Ri", xlab = "Estados")

summary(data$Score)
boxplot(data$Score)  
hist(data$Score)

data[!complete.cases(data),] #Lineas que estan comppletas

summary(data$Salario)
data[is.na(data$Salario),]$Salario = median(data$Salario, na.rm=T)
data$Salario

###################
data[is.na(data$Genero)  | data$Genero == "M",]$Genero = "Masculino"
data[data$Genero == "F"  | data$Genero == "Fem",]$Genero = "Femenino"
data$Genero = factor(data$Genero)
unique(data$Genero)

######################

hist(trees$Height, main= "titulo", ylab ="Frecuencia", xlab = "Altura", col = "blue",
     density = 20, breaks = 20)

plot(density(trees$Height))

hist(trees$Height, main= "titulo", ylab ="Frecuencia", xlab = "Altura", col = "blue", breaks = 20)
par(new=T)
plot(density(trees$Height))

plot(trees$Girth, trees$Volume, ylab = "Y", xlab = "X", col = "red", main = "Titulos",
     pch = 20)

plot(CO2$conc, CO2$uptake, pch = 20, col = CO2$Treatment)
legend("bottomright", legend = c("nonchilled", "chilled"), cex = 1, fill = c("black", "red"))

plot(trees)

split.screen(figs=c(2,2))
screen(1)
plot(trees$Girth, trees$Volume)
screen(2)
plot(trees$Girth, trees$Height)
screen(3)
plot(trees$Height, trees$Volume)
screen(4)
hist(trees$Volume)
close.screen(all=T)

boxplot(trees$Volume, main = "Aboles", xlab = "Volume", col = "blue", horizontal = T, outline = F, notch = T)

boxplot.stats(trees$Height)
boxplot.stats(trees$Height)$stats

boxplot(trees)

spray = aggregate(.~spray, data = InsectSprays, sum)
box()

pie(spray$count, labels = spray$spray, main="Spray", col = c(1:6))
legend("bottomright", legend=spray$spray, cex =1, fill=c(1:6))

#Tables
install.packages("stargazer")
library(stargazer)

stargazer(iris, type = "text")
stargazer(women, out="women.tex", type="text", summary = F)

#Lattice
install.packages("lattice")
library(lattice)

bwplot(trees$Volume, main = "Arboles", xlab = "Volumne")

histogram(trees$Volume, main = "Arboles", xlab ="Volumne", aspect = 1,
          type ="percent", nint = 20)
aggregate(chickwts$weight, by = list(chickwts$feed), FUN = sum)
histogram(~weight  | feed, data = chickwts)

xyplot(CO2$conc~CO2$uptake | CO2$Type) 

dotplot(esoph$alcgp ~ esoph$ncontrols, data = esoph)
dotplot(esoph$alcgp ~ esoph$ncontrols | esoph$tobgp)

splom(~CO2[4:5]| CO2$Type, CO2)

densityplot(~CO2$conc | CO2$Treatment, plot.points=T )

cloud(decrease ~ rowpos * colpos, data =OrchardSprays)
cloud(decrease ~ rowpos * colpos, groups = treatment, data =OrchardSprays)

levelplot(Girth   ~  Height * Volume, data =trees)