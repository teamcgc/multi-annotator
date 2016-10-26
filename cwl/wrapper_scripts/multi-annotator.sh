{
if($job.inputs.custom_lua!=null){lua = $job.inputs.custom_lua.path + " "}else{lua=""}

script = "#!/bin/bash \n\
PATH=$PATH:/opt/vt \n\
vt decompose -s -o decomposed.vcf " + $job.inputs.vcf.path + "\n\
vt normalize -o normalized.vcf -r " + $job.inputs.reference_fasta.path + " decomposed.vcf \n\
vt sort -o sorted.vcf normalized.vcf \n\
java -Xmx4g -jar /opt/snpEff/snpEff.jar GRCh37.75 sorted.vcf > snp_eff.vcf \n\
/opt/vcfanno_linux64 " + lua + $job.inputs.conf_toml.path + " snp_eff.vcf > " + $job.inputs.vcf.metadata.sample_id + "_annotated.vcf"

return script
}
