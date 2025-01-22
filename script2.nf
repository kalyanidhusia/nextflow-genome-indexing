params.ref="/Users/dhusiakalyani/nextflowGenomeIndex/ref/Agy99.fasta"
params.index_dir="/Users/dhusiakalyani/nextflowGenomeIndex/index_dir/"

process index {

publishDir("${params.index_dir}", mode: 'copy')

input: 
 path genome

output:
 path "*"

script:
"""
# Print the path of the index directory for debugging purposes
echo "Index files will be saved to: ${params.index_dir}"

# Run bwa index
bwa index $genome

"""

}

workflow {

ref_ch=Channel.fromPath(params.ref)

index(ref_ch)

}
