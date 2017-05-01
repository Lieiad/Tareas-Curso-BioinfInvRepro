##Este script responde la primera pregunta de la tarea sobre R.
#Limpiar variables y funciones de la memoria para la sesión actual
rm(list=ls())

#Cargar en una df llamada fullmat el archivo "maizteocintle_SNP50k_meta_extended.txt"
fullmat<-read.delim("../meta/maizteocintle_SNP50k_meta_extended.txt", header = TRUE, sep = "\t")

#Qué tipo de objeto se creó al cargar la base
class(fullmat)

#Ver las primeras 6 líneas del archivo
head(fullmat,n=6)

#Cuántas muestras hay
nrow(fullmat)

#De cuántos estados se tiene muestras
estados=levels(fullmat$Estado)
as.data.frame(estados)

#Cuántas muestras fueron colectadas antes de 1980
y<-fullmat[[10]]
x<-y<1980
sum(x, na.rm=TRUE)

#Cuántas muestras hay de cada raza
attach(fullmat)
table(Raza)

#En promedio, a qué altitud fueron colectadas las muestras
alt=fullmat$Altitud
mean(alt)

#A qué altitud máxima y mínima fueron colectadas
max(alt)
min(alt)

#Crear una nueva df de datos sólo con las muestras de la raza Clotillo
dfOlotillo<-fullmat[fullmat$Raza == "Olotillo",]
dfOlotillo

#Crear una nueva df de datos sólo 
#con las muestras de la raza Reventador, Jala y Ancho
dfnueva=fullmat[fullmat$Raza == "Reventador" | Raza == "Jala" | Raza == "Ancho" ,]
#Otra opción para lo anterior
dfnueva=subset(fullmat, Raza == "Reventador" | Raza == "Jala" | Raza == "Ancho")
dfnueva

#Ordenar por orden alfabético del nombre de la Raza
dfnuevaor= dfnueva[order(dfnueva$Raza),]
dfnuevaor

#Escribir la matriz anterior a un archivo llamado "submat.cvs" en /meta
write.csv(dfnuevaor, file="../meta/submat.cvs")
