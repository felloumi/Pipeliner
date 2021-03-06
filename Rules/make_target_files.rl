rule make_target_files:
    input: expand("{s}.R1.trimmed.fastq.gz", s=samples)
    output: targets=config['project']['workpath']+"/exome_targets.bed",
            cnvkittargets=config['project']['workpath']+"/cnvkit_targets.bed",
            cnvkitantitargets=config['project']['workpath']+"/cnvkit_antitargets.bed"
    params: bed=config['project']['targetspath'],access=config['references'][pfamily]['CNVKITACCESS'],rname="pl:targets"
    shell: "perl Scripts/reformat_bed.pl {params.bed}; module load cnvkit/0.8; cnvkit.py target --split --short-names -o {output.cnvkittargets} {params.bed}; cnvkit.py antitarget -o {output.cnvkitantitargets} -g {params.access} {params.bed}"