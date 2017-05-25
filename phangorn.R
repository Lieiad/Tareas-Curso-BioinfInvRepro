##Script para construir un arbol de parsimonia 
#con la matriz concatenada ITS+ndhF-rpl32 de Antiphytum (Boraginaceae)
#usando el paquete Phangorn de R en CRAN

#Cargar librerías
library("diversitree")


#Cargar datos
conc <- read.phyDat("combinada.nex", format = "nexus")

#Reconstruir un árbol usando Ratchet
treeR <- pratchet(conc, trace = 0) 

#Contar el número de pasos
parsimony(treeR, conc) 

#Enraizar el árbol con Echium vulgare
treeR=root(treeR, outgroup = 1)

#Obtener indice de consistencia (CI) y retencion (RI)
x=CI(treeR, conc)
y=RI(treeR, conc)
ind=numeric(0)
ind=rbind(c(round(x,2),y))
colnames(ind)=c("CI", "RI")
rownames(ind)="Índices"
ind

#Observar el árbol
par(mar = c(0,0,0.8,0))
plot(treeR, main="Árbol de parsimonia", cex=0.6)


#Asignar longitud de ramas y nodos internos al árbol con ACCTRAN
treeR=acctran(treeR,conc)
par(mar = c(0,0,0.8,0))
plot(treeR, main="Árbol de parsimonia", cex=0.6)

?title
#Calcular estados ancestrales
anc.acctran = ancestral.pars(treeR, conc, "ACCTRAN")

anc.mpr= ancestral.pars(treeR, conc, "ACCTRAN")

#Graficar estados ancestrales
plotAnc(treeR, anc.mpr, 17, cex.pie = 0.2, cex=0.6)
title("MPR")
plotAnc(treeR, anc.acctran, 17, cex.pie = 0.2, cex=0.6)
title("ACCTRAN")

