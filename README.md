# SarsMutSignature
This repository contains data for the analysis of SARS2 mutation signature.  
## Summary
The before-outbreak evolutionary history of SARS-CoV-2 is enigmatic because it shares only ∼96% genomic similarity with RaTG13, the closest relative so far found in wild animals (horseshoe bats). Since mutations on single-stranded viral RNA are heavily shaped by host factors, the viral mutation signatures can in turn inform the host. By comparing publically available viral genomes we here inferred the mutations SARS-CoV-2 accumulated before the outbreak and after the split from RaTG13. We found the mutation spectrum of SARS-CoV-2, which measures the relative rates of 12 mutation types, is 99.9% identical to that of RaTG13. It is also similar to that of two other bat coronaviruses but distinct from that evolved in non-bat hosts. The viral mutation spectrum informed the activities of a variety of mutation-associated host factors, which were found almost identical between SARS-CoV-2 and RaTG13, a pattern difficult to create in laboratory. All the findings are robust after replacing RaTG13 with RshSTT182, another coronavirus found in horseshoe bats with ∼93% similarity to SARS-CoV-2. Our analyses suggest SARS-CoV-2 shared almost the same host environment with RaTG13 and RshSTT182 before the outbreak.
## Content
* __Fasta__:  
CDS sequences of eight species.  
* __CodonAlignment__:  
Codon alignments used in this analysis. Nucleotide sequences were translated into amino acid with seqkit and aligned with MAFFT.  
* __iqtree__:  
Phylogenetic trees constructed with iqtree. Ancestral states were inferred with _-asr_ parameter.  
* __Scripts__:  
Customized R-based tools for further analysis.  
## Reference
Mutation signatures inform the natural host of SARS-CoV-2. doi: https://www.biorxiv.org/content/10.1101/2021.07.05.451089v1
