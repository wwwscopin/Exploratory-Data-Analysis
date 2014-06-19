library(ElemStatLearn)
data(vowel.train)
vowel.train$y<-as.factor(vowel.train$y)
data(vowel.test) 
vowel.test$y<-as.factor(vowel.test$y)
str(vowel.train)
set.seed(33833)

#library(randomForest)
library(caret)
mf1<-train(y~., data=vowel.train, method="rf")
pred_RF<-predict(mf1,vowel.test)


mf2<-train(y~., data=vowel.train, method="gbm")
pred_GBM<-predict(mf2,vowel.test)

accuracy_GBM = (vowel.test$y == pred_GBM);
accuracy_RF = (vowel.test$y == pred_RF);
accuracy = (vowel.test$y == pred_RF & vowel.test$y == pred_GBM);
accuracy_test = (pred_RF == pred_GBM);

length(accuracy_GBM[accuracy_GBM == TRUE]);
length(accuracy_RF[accuracy_RF == TRUE]);
length(accuracy[accuracy == TRUE]);
length(accuracy_test[accuracy_test == TRUE]);

length(accuracy_RF[accuracy_RF == TRUE]) / length(accuracy_RF);
length(accuracy_GBM[accuracy_GBM == TRUE]) / length(accuracy_GBM);
length(accuracy[accuracy == TRUE]) / length(accuracy);
length(accuracy[accuracy == TRUE]) / length(accuracy_test[accuracy_test == TRUE]);



set.seed(3433)
library(AppliedPredictiveModeling)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

set.seed(62433)
mf1<-train(diagnosis~., data=training, method="rf")
mf2<-train(diagnosis~., data=training, method="gbm")
mf3<-train(diagnosis~., data=training, method="lda")

pred1<-predict(mf1,testing)
pred2<-predict(mf2,testing)
pred3<-predict(mf3,testing)

accuracy1 = (testing$diagnosis == pred1);
length(accuracy1[accuracy1 == TRUE])/length(accuracy1)

accuracy2 = (testing$diagnosis == pred2);
length(accuracy2[accuracy2 == TRUE])/length(accuracy2)

accuracy3 = (testing$diagnosis == pred3);
length(accuracy3[accuracy3 == TRUE])/length(accuracy3)



cpred<-data.frame(pred1, pred2, pred3, diagnosis=testing$diagnosis)
combfit<-train(diagnosis~., method="rf", data=cpred)
combpred<-predict(combfit, cpred)

accuracy = (testing$diagnosis == combpred);
length(accuracy[accuracy == TRUE])/length(accuracy)

#Q3
set.seed(3523)
library(AppliedPredictiveModeling)
library(caret)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]
str(training)
set.seed(233)

require(elasticnet)
test<-enet(as.matrix(training[,-9]), training$CompressiveStrength, lambda=0)
plot.enet(test, xvar="penalty", use.color=T)



#Q4
require(lubridate)
require(forecast)
dat = read.csv("gaData.csv")
training = dat[year(dat$date)==2011,]
tstrain = ts(training$visitsTumblr)
testing = dat[year(dat$date)!=2011,]
tstest = ts(testing$visitsTumblr)
fit <- bats(tstrain, use.parallel=FALSE)
wbh<-predict(fit, newdata=tstest)
wbh
sum(tstest<774.1413 & tstest>-333.3223)/length(tstest)



#Q5
library(caret)
set.seed(3523)
library(AppliedPredictiveModeling)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]
set.seed(325)
library(e1071)
svmfit<-svm(CompressiveStrength~., data=training)
pred<-predict(svmfit,newdata=testing)
rmse <- sqrt(mean((pred-testing$CompressiveStrength)^2))
rmse



