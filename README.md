# WWEIA CRP

This repository contains the scripts and data used for reproducing results and visualizations

## Use and Requirements

1. Clone the repository from the terminal:<br>`git clone https://github.com/JulesLarke-USDA/wweia_crp`<br>`cd wweia_crp`
2. Create a conda environment for running python scripts from src/wweia_crp.yml:<br>`cd doc`<br>`conda env create -f wweia_crp.yml`
- NOTE: if running on Apple Silicon you will need to run `CONDA_SUBDIR=osx-64 conda env create -f wweia_crp.yml`
3. Activate the conda environment:<br> `conda activate wweia_crp`
- NOTE: if running on Apple Silicon you will need to run<br> `conda env config vars set CONDA_SUBDIR=osx-64`<br> Then `conda deactivate` and `conda activate wweia_crp`
4. R scripts are run with a local R server within a Docker (v4.32.0) container for version control purposes <br>
- Install docker and navigate to the wweia_crp directory
- Then run `docker build -t wweia_crp:1.0 .`
- When finished run ``docker run --rm -it -p 8787:8787 -e PASSWORD=yourpasswordhere -v `pwd`:/home/docker/ wweia_crp:1.0``
- Open a web browser and navigate to http://localhost:8787/
- Login to the RStudio server
  * username: rstudio
  * password: yourpasswordhere
- Change directories from the R console: `setwd("/home/docker")`
- Navigate to the currect working directory in the Files tab: Files > More > Go To Working Directory
![image](https://github.com/JulesLarke-USDA/wweia_crp/blob/main/doc/readme.png)
5.  Run code seqentially starting from src/00
- NOTE: Building the NHANES dataset requires the dietary recalls *wweia_all_recalls.txt* which can be generated from https://github.com/JulesLarke-USDA/wweia_ingredients

## Required software
- Miniconda
- R 4.1.0
- [TaxaHFE](https://github.com/aoliver44/taxaHFE/tree/51-fixes-to-output-files-for-taxahfe-ml)
- Docker 4.32.0
