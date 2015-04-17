#!/bin/bash
 
# source globals
# source ./env.sh

# apt-get install $JDK -y
# cd ~$USER

git clone https://github.com/BenLangmead/crossbow.git



cd crossbow

# make soapsnp
make -C ./soapsnp

# back to home dir
cd ..

# download and install bowtie 1.1.1
wget  http://downloads.sourceforge.net/project/bowtie-bio/bowtie/1.1.1/bowtie-1.1.1-linux-x86_64.zip
unzip bowtie-1.1.1-linux-x86_64.zip

# download and install SRA toolkit
wget http://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/2.4.5-2/sratoolkit.2.4.5-2-ubuntu64.tar.gz
tar -zxvf sratoolkit.2.4.5-2-ubuntu64.tar.gz








