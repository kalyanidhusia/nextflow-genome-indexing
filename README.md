# nextflow-genome-indexing
This repository contains a Nextflow pipeline designed to practice genome indexing in same folder.

### Description:
We want the `bwa index` command in the Nextflow pipeline to generate index files in the same folder as the input `.fasta` file. However, the index files are being generated in the default `work/` directory instead of the desired directory.

### Steps to Reproduce:
1. Run the Nextflow pipeline with the input genome file located at `/Users/dhusiakalyani/nextflowGenomeIndex/ref/Agy99.fasta`.
2. Observe that the generated index files (`.bwt`, `.pac`, etc.) are placed in the `work/` directory, not in the same directory as the `.fasta` file.

### Expected Behavior:
The `bwa index` command should create the index files in the same directory as the input `.fasta` file (`/Users/dhusiakalyani/nextflowGenomeIndex/ref/`).

### Actual Behavior:
The index files are being generated in the `work/` directory instead of the intended directory.

###

### Explanation of Fix:

### Path Setup:
- **`params.ref`**: This is the path to the input genome file (`Agy99.fasta`).
- **`params.index_dir`**: This specifies the folder where the index files should be saved (e.g., `/Users/dhusiakalyani/nextflowGenomeIndex/index_dir/`).

### Added Print Statement:
- A print statement (`echo "Index files will be saved to: ${params.index_dir}"`) was added to the script block. This will print the path of the index folder when the process runs, providing additional visibility into where the files are being saved.

### `bwa index`:
- This command generates the index files for the reference genome, which will be placed in the directory specified by `publishDir`.

### Expected Outcome:
After running the pipeline, the index files (such as `.bwt`, `.pac`, `.ann`, `.sa`) should now be placed in the `index_dir` folder, ensuring that they are organized and accessible for downstream analysis.

We can then just change the `params.index_dir` to ref folder and all will be saved in one folder.

### Updates to Indexing Process

1. **BWA Index and SAMtools faidx Integration**: The pipeline now runs both `bwa index` and `samtools faidx` on the input FASTA file to generate all necessary index files.
2. **Centralized File Management**: All generated index files (`.ann`, `.bwt`, `.pac`, `.sa`, `.fai`, etc.) and the original FASTA file are saved in a single directory specified by `params.index_dir`.
3. **Improved Workflow**: The script automatically moves all relevant files to the specified directory for streamlined organization and easier downstream access.


