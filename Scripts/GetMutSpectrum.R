#### 
#### Created by Shadow Deng on Fri 11 Jun 2021 11:07:34 PM HKT
#### 

library(tidyverse)
# library(seqinr)
# library(phytools)

args <- commandArgs(T)
File_Align <- args[1]
File_Tree <- args[2]
Var_Outgroup <- args[3]
File_State <- args[4]
Output <- args[5]

tmp.msa <- seqinr::read.fasta(File_Align)
names(tmp.msa) <- tmp.msa %>% names %>% paste0(.,"|")
tmp.tip <- 
tmp.msa %>% unlist %>% as.data.frame %>% rename(Base='.') %>% 
rownames_to_column("AAA") %>% 
separate(AAA,c("Tip","Site"),"\\|") %>% 
mutate(Site=Site %>% as.numeric,Base=Base %>% toupper)

tmp.tree <- phytools::read.newick(File_Tree) %>% ape::root(Var_Outgroup) %>% ape::drop.tip(Var_Outgroup)

tmp.anc <- 
read.delim(File_State,comment.char = "#") %>% 
rename(Tip=Node,Base=State) %>% 
mutate(Base=toupper(Base)) %>% 
select(Tip,Site,Base)

tmp.edge <- 
tmp.tree$edge %>% as.data.frame %>% rename(From=V1,To=V2) %>% 
mutate(EdgeID=1:n()) %>% 
gather(GGG,VVV,-EdgeID) %>% 
arrange(EdgeID) %>% 
mutate(Tip=c(tmp.tree$tip.label,paste0("Node",1:tmp.tree$Nnode))[VVV]) %>% 
select(EdgeID,GGG,Tip)

tmp.Spectrum <- list()

for(iii in tmp.edge$EdgeID %>% unique){
    tmp.Spectrum[[iii]] <- 
    tmp.edge %>% 
    filter(EdgeID==iii) %>% 
    left_join(rbind(tmp.anc,tmp.tip)) %>% 
    select(GGG,Site,Base) %>% 
    spread(GGG,Base) %>% 
    filter(From!="-",To!="-") %>% 
    mutate(Codon=(Site-1)%%3+1) %>% 
    filter(Codon==3) %>% 
    group_by(From) %>% mutate(Count_Ref=n()) %>% 
    filter(From!=To) %>% 
    group_by(From,To,Count_Ref) %>% summarise(Count_Alt=n()) %>% 
    spread(To,Count_Alt,0) %>% 
    gather(To,Count_Alt,-From,-Count_Ref) %>% 
    filter(From!=To) %>% 
    unite(From,To,col="Mutation",sep=">") %>% 
    arrange(Mutation) %>% 
    group_by %>% mutate(MutRate=Count_Alt/Count_Ref) %>% 
    mutate(RelativeMutationRate=MutRate/sum(MutRate)) %>% 
    mutate(EdgeID=iii) %>% 
    select(EdgeID,Mutation,Count_Ref,Count_Alt,RelativeMutationRate)
}

tmp.edge %>% 
spread(GGG,Tip) %>% 
left_join(tmp.Spectrum %>% bind_rows) %>% 
write.table(Output,quote=F,row.names=F,sep="\t",col.names=T)