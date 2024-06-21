library(airway)
library(DESeq2)
library(tidyverse)
#retreive the data into csv
data(airway)
airway

sample_info <- as.data.frame(colData(airway))
head(sample_info)
sample_info <- sample_info[,c(2,3)]
head(sample_info)
#sample_info <-gsub('trt', 'treated', sample_info)
sample_info$dex <-gsub('trt', 'treated', sample_info$dex)
head(sample_info)
names(sample_info) <-c('cellLine', 'dexamethasone')
write.table(sample_info, file = "sample_info.csv", sep = ',', col.names = T, row.names = T, quote = F)

countsData <- assay(airway)
write.table(countsData, file = "counts_data.csv", sep = ',', col.names = T, row.names = T, quote = F)
#deseq2 starts from here
head(countsData)
all(colnames(countsData)%in%rownames(sample_info)) #ensure column in countsdata is same as row names in sample_info
all(colnames(countsData)==rownames(sample_info))#ensures that the order is same too
#creating deseq data frame
dds<-DESeqDataSetFromMatrix(countData = countsData, colData = sample_info, design = ~dexamethasone)
dds
keep<-rowSums(counts(dds))>=10
keep
dds<-dds[keep,]
dds
#we want to compare btw treated and untreated, so we have 2 'levels'. we will tell deseq to take untreated as ref level
dds$dexamethasome<-relevel(dds$dexamethasone, ref = 'untreated')
#run deseq
dds<-DESeq(dds)
res<-results(dds)
res
summary(res)
#adjusted p value threshold can be changed
res0.01<-results(dds,alpha=0.01)
res0.01
summary(res0.01)
resultsNames(dds)#gives info about comparision made
plotMA(res0.01)
