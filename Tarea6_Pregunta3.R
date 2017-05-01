#Escribe un loop de R para que sume 35 mas 1:10 y reste 35 menos 1:10, 
#imprimiendo ambos resultados en la consola

##Opción 1
for (i in 1:10){
  x<-(35+i)
  y<-(35-i)
  print (paste(x,y))
}

##Opción 2
result<-numeric(0)
for (i in 1:10){
  result <-rbind(result,c(35+i,35-i))
  result<-as.data.frame(result)
  colnames(result)<-c("35+1:10", "35-1:10")
}
result
