params.ref="/Users/dhusiakalyani/nextflowGenomeIndex/ref/Agy99.fasta"
params.index_dir="/Users/dhusiakalyani/nextflowGenomeIndex/index_dir"

process index {

    publishDir("${params.index_dir}", mode: 'copy')

    input: 
    path genome

    output:
    // Save all index files generated by bwa and samtools to index_dir
    path "*" , emit: all_indices

    script:
    """
    # Print the path of the index directory for debugging purposes
    echo "Index files will be saved to: ${params.index_dir}"

    # Run bwa index
    bwa index $genome

    # Run samtools faidx
    samtools faidx $genome

    # Copy the FASTA file itself to the specified directory
    cp $genome ${params.index_dir}/

    """
}

workflow {

    ref_ch = Channel.fromPath(params.ref)

    index(ref_ch)

    // To print the paths for all index files
    index.out.all_indices.view()
}
