data(solubility)
rm(solTrainX)
rm(solTestX)

# Simple Regression tree
# set up training data
trainData = data.frame( x=solTrainXtrans$MolWeight, y=solTrainY )
## Build a simple regression tree: 
library(rpart)
library(partykit)
# defaults: for rpart.control are cp=0.01, maxdepth=30
# decreasing cp makes deeper trees; increasing maxdepth do the same
rPartModel = rpart( y ~ ., data=trainData, method="anova", control=rpart.control(cp=0.01,maxdepth=6) ) 
# tree plotting   Fig 8.4
rpartTree = as.party(rPartModel)
dev.new()
plot(rpartTree)
# predict solubility with this regression tree: 
rPart_yHat = predict(rPartModel,newdata=data.frame(x=solTestXtrans$MolWeight))
## performance evaluation
rtPR = postResample(pred=rPart_yHat, obs=solTestY)
rtPR

# A random forest model
library(randomForest)
rfModel = randomForest( y ~ ., data=trainData, ntree=500 ) # ntree=500
# predict solubility:
rf_yHat = predict(rfModel,newdata=data.frame(x=solTestXtrans$MolWeight))
## performance evaluation
rfPR = postResample(pred=rf_yHat, obs=solTestY)
rfPR