#!/usr/bin/env Rscript

#get the rdata file
args = commandArgs(trailingOnly=TRUE)
rdata<-load(args[1])
rdata<-get(rdata)
sum<-summary(rdata) 

#get the selected attributes to explore
attributes_selected <- commandArgs(trailingOnly=TRUE)[2]

attributes<-strsplit(attributes_selected, ",")
len<-length(attributes[[1]])

write.table(sum,file = "output.tsv")

for (i in 1:len){
	attribute<-attributes[[1]][i]
	file<-paste(attributes[[1]][i],".tsv",sep="")

    attribute_val<-eval(parse(text=paste("rdata$",attribute,sep="")))

	if(is.null(attribute_val)){
		write.table("Return NULL value",file = file)
		next
	}

    if (typeof(attribute_val)=="list") {
        attribute_val<-as.data.frame(do.call(rbind, attribute_val))
    }else if ( typeof(attribute_val)=="language") {
        attribute_val<-toString(attribute_val,width = NULL)
        write.table(attribute_val,file = file)
        next
    }
    write.table(attribute_val,file = file)

}
