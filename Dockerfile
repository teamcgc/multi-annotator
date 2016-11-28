
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
ENV PATH "$PATH:/opt/vt"
RUN echo "[vt]" > /opt/versions
RUN vt --version >> /opt/versions 2>&1

#install snpeff
RUN wget http://sourceforge.net/projects/snpeff/files/snpEff_latest_core.zip
RUN unzip snpEff_latest_core.zip
ENV SNPEFF_JAR "/opt/snpEff/snpEff.jar"
ENV SNPSIFT_JAR "/opt/snpEff/SnpSift.jar"
RUN echo "[snpEff]" >> /opt/versions
RUN java -jar $SNPEFF_JAR -version >> /opt/versions
RUN echo "[snpSift]" >> /opt/versions
RUN java -jar $SNPSIFT_JAR 2>&1 | grep "SnpSift version" >> /opt/versions

#install vcfanno
RUN wget https://github.com/brentp/vcfanno/releases/download/v0.1.0/vcfanno_linux64
RUN chmod a+x vcfanno_linux64
RUN ln -s vcfanno_linux64 vcfanno
ENV PATH "$PATH:/opt"
RUN echo "[vcfanno]" >> /opt/versions
RUN vcfanno 2>&1 | grep "version" >> /opt/versions
