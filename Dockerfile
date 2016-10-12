
FROM ubuntu:14.04

MAINTAINER Durga Addepalli <durgaddepalli@gmail.com>

LABEL Description="This image is used for running TeamCGC Annotation Pipeline"

WORKDIR /opt

RUN apt-get update && apt-get install -y \
        wget \
        unzip \
        build-essential \
        apt-utils --yes --force-yes \
        zlib1g-dev \
        libncurses5-dev \
        git \
        default-jre \
        default-jdk

#install vt
RUN git clone https://github.com/atks/vt.git && \
        cd vt; make && \
        make test

#install snpeff
RUN wget http://sourceforge.net/projects/snpeff/files/snpEff_latest_core.zip
RUN unzip snpEff_latest_core.zip

#install vcfanno
RUN wget https://github.com/brentp/vcfanno/releases/download/v0.1.0/vcfanno_linux64

RUN chmod a+x vcfanno_linux64

