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

from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import RandomizedSearchCV, StratifiedKFold
from sklearn.pipeline import Pipeline
from sklearn.metrics import balanced_accuracy_score, roc_auc_score, make_scorer
from pickle import dump
import numpy as np
import pandas as pd

## set working directory
workdir = os.getcwd()
print('Working directory is {}'.format(workdir))

## set seed
np.random.seed(0)

## load data
X_train = pd.read_csv("../../../data/04/processed_for_ml/binary_class/x_train_taxahfe_no_sf.csv", index_col= 0, header= 0)
y_train = pd.read_csv("../../../data/04/processed_for_ml/binary_class/y_train_class.csv", index_col= 0, header= 0)
sw_train = pd.read_csv("../../../data/04/processed_for_ml/binary_class/sw_train_taxahfe.csv", index_col= 0, header= 0)
x_test = pd.read_csv('../../../data/04/processed_for_ml/binary_class/x_test_no_sf.csv', index_col= 0, header= 0)
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
pipeline_rf = Pipeline([
    ('model', RandomForestClassifier(random_state=1, n_jobs=-1))
        ])

## define the hyperparameter search space
param_grid = {
	'model__n_estimators':np.arange(100, 1100, 100), 
	'model__min_samples_split':np.arange(2, 6, 1), 
	'model__max_features':['sqrt','log2'],
    'model__max_depth':np.arange(3, 11, 2)
	} 

scoring = {'acc': 'accuracy'}

print('Starting Randomized Search')

search = RandomizedSearchCV(estimator = pipeline_rf, n_jobs=-1, n_iter=10000,
                      param_distributions= param_grid, scoring = scoring, refit='acc',
                      cv=cv)

search.fit(X_train, y_train.values.ravel(), **{'model__sample_weight': sw_train.values.ravel()})

print("Best params: {}".format(search.best_params_))
print( "Train Acc: {:.3f}".format(search.best_score_))

y_pred = search.predict(x_test)
print("Test Acc: {:.3f}".format(balanced_accuracy_score(y_test,y_pred)))

#save the model
mod_name = 'rf_regressor_crp_binary_class.pkl'
filename = 'model/' + mod_name
dump(search, open(filename, 'wb'))

print(datetime.now() - startTime)
