## HEART DISEASE PROJECT - CLUSTERING HEART DISEASE PATIENT DATASETS

SUMMARY
Project focus is on use of unsupervised algorithms to cluster datasets from Heart Disease patients. Objective is to group patients into clusters based on similar characteristics so clinicians can provide more targeted and effective treatments to each patient group.

## INTRODUCTION 
For my project, i chose to analyse anonymised datasets of patients diagnosed with heart disease. 

It is known that patients with similar background medical histories and/or presenting complaints will likely respond in a similar manner to the same treatment. It was investigated in this project whether or not clinicians are able to group patients in order to provide targeted treatments by patient group. 

The Cleveland clinic patient datasets were clustered using 2 unsupervised algorithms - kmeans and hierarchical clustering. This was done to ascertain if any patterns or similarities of patient attributes exist in the datasets. The outcome (if present), would help clinicians understand which treatment options could potentially work best for their patients. 

## DATA COLLECTION
Datasets were obtained from the Cleveland Clinic Foundation. 14 out of 76 potential features/attributes were utilised for the purposes of the project. The heart disease patient features included: age, sex, resting B.P., serum cholesterol, fasting blood sugsr, maximum heart rate achieved, exercise-induced angina, ST depression induced by exercise relative to rest, slope of the peak exercise ST segment, the number of major coronary vessels coloured by fluoroscopy, resting ecg and diagnosis of heart disease. 

## PRE-PROCESSING
As part of data cleansing, i implemented the following steps:

- Pulled the data into excel and cleaned it by converting delimited datasets, removing commas and separating each dataset into individual cells
- Assigned row names with features/attributes provided in the original dataset
- Removed 4 missing values for ca (the number of coronary blood vessels coloured by fluoroscopy)
- Removed 4 missing values for thal (thalassaemia blood disorder)

The final count was 340 patient datasets


## EXPLORATORY DATA ANALYSIS
Before building my unsupervisesd models, i undertook exploratory data analysis to ascertain if i could discover any evidence of a relationship between the age of the patients with heart disease and the rest of the attributes in the data. 

The ggplot visuals show a number of different relationships - e.g. the number of affected coronary blood vessels tends to increase with increasing age, which supports the understanding that cholesterol/lipid plaques accumulate in most affected individuals over time (unless if of familial cause).

I also explored the relationship between age and cholesterol and thus observed in general, there were higher levels of cholesterol seen in older patients (with a single outlier above 550mg/dL), and finally, highest recorded heart rates seen in younger patients - which wasn't necessarily an indicator of pathology (due to impact from different causal factors including time of day, degree of pain, degree of disease severity etc). 

I sought to better understand the characteristics of the various attributes and discovered all had different "mean" values. The datasets were therefore scaled in order to normalise the range of all the features/attributes used. This ensured that each feature contributed approximately proportionately to the final distance.


## MODELING
As mentioned above, out of a potential 76 different attributes, 14 were used - including:- 

1. age - age in years
2. sex - male (1), female (0)
3. cp - chest pain type: Typical Angina (1), Atypical Angina (2), Non-Anginal pain (3), Asymptomatic (4)
4. trestbps - resting B.P. (in mmHg on admission into hospital)
5. chol - serum cholesterol in mg/dL
6. fbs - fasting blood sugar > 120mg/dL (1 = true, 2 = false)
7. restecg - resting ecg
8. thalach - maximum heart rate achieved (bpm)
9. exang - exercise induced angina
10. oldpeak - ST depression induced by exercise relative to rest
11. slope - the slope of the peak exercise ST segment 
12. ca - the number of major blood vessels coloured by fluoroscopy (0 - 3)
13. thal - the (complete or partial) presence or absence of thalassaemia blood disorder, with 3 - normal (absence), 6 = fixed defect (complete), 7 = reversible defect (partial)
14. num - diagnosis of heart disease (angiographic disease status with Value 0 < 50% diameter narrowing and Value 1 >= 50% diameter narrowing)


I used the kmeans and hierarchical clustering methods to classify the datasets. 

Using the kmeans algorithm, i used a for loop to create a scree plot of total within sum of squares against the number of clusters. This plot implied that there were inherently 3 clusters in the datasets so k was set to 3. 

Using the hierarchical clustering approach, 2 different dissimilarity methods were used (the "complete" method for the largest dissimilarity between any two points in the cluster and the "single" method for the smallest dissimilarity between any two points in the cluster).

The objective here was to investigate which patients were grouped together (by both clustering algorithms) - to ascertain if any patterns present in the cluster assignments or alternatively, if groups of noise.

Finally, both clustering methods were compared to each other in a table of their outputs:

 hc_one_assign  
     1    2   3   
 1   10   82  0  
 2   26   15  0
 3   162  7   1
 
 
 
 



