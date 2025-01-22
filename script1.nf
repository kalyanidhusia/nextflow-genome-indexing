params.ref="/Users/dhusiakalyani/nextflowGenomeIndex/ref/Agy99.fasta"


process index {

input: 
 path genome

script:
"""
bwa index $genome

"""

}

workflow {

ref_ch=Channel.fromPath(params.ref)

index(ref_ch)

}
