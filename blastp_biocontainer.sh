#!/bin/bash

#Este script sigue el ejemplo de http://biocontainers.pro/docs/101/running-example/ para correr blast bajo docker en mi computadora. 

#Crear una variable para la ruta del directorio de datos
datosejemplo=/home/nidia/Escritorio/Blastp

#Crear el directorio para guardar lor archivos generados por este ejemplo y entrar en él
mkdir $datosejemplo
cd $datosejemplo

#Conseguir la imagen de blast desde Biocontainers
sudo docker pull biocontainers/blast

#Imprimir el menú de ayuda de la herramienta blastp
sudo docker run biocontainers/blast blastp -help

#Descargar la secuencia en formato FASTA de un prión humano desde UniProt
wget http://www.uniprot.org/uniprot/P04156.fasta

#Descargar la base de datos del zebrafish de NCBI

curl -O ftp://ftp.ncbi.nih.gov/refseq/D_rerio/mRNA_Prot/zebrafish.1.protein.faa.gz
gunzip zebrafish.1.protein.faa.gz

#Preparar la base de datos de zebrafish con "makeblastdb" desde el contenedor, montando en éste el directorio de datos
sudo docker run -v $datosejemplo:/data/ biocontainers/blast makeblastdb -in zebrafish.1.protein.faa -dbtype prot

#Conseguir los alineamientos finales
sudo docker run -v $datosejemplo:/data/ biocontainers/blast blastp -query P04156.fasta -db zebrafish.1.protein.faa -out results.txt

#Imprimir los resultados en pantalla
cat results.txt

#Salir del directorio
cd ../..

