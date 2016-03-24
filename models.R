#### ---- models.R
#### ---- model fits

library(bartMachine)
library(caret)

## ---- model 1
feats <- c('reservation_type','technology', 
           'actual_price','recommended_price',
          'num_images','street_parked',
          'description')

design <- data_m[,feats]
response <- data_m[,'total']
modl1 <- bartMachine(X=design, y = response)

## ---- cross-validated model
check_bart_error_assumptions(modl1)
plot_convergence_diagnostics(modl1)

## ---- variable importance
cov_importance_test(modl1, covariates=feats)


## ---- interactions?

interaction_investigator(modl1_cv, num_replicates_for_avg = 25,
                         num_var_plot = 10, bottom_margin = 5)



## ---- random forests
library(randomForest)

## ---- pretty much no way this code is not ugly.
model_mat <- with(data_m, 
  model.matrix(~reservation_type*technology*actual_price*recommended_price*num_images*street_parked*description))

model_mat <- model_mat[,-1] ## pop the intercept term off.
total<-data_m[,'total']

modl1 <- randomForest(x=model_mat,y=total,
 data=data_m, importance=TRUE, mtry=4)

var_imp <- importance(modl1)
var_imp <- data.frame(var_imp)
colnames(var_imp) <- c("inc_mse", "inc_node")
var_imp$var <- row.names(var_imp)

library(ggplot2)

var_imp <- var_imp[order(var_imp$inc_mse, decreasing = T),]

ggplot(var_imp, aes(x=var, y=inc_mse, group=1)) + 
  geom_point(size=3)+
  geom_line(colour="blue")+
  theme_bw() +
  xlab("Feature") + 
  ylab("Percent Increase is Mean Squared Error by Permuted Feature") +
  theme(axis.text.x=element_blank())
  

library(forestFloor)
library(randomForest)

model_mat_main <- with(data_m, 
       model.matrix(~reservation_type + technology + actual_price +
                      recommended_price + num_images + street_parked + description))
model_mat_main <- model_mat_main[,-1]
modl2 <- randomForest(x=model_mat_main,y=total,
                      data=data_m, 
                      importance=TRUE,
                      mtry=4, 
                      keep.inbag = TRUE)

ff <- forestFloor(rf.fit=modl2, X=model_mat_main)
Col <- fcol(ff,2,orderByImportance=FALSE) #create color gradient see help(fcol)
plot(ff,plot_seq=c(1,2),col=Col,plot_GOF=TRUE) 


