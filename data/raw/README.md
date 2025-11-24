# Place your raw FASTQ files here

This directory should contain paired-end Illumina sequencing files with the following naming convention:
- Forward reads: `SampleName_R1_001.fastq` or `SampleName_R1_001.fastq.gz`
- Reverse reads: `SampleName_R2_001.fastq` or `SampleName_R2_001.fastq.gz`

Example:
```
Sample1_R1_001.fastq.gz
Sample1_R2_001.fastq.gz
Sample2_R1_001.fastq.gz
Sample2_R2_001.fastq.gz
```

Large FASTQ files are excluded from version control via .gitignore.
