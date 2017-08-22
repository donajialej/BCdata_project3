
module GenomeReader

# dictionary keys are chromosomes, e.g. "CHR_TO_SEQ["chr1"]"
# returns DNA sequence of chromosome 1
export CHR_TO_SEQ

using Bio.Seq

# where are your FASTA files containing the DNA sequence of the human genome (hg38)
const PATH_TO_HG38 = homedir() * "/hg38.analysisSet/"
println("Assumes HG38 genome is present in: ", PATH_TO_HG38)

# list of chromosomes
const CHRS = ["chr1", "chr10", "chr11", "chr12", "chr13", "chr14", "chr15", "chr16", "chr17", "chr18", "chr19", "chr2", "chr20", "chr21", "chr22", "chr3", "chr4", "chr5", "chr6", "chr7", "chr8", "chr9", "chrM", "chrX", "chrY"]

# for short, define DNAseq type for DNA sequences.
const DNASeq = BioSequence{DNAAlphabet{4}}

"""
Build a dictionary `chr_to_seq` such that, give it a chromosome, it return a sequence.
 e.g. chr_to_seq["chr1"] gives DNA sequence of chr1.
"""
function get_chr_to_seq()
    chr_to_seq = Dict{String, DNASeq}()

    # loop over chromosomes, store sequence.
    for chr in CHRS
        record = first(open(FASTAReader, PATH_TO_HG38 * chr * ".fa"))
        chr_to_seq[chr] = record.seq
    end
    return chr_to_seq
end

const CHR_TO_SEQ = get_chr_to_seq()

end
