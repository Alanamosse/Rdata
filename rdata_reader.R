#!/usr/bin/env Rscript

args = commandArgs(trailingOnly=TRUE)
rda<-load(args[1])
rdata<-get(rda)
names<-names(rdata)
write(names, file = "rdata_list_attr")
