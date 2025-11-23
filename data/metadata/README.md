# Sample metadata files

Place your sample metadata CSV file here with the name `sample_metadata.csv`.

The metadata file should:
- Have sample IDs in the first column (matching your FASTQ file names)
- Include relevant experimental variables (treatment groups, timepoints, etc.)
- Use comma-separated values (CSV) format

Example structure:
```csv
SampleID,Group,Treatment,Timepoint
Sample1,Control,None,T0
Sample2,Treated,DrugA,T0
```

The sample metadata provided (`sample_metadata.csv`) is an example template.
