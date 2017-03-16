#!/bin/bash

#Este script sigue el ejemplo de http://biocontainers.pro/docs/101/running-example/ para correr blast bajo docker en mi computadora. 

#Este script asume que ya existe la imagen de blast en el equipo y no muestra el menú de ayuda de blast

#Crear una variable para la ruta del directorio de datos
datosejemplo2=/home/nidia/Escritorio/Blastp2

#Crear el directorio para guardar lor archivos generados por este ejemplo
mkdir $datosejemplo2

#Descargar la secuencia en formato FASTA de un prión humano desde UniProt
wget http://www.uniprot.org/uniprot/P04156.fasta 
mv P04156.fasta $datosejemplo2

#Descargar la base de datos del zebrafish de NCBI

curl -O ftp://ftp.ncbi.nih.gov/refseq/D_rerio/mRNA_Prot/zebrafish.1.protein.faa.gz  
mv zebrafish.1.protein.faa.gz $datosejemplo2
gunzip $datosejemplo2/zebrafish.1.protein.faa.gz

#Preparar la base de datos de zebrafish con "makeblastdb" desde el contenedor, montando en éste el directorio de datos
sudo docker run -v $datosejemplo2:/data/ biocontainers/blast makeblastdb -in zebrafish.1.protein.faa -dbtype prot

#Conseguir los alineamientos finales
sudo docker run -v $datosejemplo2:/data/ biocontainers/blast blastp -query P04156.fasta -db zebrafish.1.protein.faa -out results.txt

#Imprimir los resultados en pantalla
cat $datosejemplo2/results.txt


