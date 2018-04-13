# Question 1

# Step 1: Preprocessing and splitting into training and test
library(AppliedPredictiveModeling)
data(permeability)
require(caTools)
library(caret)

to_be_removed <- nearZeroVar(fingerprints)
str(to_be_removed)
cat("Number of zero-variance columns found:", length(to_be_removed))
# drop these columns
fingerprints_after_removal <- fingerprints[,-to_be_removed]

# Split the data into training and test set
set.seed(101)
training = createDataPartition(permeability, p=0.8)
fingerprints_training = fingerprints_after_removal[training$Resample1,]
permeability_training = permeability[training$Resample1]
fingerprints_testing = fingerprints_after_removal[-training$Resample1,]
permeability_testing = permeability[-training$Resample1]

# neural network model
nnGrid = expand.grid( .decay=c(0,0.01,0.1), .size=1:10 )
# MaxNWts: The maximum allowable number of weights. There is no intrinsic limit in the code, 
# but increasing MaxNWts will probably allow fits that are very slow and time-consuming. We restrict it to 10 hidden units.
# linout: switch for linear output units. Default logistic output units.
nnetModel = train(x=fingerprints_training, y=permeability_training , method="nnet", preProc=c("center", "scale"), linout=TRUE, trace=FALSE, MaxNWts=10 * (ncol(fingerprints_training)+1) + 10 + 1, maxit=500, tuneGrid = nnGrid)
# Taking too long to respond. Put on hold for the time.

# KNN model
set.seed(101)
# Without specifying train control, the default is bootstrap 
knnModel = train(x=fingerprints_training, y=permeability_training, method="knn",
                 preProc=c("center","scale"),
                 tuneLength=10)
knnModel
# plot the RMSE performance against the k
plot(knnModel$results$k, knnModel$results$RMSE, type="o",xlab="# neighbors",ylab="RMSE", main="KNNs for Permeability")
## table the results for future display
## try the model on test data
knnPred = predict(knnModel, newdata=fingerprints_testing)
## The function 'postResample' can be used to get the test set performance values
knnPR = postResample(pred=knnPred, obs=permeability_testing)
knnPR
rmses = c(knnPR[1])
r2s = c(knnPR[2])
methods = c("KNN")

# MARS model
marsGrid = expand.grid(.degree=1:2, .nprune=2:38)
set.seed(101)
marsModel = train(x=fingerprints_training, y=permeability_training, method="earth", preProc=c("center", "scale"), tuneGrid=marsGrid)
marsModel
# Lets see what variables are most important: 
varImp(marsModel)
marsPred = predict(marsModel, newdata=fingerprints_testing)
marsPR = postResample(pred=marsPred, obs=permeability_testing)
marsPR
## cumulate the table the results for future display
rmses = c(rmses,marsPR[1])
r2s = c(r2s,marsPR[2])
methods = c(methods,"MARS")

# A Support Vector Machine (SVM):
set.seed(101)
# tune against the cost C
svmRModel = train(x=fingerprints_training, y=permeability_training, method="svmRadial", preProc=c("center", "scale"), tuneLength=20)
svmRModel
# Lets see what variables are most important: 
varImp(svmRModel)
svmRPred = predict(svmRModel, newdata=fingerprints_testing)
svmPR = postResample(pred=svmRPred, obs=permeability_testing) 
svmPR
rmses = c(rmses,svmPR[1])
r2s = c(r2s,svmPR[2])
methods = c(methods,"SVM")
res = data.frame( rmse=rmses, r2=r2s )
rownames(res) = methods
# Order the dataframe so that the best results are at the bottom:
res = res[ order( -res$rmse ), ]
print( "Final Results" ) 
print( res )