params.ref = "/Users/dhusiakalyani/nextflowGenomeIndex/ref/Agy99.fasta"

process index {

    input:
    path genome

    output:
    path "$genome.index"  // This will track the index files created by bwa index

    script:
    """
    # Get the directory of the input genome file
    genome_dir=\$(dirname $genome)

    # Run bwa index and specify the output directory to be the same as the input file's directory
    bwa index -p \$genome_dir/\$(basename \$genome .fasta) $genome
    """

    // Publish the output files to the directory of the input genome file
    publishDir "$genome_dir", mode: 'copy'
}

workflow {
    ref_ch = Channel.fromPath(params.ref)

    index(ref_ch)
}

