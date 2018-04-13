## Regression Trees

I have used the ['solubility'](http://appliedpredictivemodeling.com/data) dataset available in R to fit 2 simple regression tree models:
- A simple regression tree
- Random forest

The packages you will need:
- `data(solubility)`
- `library(rpart)`
- `library(partykit)`

I have only used a single predictor in the dataset `Molecular Weight` and built a visual for a better understanding of the regression tree. Please refer to the R script titled 'RegressionTrees.R' for the code.

### A regression tree
R lets you plot your decision tree so that you can visualize it using the `rpart` and `partykit` libraries.
<img src="https://github.com/RuchitaGarde/Data-Science/blob/master/Attachments/Regressiontree.png" width="500px" height="350px"/>

### *References*
[Applied Predictive Modelling](http://appliedpredictivemodeling.com/) by Max Kuhn and Kjell Johnson, published by Springer.
