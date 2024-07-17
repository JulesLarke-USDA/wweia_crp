# WWEIA CRP

This repository contains the scripts and data used for reproducing results and visualizations

## Use and Requirements

1. clone the repository from the terminal: git clone https://github.com/JulesLarke-USDA/wweia_crp & cd wweia_crp
2. Create a conda environment from src/wweia_crp.yml: cd src & conda env create -f wweia_crp.yml
- NOTE: if running on Apple Silicon you will need to run CONDA_SUBDIR=osx-64 conda env create -f wweia_crp.yml
3. Activate the conda environment: conda activate wweia_crp
- NOTE: if running on Apple Silicon you will need to run conda env config vars set CONDA_SUBDIR=osx-64. Then conda deactivate and conda activate wweia_crp.
4. Run code seqentially starting from src/00
- NOTE: Building the NHANES dataset requires *wweia_all_recalls.txt* which can be generated from https://github.com/JulesLarke-USDA/wweia_ingredients

## Required software
- Miniconda
- R 4.1.0
- [TaxaHFE](https://github.com/aoliver44/taxaHFE/tree/51-fixes-to-output-files-for-taxahfe-ml)
