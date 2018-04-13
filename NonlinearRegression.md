## Comparison between non-linear regression models:
Neural Networks, kNN, MARS, SVM

I have used the ['permeability'](http://appliedpredictivemodeling.com/data) dataset available in R package to perform a comparative analysis between the above 4 non-linear regression models. Please refer to the R script titled 'NonlinearRegression.R' for the code.

The packages you will need:
- `library(AppliedPredictiveModeling)`
- `data(permeability)`
- `require(caTools)`
- `library(caret)`


### **Neural Networks**
I have developed a simple model for a feed-forward neural network.


### * kNN
<img src="https://github.com/RuchitaGarde/Data-Science/blob/master/Attachments/knnmodel.PNG.jpg" width="500px" height="350px"/>
<img src="https://github.com/RuchitaGarde/Data-Science/blob/master/Attachments/knnplot.PNG" width="500px" height="350px"/>

### * MARS
<img src="https://github.com/RuchitaGarde/Data-Science/blob/master/Attachments/marsmodel.PNG" width="500px" height="350px"/>

### * SVM
<img src="https://github.com/RuchitaGarde/Data-Science/blob/master/Attachments/svmmodel.PNG" width="500px" height="350px"/>

### A comparison between the 4 models:

Resampling performance:

| Model          | Tuning parameters | RMSE    | Rsquared | MAE    |
|:---------------|:-----------------:|:-------:|:--------:|-------:|
|Neural Network  |                   |         |          |        |
|kNN             |k = 11             |13.31055 |0.3292892 |8.999609|
|MARS            |degree=1, nprune=5 |13.82685 |0.3150553 |9.099420|
|SVM             |C = 8192.00        |12.05852 |0.4394367 |8.422084|

Test set performance using the optimal tuning parameter:

| Model          | RMSE     | Rsquared | MAE     |
|:---------------|:--------:|:--------:|--------:|
|Neural Network  |          |          |         |
|kNN             |9.4412141 |0.6787852 |7.0660115|
|MARS            |10.1847106|0.5974051 |6.9809899|
|SVM             |9.8999781 |0.6145958 |6.8537746|


### *References*
[Applied Predictive Modelling](http://appliedpredictivemodeling.com/) by Max Kuhn and Kjell Johnson, published by Springer.


