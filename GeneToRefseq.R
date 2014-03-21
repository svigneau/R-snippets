# This snippet queries BioMart to find mRNA Refseq Ids associated with gene symbols in mouse.

# Load biomaRt.
library(biomaRt)
# Get vector of gene symbols from a table loaded in R.
genes <- mytable$Gene
# Choose BioMart database and dataset.
mart <- useMart("ensembl", dataset="mmusculus_gene_ensembl")
# Specify filter used to read input values.
# A list of possible filters can be retrieved using listFilters.
filters=c("mgi_symbol")
# Specify attributes to be returned.
# A list of possible attributes can be retrieved using listAttributes.
attributes <- c("chromosome_name", "start_position", "end_position", "mgi_symbol", "refseq_mrna")
# Retrieve attributes for submitted genes.
mynewtable <- getBM(attributes=attributes, filters=filters, values=genes, mart=mart, uniqueRows=T)
