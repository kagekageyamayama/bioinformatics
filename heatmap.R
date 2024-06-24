getwd()
d1<-read.csv('Trial_matrix.csv')
is.na(d1)
typeof(d1)
#sapply(d1, is.nan)
#sapply(d1,(!is.nan))#doesnt work
d2<-d1[2:36]
#heatmap(d1[2:36])
#sapply(d1, mode)
#summary(d1)
is.matrix(d2)
d3<-as.matrix(d2)
is.matrix(d3)
#heatmap(d3)
is.nan(d3)
is.numeric(d3)
d4<-as.matrix(d1)
#is.matrix(d4)
#heatmap(d4)#cant do since not numeric becuz 1st column
#heatmap(d4[,2:36])#doesnt work since when d4 was turned into a matrix, which is supposed to have values of same type it turned all values into string
row_names<-d4[1:412]
row.names(d3)<-row_names#since d3 had rownames as 1,2..., this assigns the cell values as the row name now
heatmap(d3,scale ="row",main ='h1',col = rainbow(720),xlab = 'cell type',ylab = 'cell dim')
heatmap(d3,scale = 'column',main ='h2')
