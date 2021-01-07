#Clustering Heart Disease Patient Datasets 

#There are many industries where understanding how things group together is 
#beneficial. One way to group objects is to use clustering algorithms. Here, we'll 
#explore the usefulness of unsupervised clustering algorithms to help clinicians 
#understand which treatments might work for their patients. 

#Clincians frequently study former cases to learn how to best treat their patients.
#A patient with a similar health history or symptoms to a previous patient might 
#benefit from undergoing the same treatment. This project investigates whether drs
#might be able to group together patients to target treatments using common 
#unsupervised learning techniques. Both k-mans and hierarchical clustering algorithms
#are used in this project.

#We'll cluster anonymised data of patients who have been diagnosed with heart 
#disease. Patients with similar characteristics might respond to the same treatments, 
#and clinicians could benefit from learning about the treatment outcomes of patients 
#like those they are treating. The data we are analysing here comes from the VA 
#Medical Centre in Long Beach, CA. 

#Load the data
heart_disease <- read_csv("processed.cleveland_heartdisease.data.csv")

#Print the first 10 rows
head(heart_disease)

#Exploratory Data Analysis 
#Quantifying patient differences
#To get a better understanding of characteristics of patients in the datasets. 
summary(heart_disease)
#cells with missing data observed within "ca" and "thal" columns - replaced "?" 
# with "NA" for data analysis. Columns converted from character to double as a result.

#Analysis of the datasets 
#age - avg age of patients is 54yrs with the youngest patient being 29yrs
#sex - where male = 1 and female  = 0, suggests majority of data came from male patients.
#cp - chestpain, where 1 = typical angina, 2 = atypical angina, 3 = non-anginal pain,
#   - & 4 = asymptomatic, suggesting most patients either had non-anginal pain or asymptomatic
#trestbps - resting BP (in mmHg on admission to hospital). Average resting BP was 130mmHg systolic
#    - near normal but max value seen of 200mmHg is near malignant HBP (abnormal)
#chol - serum cholesterol in mg/dL. average of 246.7mg/dL with max of 564mg/dL seen
#fbs - fasting blood sugar where >120mg/dL (1 = true, 0 = false), with mean of 
#    - 0.1485, suggests that most patients had fasting blood sugars <120mg/dL
#restecg - resting ecg results with Value 0 = normal, Value 1 = ST-T wave abnormality
#  - (T-wave inversions &/or ST elevtaion or depression of > 0.05mV), Value 2 = 
#  - probable or definite left ventricular hypertrophy by Estes' criteria
#thalach - maximum heart rate achieved, with min of 71 (normal), mean of 153 (tachycardia) 
#  - and max of 202 (risk of cardiac arrest)
#exang - exercise induced angina, where 1 = yes, 0 = no, with mean of 0.3267, most 
# - patients did not experience exercise induced angina
#oldpeak - ST depression induced by exercise relative to rest
#slope - slope of the peak exercise ST segment where Value 1 = upsloping, 
#    - Value 2 = flat, Value 3 = downsloping. Mean = 1.60. another way to rep exang
#ca - number of major vessels (0-3) colored by fluoroscopy. This would happen if 
#the coronary blood vessels were obstructed with plaques. their obstruction would 
#   - cause the heart disease in patients. Mean = 0.627 suggesting majority of patients 
#  - had obstruction of 1 or 2 major vessels leading to fluoroscopy colouring.


#Scaling the data
#To normalise range of all features so each feature contributes approx proportionately
#to the final distance 
scaled <- scale(heart_disease)

head(scaled)

#Visualising the data 
ggplot(heart_disease, aes(age, ca)) + geom_point() + ggtitle("age vs number of affected coronary arteries")

ggplot(heart_disease, aes(age, chol)) + geom_point() + ggtitle("Scatterplot of age vs cholesterol")

ggplot(heart_disease, aes(age, thalach, color = "age")) + geom_point() + ggtitle("age vs max heart rate achieved")


#Grouping the Patients

#set seed for reproducible results
seed_val <- 10
set.seed(seed_val)

#Select a number of clusters
k <- 5

#Create the k-means model
km_clustOne <- kmeans(scaled, centers = k, nstart = 1)

km_clustOne
#explanation - we are not aware of the true number of clusters, we asked the 
#algorithm to group the data into 5 clusters. Output of 5 clusters of sizes 53, 
# 46, 98, 73, 33.

#Number of patients in each cluster
print(km_clustOne$cluster)

#Trying out another cluster variation (with nstart = 20)
km_clustTwo <- kmeans(scaled, centers = k, nstart = 20)

km_clustTwo

#Number of patients in each cluster
print(km_clustTwo$cluster)

#explanation - i kept the number of clusters the same but changed the starting
#assignments to specify nstart of 20. R would therefore try 20 different random 
#starting assignments and select theone with the lowest within cluster variation.
#same outputs were obtained again :- 73, 46, 33, 53, 98

#Yet another round of k-means
#If algo genuinely groups similar observations (as opposed to clustering noise), 
#then cluster assignments will be robust betweem various iterations of the algo. 
#Wrt heart disease data, this would mean that the same patients would be grouped 
#even when algo initialised at different random points.

#Now group the patients with another iteration of the k-means algo

#set the seed
seed_val <- 40
set.seed(seed_val)

#Select a number of clusters and run the k-means algo
k <- 5
km_clustThree = kmeans(scaled, centers = k, nstart = 1)

km_clustThree
# number of patients in each of the 5 clusters = 69, 37, 45, 61, 91 which is near 
#enough to previous algo clusters.

print(km_clustThree$cluster)


#COMPARING PATIENT CLUSTERS
#Important that clusters are stable. Even though the algorithm begins by randomly
#initialising the cluster centers, if the k-means algorithm is the right choice for 
#the data, then different initialisations of the algo will result in similar clusters.

#The clusters from different assignments may not be the same but they should be 
#roughly the same size and have similar distributions of variables. IF THERE IS 
#A LOT OF CHANGE IN CLUSTERS BETWEEN DIFFERENT ALGO ITERATIONS, THEN K-MEANS 
#CLUSTERING IS NOT THE RIGHT CHOICE FOR THE DATA.

#As impossible to validate that the clusters obtained from the algo are accurate
#because there is no patient labelling, it's therefore necessary to examine how 
#the clusters change between different iterations of the algorithm. I'll use 
#visualisations to get an idea of cluster stabilities, this way i can see how certain 
#patient characteristics may have been used to group patients together.


#Add cluster assignments to the data
heart_disease["km_clustOne"] <- km_clustOne$cluster
heart_disease["km_clustThree"] <- km_clustThree$cluster

#Create and print the plot of age and chol for first clustering algorithm
km_plotOne <- ggplot(heart_disease, aes(x = age, y = chol, color = as.factor(km_clustOne))) +
geom_point()

km_plotOne


#Create and print the plot of age and chol for the third clustering algorithm
km_plotThree <- ggplot(heart_disease, aes(x = age, y = chol, color = as.factor(km_clustThree))) +
geom_point() 

km_plotThree   


#Hierarchical clustering: another clustering approach
#An alternative to k-means clustering is hierarchical clustering. This method works well
#when data have a nested structure. Heart disease patient data might follow this
#type of structure. For example, if men are more likely to exhibit specific 
#characteristics, those characteristics might be nested inside the gender variable.
#Hierarchical clustering also does not require the number of clusters to be selected
#before running the algorithm.

#Clusters can be selected by using the dendrogram. The dendrogram allows us to see 
#how similar observations are to one another, and they are useful in helping us 
#choose the number of clusters to group the data. It is now time for us to see how
#hierarchical clustering groups the data.

#Execute hierarchical clustering with complete linkage 
hier_clust_one <- hclust(dist(scaled), method = "complete")

#Print the dendrogram
plot(hier_clust_one)

#Get cluster assignments based on number of selected clusters
hc_one_assign <- cutree(hier_clust_one, k = 5)

#Hierarchical clustering round two
#In hierarchical clustering, there are multiple ways to measure the dissimilarity
#between clusters of observations. Complete linkage records the largest dissimilarity 
#between any two points in the clusters. On the other hand, single linkage is the 
#smallest dissimilarity between any two points in the cluster.
#Different linkages will result in different clusters being formed.

#We want to explore different algos to group our heart disease patients. The 
#best way to measure dissimilarity between patients could be to look at the smalles
#difference between patients and minimize that difference when grouping together 
#clusters. It is always a good idea to explore different dissimilarity measures. 
#Let's implement hierarchical clustering using a new linkage function.

#Execute hierarchical clustering with single linkage 
hier_clust_two <- hclust(dist(scaled), method = "single")

#Print the dendrogram
plot(hier_clust_two)

#Get cluster assignments based on number of selected clusters
hc_two_assign <- cutree(hier_clust_two, k = 5)

hc_two_assign


#COMPARING CLUSTERING RESULTS
#Clinicians are interested in grouping similar patients together to determine 
#appropriate treatments. Therefore, they want clusters with more than a few patients
#to see different treatment options. While a patient can be in a cluster by 
#themselves, this means that the treatment they received might not be recommended
#for someone else in the group. 

#Like the k-means algorithm, the way to evaluate hierarchical clusters is to 
#investigate which patients are grouped together. Are there patterns evident in
#the cluster assignments, or do they seem to be groups of noise? I'll next examine
#the clusters resulting from the two hierarchical algorithms.

#Add assignment of chosen hierarchical linkage
hc_one_assign -> heart_disease["hc_clust"]

#Remove the sex, first_clust and second_clust variables 
hd_simple <- heart_disease[, !names(heart_disease) %in% c("sex", "first_clust", 
                                                          "second_clust")]

#Get the mean and standard deviation summary statistics
clust_summary <- do.call(data.frame, aggregate(. ~ hc_clust, data = hd_simple, 
  function(x) c(avg = mean(x), sd = sd(x))))
clust_summary

#Visualising the cluster contents
#In addition to looking at the distributions of variables in each of the hierarchical 
#clustering runs, we will make visualisations to evaluate the algorithms. Even 
#though the data has more than two dimensions, we can get an idea of how the data 
#clusters by looking at a scatter plot of two variables. We want to look for patterns
#that appear in the data and see what patients get clustered together.

#Plot age and chol
plot_one <- ggplot(heart_disease, aes(x = age, y = chol(), color = as.factor(hc_clust))) + geom_point()

plot_one

dev.off()
