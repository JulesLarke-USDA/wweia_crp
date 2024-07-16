# WWEIA CRP

Description of the project. 

## Use and Requirements

1. clone the repository from the terminal: git clone https://github.com/JulesLarke-USDA/wweia_crp & cd wweia_ingredients
2. Create a conda environment from src/wweia_ingredients.yml: cd src & conda env create -f wweia_ingredients.yml
- NOTE: if running on Apple Silicon you will need to run CONDA_SUBDIR=osx-64 conda env create -f wweia_ingredients.yml
4. Activate the conda environment: conda activate wweia_crp
- NOTE: if running on Apple Silicon you will need to run conda env config vars set CONDA_SUBDIR=osx-64. Then conda deactivate and conda activate wweia_crp.

