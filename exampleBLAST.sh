#!/bin/bash

### This script is for install Blast with help of docker and BioContainers and do an example

# Go to the directory where you want to install Blast
cd /home/alots/Escritorio/BioinfRepo/Unidad5/ejemploBLAST/

# Do a "docker pull" to pull Blast 
docker pull biocontainers/blast

# Print the help page for blastp tool
docker run biocontainers/blast blastp -help

# Download the human prion sequence
wget http://www.uniprot.org/uniprot/P04156.fasta

# Download the zebrafish database from NCBI and unpack it
curl -O ftp://ftp.ncbi.nih.gov/refseq/D_rerio/mRNA_Prot/zebrafish.1.protein.faa.gz
gunzip zebrafish.1.protein.faa.gz

# Prepare the zebrafish database
docker run -v /home/alots/Escritorio/BioinfinvRepro/Unidad5/ejemploBLAST:/data/ biocontainers/blast makeblastdb -in zebrafish.1.protein.faa -dbtype prot
 
# Do final alignments, the results will be saved on the results.txt file
docker run -v /home/alots/Escritorio/BioinfinvRepro/Unidad5/ejemploBLAST:/data/ biocontainers/blast blastp -query P04156.fasta -db zebrafish.1.protein.faa -out results.txt
