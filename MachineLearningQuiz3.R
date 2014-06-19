library(AppliedPredictiveModeling)
data(segmentationOriginal)
library(caret)
#inTrain<-createDataPartition(y=segmentationOriginal$Class,p=0.7,list=FALSE)
training=segmentationOriginal[segmentationOriginal$Case=='Train',]
testing=segmentationOriginal[segmentationOriginal$Case=="Test",]
dim(training)
dim(testing)
set.seed(125)
modfit<-train(Class~.,  method="rpart", data=training)
print(modfit$finalModel)
plot(modfit$finalModel,uniform=TRUE)
text(modfit$finalModel,use.n=TRUE,all=TRUE,cex=1)
predict(modfit,newdata=testing)


library(pgmm)
data(olive)
olive = olive[,-1]
