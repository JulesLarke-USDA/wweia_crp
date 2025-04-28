import pickle
import pandas as pd
import numpy as np
from scipy import stats
from sklearn.metrics import confusion_matrix, accuracy_score

def load_and_predict_xgb():
    """Load and get predictions for XGBoost model exactly as in original script"""
    # Load model
    with open('./foodtree_model/xgboost_binary_class.pkl', 'rb') as f:
        xgb_model = pickle.load(f)
    
    # Load data exactly as in original script
    x_test_xgb = pd.read_csv('./foodtree_model/x_test_no_sf.csv', index_col=0)
    x_train_xgb = pd.read_csv("./foodtree_model/x_train_taxahfe_no_sf.csv", index_col=0)
    y_test_xgb = pd.read_csv('./foodtree_model/y_test_class.csv', index_col=0)
    
    # Process exactly as in original script
    x_test_xgb = x_test_xgb[x_train_xgb.columns]
    x_test_xgb = x_test_xgb.sort_index(axis=0)
    y_test_xgb = y_test_xgb.sort_index(axis=0)
    
    # Get predictions
    y_pred_xgb = xgb_model.predict(x_test_xgb)
    
    return y_pred_xgb, y_test_xgb.values.ravel()

def load_and_predict_rf():
    """Load and get predictions for RF model exactly as in original script"""
    # Load model
    with open('./dii_model/rf_binary_class_dii_edu.pkl', 'rb') as f:
        rf_model = pickle.load(f)
    
    # Load data exactly as in original script
    x_test_rf = pd.read_csv("./dii_model/x_test.csv", index_col=0)
    y_test_rf = pd.read_csv("./dii_model/y_test.csv", index_col=0)
    
    # Process exactly as in original script
    x_test_rf = x_test_rf.sort_index(axis=0)
    y_test_rf = y_test_rf.sort_index(axis=0)
    
    # Get predictions
    y_pred_rf = rf_model.predict(x_test_rf)
    
    return y_pred_rf, y_test_rf.values.ravel()

# Get predictions using exact original method
rf_preds, y_test_rf = load_and_predict_rf()
xgb_preds, y_test_xgb = load_and_predict_xgb()

# Verify we're using the same test set
if not np.array_equal(y_test_rf, y_test_xgb):
    raise ValueError("Test sets don't match!")

# Calculate individual accuracies
rf_accuracy = accuracy_score(y_test_rf, rf_preds)
xgb_accuracy = accuracy_score(y_test_xgb, xgb_preds)

print(f"Random Forest Test Accuracy: {rf_accuracy:.4f}")
print(f"XGBoost Test Accuracy: {xgb_accuracy:.4f}")

# Perform McNemar's test
correct_rf = rf_preds == y_test_rf
correct_xgb = xgb_preds == y_test_xgb

contingency_table = confusion_matrix(correct_rf, correct_xgb)
b = np.sum(~correct_rf & correct_xgb)  # RF wrong, XGB right
c = np.sum(correct_rf & ~correct_xgb)  # RF right, XGB wrong

statistic = (abs(b - c) - 1)**2 / (b + c)
p_value = stats.chi2.sf(statistic, df=1)

print(f"\nMcNemar's test statistic: {statistic:.4f}")
print(f"p-value: {p_value:.4f}")

print("\nContingency Table:")
print("XGBoost Correct\tXGBoost Incorrect")
print(f"RF Correct\t{contingency_table[1,1]}\t\t{contingency_table[1,0]}")
print(f"RF Incorrect\t{contingency_table[0,1]}\t\t{contingency_table[0,0]}")