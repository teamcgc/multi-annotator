"#!/bin/bash \n\
PATH=$PATH:/opt/vt \n\
vt decompose -s " + $job.inputs.vcf.path + " | vt normalize -r " + $job.inputs.reference_fasta.path + " > input_VTnorma.vcf \n\
vt sort input_VTnorma.vcf -o input_VTnorma_Sorted.vcf \n\
java -Xmx4g -jar /opt/snpEff/snpEff.jar GRCh37.75 input_VTnorma_Sorted.vcf > input_VTnorma_Sorted_SnpEff.vcf \n\
# /opt/vcfanno/vcfanno -lua example/custom.lua " + $job.inputs.conf_toml.path + " input_VTnorma_Sorted_SnpEff.vcf > input_VTnorma_Sorted_SnpEff_vcfAnnoOUT.vcf"
