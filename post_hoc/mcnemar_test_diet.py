import pickle
import pandas as pd
import numpy as np
from scipy import stats
from sklearn.metrics import confusion_matrix, accuracy_score

def load_and_predict_foodtree():
    """Load and get predictions for foodtree model exactly as in original script"""
    # Load model
    with open('./foodtree_model/diet_only/xgboost_binary_class_diet.pkl', 'rb') as f:
        foodtree_model = pickle.load(f)
    
    # Load data exactly as in original script
    x_test_foodtree = pd.read_csv('./foodtree_model/diet_only/x_test_no_sf_diet.csv', index_col=0)
    x_train_foodtree = pd.read_csv("./foodtree_model/diet_only/x_train_taxahfe_no_sf_diet.csv", index_col=0)
    y_test_foodtree = pd.read_csv('./foodtree_model/diet_only/y_test_class.csv', index_col=0)
    
    # Process exactly as in original script
    x_test_foodtree = x_test_foodtree[x_train_foodtree.columns]
    x_test_foodtree = x_test_foodtree.sort_index(axis=0)
    y_test_foodtree = y_test_foodtree.sort_index(axis=0)
    
    # Get predictions
    y_pred_foodtree = foodtree_model.predict(x_test_foodtree)
    
    return y_pred_foodtree, y_test_foodtree.values.ravel()

def load_and_predict_dii():
    """Load and get predictions for dii model exactly as in original script"""
    # Load model
    with open('./dii_model/diet_only/xgboost_binary_class_dii_diet_edu.pkl', 'rb') as f:
        dii_model = pickle.load(f)
    
    # Load data exactly as in original script
    x_test_dii = pd.read_csv("./dii_model/diet_only/x_test_diet.csv", index_col=0)
    y_test_dii = pd.read_csv("./dii_model/diet_only/y_test.csv", index_col=0)
    
    # Process exactly as in original script
    x_test_dii = x_test_dii.sort_index(axis=0)
    y_test_dii = y_test_dii.sort_index(axis=0)
    
    # Get predictions
    y_pred_dii = dii_model.predict(x_test_dii)
    
    return y_pred_dii, y_test_dii.values.ravel()

# Get predictions using exact original method
dii_preds, y_test_dii = load_and_predict_dii()
foodtree_preds, y_test_foodtree = load_and_predict_foodtree()

# Verify we're using the same test set
if not np.array_equal(y_test_dii, y_test_foodtree):
    raise ValueError("Test sets don't match!")

# Calculate individual accuracies
dii_accuracy = accuracy_score(y_test_dii, dii_preds)
foodtree_accuracy = accuracy_score(y_test_foodtree, foodtree_preds)

print(f"DII Test Accuracy: {dii_accuracy:.4f}")
print(f"FoodTree Test Accuracy: {foodtree_accuracy:.4f}")

# Perform McNemar's test
correct_dii = dii_preds == y_test_dii
correct_foodtree = foodtree_preds == y_test_foodtree

contingency_table = confusion_matrix(correct_dii, correct_foodtree)
b = np.sum(~correct_dii & correct_foodtree)  # dii wrong, foodtree right
c = np.sum(correct_dii & ~correct_foodtree)  # dii right, foodtree wrong

statistic = (abs(b - c) - 1)**2 / (b + c)
p_value = stats.chi2.sf(statistic, df=1)

print(f"\nMcNemar's test statistic: {statistic:.4f}")
print(f"p-value: {p_value:.4f}")

print("\nContingency Table:")
print("FoodTree Correct\tFoodTree Incorrect")
print(f"DII Correct\t{contingency_table[1,1]}\t\t{contingency_table[1,0]}")
print(f"DII Incorrect\t{contingency_table[0,1]}\t\t{contingency_table[0,0]}")