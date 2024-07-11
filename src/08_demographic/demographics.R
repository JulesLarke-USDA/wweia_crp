## Title: Demographic summary variables for NHANES CRP tertiles
## Author: Jules Larke
## Date: 021624
## Purpose: Create table and figure for participant demographic data. Perform statistics for table 1

library(tidyverse)
# Load data
data <- read.csv("../../data/00/wweia_covariates.csv")
crp <- read.csv("../../data/00/crp_table1.csv")

demo = left_join(data, crp, on='SEQN')

sum(is.na(demo$crp_table)) 

demo$crp_table <- as_factor(demo$crp_table)

strata <- as.data.frame(xtabs(~ crp_table, data = demo)) %>% mutate(percent = round(Freq/sum(Freq)*100, digits = 2))

# sex
sex <- as.data.frame(xtabs(~ crp_table + Sex, data = demo))
sex1 = sex %>% filter(crp_table == '1') %>% mutate(percent = round(Freq/sum(Freq)*100, digits = 1))
sex2 = sex %>% filter(crp_table == '2') %>% mutate(percent = round(Freq/sum(Freq)*100, digits = 1))
sex3 =sex %>% filter(crp_table == '3') %>% mutate(percent = round(Freq/sum(Freq)*100, digits = 1))

sex_all = rbind(sex1, sex2, sex3)
sex_all

demo %>% group_by(crp_table) %>% summarise(mean_bmi = mean(BMI), sd_bmi = sd(BMI))

demo %>% group_by(crp_table) %>% summarise(mean_age = mean(Age), sd_age = sd(Age))

demo %>% group_by(crp_table) %>% summarise(mean_pir = mean(family_pir), sd_pir = sd(family_pir))

# ethnicity
eth <- as.data.frame(xtabs(~ crp_table + Ethnicity, data = demo))
eth %>% filter(crp_table == '1') %>% mutate(percent = round(Freq/sum(Freq)*100, digits = 1))
eth %>% filter(crp_table == '2') %>% mutate(percent = round(Freq/sum(Freq)*100, digits = 1))
eth %>% filter(crp_table == '3') %>% mutate(percent = round(Freq/sum(Freq)*100, digits = 1))

smoke <- as.data.frame(xtabs(~ crp_table + ever_smoker, data = demo))
smoke %>% filter(crp_table == '1') %>% mutate(percent = round(Freq/sum(Freq)*100, digits = 1))
smoke %>% filter(crp_table == '2') %>% mutate(percent = round(Freq/sum(Freq)*100, digits = 1))
smoke %>% filter(crp_table == '3') %>% mutate(percent = round(Freq/sum(Freq)*100, digits = 1))

diabetes <- as.data.frame(xtabs(~ crp_table + diabetes, data = demo))
diabetes %>% filter(crp_table == '1') %>% mutate(percent = round(Freq/sum(Freq)*100, digits = 1))
diabetes %>% filter(crp_table == '2') %>% mutate(percent = round(Freq/sum(Freq)*100, digits = 1))
diabetes %>% filter(crp_table == '3') %>% mutate(percent = round(Freq/sum(Freq)*100, digits = 1))

hypertension <- as.data.frame(xtabs(~ crp_table + hypertension, data = demo))
hypertension %>% filter(crp_table == '1') %>% mutate(percent = round(Freq/sum(Freq)*100, digits = 1))
hypertension %>% filter(crp_table == '2') %>% mutate(percent = round(Freq/sum(Freq)*100, digits = 1))
hypertension %>% filter(crp_table == '3') %>% mutate(percent = round(Freq/sum(Freq)*100, digits = 1))

hypertension <- as.data.frame(xtabs(~ hypertension, data = demo))
hypertension %>% group_by(hypertension) %>% mutate(percent = round(Freq/19460*100, digits = 1))

edu <- as.data.frame(xtabs(~ crp_table + education, data = demo))
edu %>% filter(crp_table == '1') %>% mutate(percent = round(Freq/sum(Freq)*100, digits = 1))
edu %>% filter(crp_table == '2') %>% mutate(percent = round(Freq/sum(Freq)*100, digits = 1))
edu %>% filter(crp_table == '3') %>% mutate(percent = round(Freq/sum(Freq)*100, digits = 1))

edu  <- as.data.frame(xtabs(~ education, data = demo))
edu %>% group_by(education) %>% mutate(percent = round(Freq/19460*100, digits = 1))

demo %>% group_by(crp_table) %>% summarise(mean_pir = mean(family_pir), sd_pir = sd(family_pir))

# Perform t-tests and chi-squared tests using survey design elements for table 1
library(survey)
options(survey.lonely.psu='adjust')

t1_t3 = demo %>% filter(crp_table != 2)

svy_all <- svydesign(data=t1_t3, id=~SDMVPSU, strata=~SDMVSTRA, weights=~mecwts, nest=TRUE)

svyttest(BMI~crp_table, svy_all)
svyttest(Age~crp_table, svy_all)
svyttest(family_pir~crp_table, svy_all)

svychisq(~Sex+crp_table, svy_all, statistic="adjWald")
svychisq(~Ethnicity+crp_table, svy_all, statistic="adjWald")
svychisq(~ever_smoker+crp_table, svy_all, statistic="adjWald")
svychisq(~diabetes+crp_table, svy_all, statistic="adjWald")
svychisq(~hypertension+crp_table, svy_all, statistic="adjWald")
svychisq(~education+crp_table, svy_all, statistic="adjWald")
