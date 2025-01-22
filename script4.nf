params.ref="/Users/dhusiakalyani/nextflowGenomeIndex/ref/Agy99.fasta"
params.index_dir="/Users/dhusiakalyani/nextflowGenomeIndex/index_dir"
// Added samtools faidx command to index the input FASTA file
// This creates the .fai index file or fasta.fai


process index {

    publishDir("${params.index_dir}", mode: 'copy')

    input: 
    path genome

    output:
    // To save index files (.ann and .fai) to index_dir
    path "${genome}.ann", emit: ref_genome
    path "${genome}.fai", emit: faidx_index

    script:
    """
    # Print the path of the index directory for debugging purposes
    echo "Index files will be saved to: ${params.index_dir}"

    # Run bwa index
    bwa index $genome

    # Run samtools faidx
    samtools faidx $genome
    """
}

workflow {

    ref_ch = Channel.fromPath(params.ref)

    index(ref_ch)
    // To print the paths for index files
    index.out.ref_genome.view()
    index.out.faidx_index.view()
}