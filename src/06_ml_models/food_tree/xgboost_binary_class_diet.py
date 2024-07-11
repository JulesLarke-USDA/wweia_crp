#!/usr/bin/python3
print('Loading modules...')

from datetime import datetime
startTime = datetime.now()

import os
import warnings
warnings.simplefilter("ignore", category=DeprecationWarning)
warnings.simplefilter(action='ignore', category=FutureWarning)
warnings.simplefilter(action='ignore', category=UserWarning)
warnings.simplefilter(action='ignore', category=RuntimeWarning)

import xgboost as xgb
from sklearn.metrics import accuracy_score
from sklearn.model_selection import RandomizedSearchCV, StratifiedKFold
from sklearn.pipeline import Pipeline
from pickle import dump
import numpy as np
import pandas as pd

## set working directory
workdir = os.getcwd()
print('Working directory is {}'.format(workdir))

## set seed
np.random.seed(0)

## load data
X_train = pd.read_csv("../../../data/04/processed_for_ml/binary_class/x_train_taxahfe_no_sf_diet.csv", index_col= 0, header= 0)
y_train = pd.read_csv("../../../data/04/processed_for_ml/binary_class/y_train_class.csv", index_col= 0, header= 0)
sw_train = pd.read_csv("../../../data/04/processed_for_ml/binary_class/sw_train_taxahfe.csv", index_col= 0, header= 0)
x_test = pd.read_csv('../../../data/04/processed_for_ml/binary_class/x_test_no_sf_diet.csv', index_col= 0, header= 0)
y_test = pd.read_csv('../../../data/04/processed_for_ml/binary_class/y_test_class.csv', index_col= 0, header= 0)
x_test = x_test[X_train.columns] # reordered columns to match (column ordered changed during taxahfe)

X_train = X_train.sort_index(axis = 0)
y_train = y_train.sort_index(axis = 0)
sw_train = sw_train.sort_index(axis = 0)
x_test = x_test.sort_index(axis = 0)
y_test = y_test.sort_index(axis = 0)

## cross validation strategy
cv = StratifiedKFold(n_splits=10, shuffle=True, random_state=0)

## pipeline
pipeline_xgb = Pipeline([
    #('mutual_info', feat_sel),
    ('model', xgb.XGBClassifier(random_state=0, n_jobs=-1))
        ])

## define the hyperparameter search space
space = dict()
space['model__n_estimators'] = [100, 200, 300, 400, 500, 600]
space['model__colsample_bytree'] = [0.3, 0.4, 0.5, 0.7]
space['model__gamma'] = [0.0, 0.1, 0.2, 0.3, 0.4 ]
space['model__learning_rate'] = [0.05, 0.10, 0.15, 0.20, 0.25, 0.30]
space['model__max_depth'] = [3, 4, 5, 6, 8, 10, 12, 15]
space['model__min_child_weight'] = [1, 3, 5, 7]
space['model__subsample'] = [0.1, 0.3, 0.5, 0.7, 0.9]

xgb_search = RandomizedSearchCV(pipeline_xgb, param_distributions= space, scoring='accuracy', random_state=0, n_iter=20000, cv=cv, verbose=1, n_jobs=-1)

xgb_search.fit(X_train, y_train.values.ravel(), **{'model__sample_weight': sw_train.values.ravel()})

print("Best params: {}".format(xgb_search.best_params_))
print( "Best cross-validation score: {:.3f}".format(xgb_search.best_score_))

#print("Train Bal Acc: {:.3f}".format(balanced_accuracy_score(y_train,y_pred)))
y_pred = xgb_search.predict(x_test)
print("Test Acc: {:.3f}".format(accuracy_score(y_test,y_pred)))

#save the model
mod_name = 'xgboost_binary_class_diet'+'.pkl'
filename = 'model/' + mod_name
dump(xgb_search, open(filename, 'wb'))

print(datetime.now() - startTime)
