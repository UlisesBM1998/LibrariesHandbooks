from pyspark.sql import SparkSession

spark = SparkSession.builder.appName("Basic Functions").getOrCreate()

#Basic Functions
df = spark.read.json("people.json")

df.show()

df.printSchema()

df.columns

df.describe().show()


# Changing variables type
from pyspark.sql.types import StructField, StringType, IntergerType, StructType

data_schema = [StrucField("age", IntergerType(), True),
               StructField("name", StringType(), True])

final_schema = StructType(fields = data_schema)

df = spark.read.json("people.json", schema = final_schema)

#Selecting columns
type(df["age"])

df.select("age").show()

#Number of rows
df.head(5)[0]

df.select(["age", "name"])

#New columns
df.withColumn("new_age", df["age"]+1).show()

df.withCOlumnaRenamed("age", "new age name")

#SQL
df.createOrReplaceTempView("people")
results = spark.sql("SELECT * FROM people")
results.show()

new_results = spark.sql("SELECT * FROM people WHERE age = 30")
new_results.show()

#Working with CSV data
df = spark.read.csv("appl_stock", inferSchema = True, header = True)

df.printSchema()

#Filtering
df.filter("Close < 500").select("Open").show()
df.filter(df["Close"] < 500).select("Open").show()

df.filter((df["Close"] < 200) & ~(df["Open"]>200)).show()

#Working with stored data
result = df.filter(df["Low"] == 125).collect()

row = result[0]
row.asDict()["Volume"]

#Group by
df.groupBy("Company").mean().show() #sum, count, max, min

df.agg({"Sales": "sum"}).show()

# Other Functions
from pyspark.sql.functions import countDistinct, avg, stddev

df.select(countDistinct("Sales")).show()
df.select(avg("Sales").alias("Average Sales")).show()
df.select(stddev("Sales")).show()

from pyspark.sql.functions import format_number
sales_std = df.select(stddev("Sales").alias("std"))
sales_std.select(format_number("std", 2).alias("std")).show()

#Order by
df.orderBy("Sales").show()
df.orderBy(df["Sales"].desc()).show()

#Missing Data
df.na.drop().show()

df.na.drop(thresh = 2).show()

df.na.drop(how = "all").show() #If all the row has na

df.na.drop(subset=["Sales"].show()) #If there is a na on that variable

df.na.fill("No name", subset = ["Name"]).show()

mean_val = df.select(mean(df["Sales"])).collect()
mean_sales = mean_val[0][0]
df.na.fill(mean_sales, subset = ["Sales"]).show()

#Dates and time series
from pyspark.sql.functions import (dayofmonth, hour, 
                                   dayofyear, month,
                                   year, weekofyear,
                                   format_number,
                                   data_format)

df.select(dayofmonth(df["Date"])).show()

new_df = df.withColumn(year(df["Date"]))
new_df_groupuby = new_df.groupBy("Year").mean().select(["Year", "avg(Close)"])

new_df_groupuby.select(["Year", format_number("Average Closing Price",2).alias("Average Closing Price")]).show()

# PRACTICE
from pyspark.sql import SparkSession
spark = SparkSession.builder.appName("Practice").getOrCreate()

df = spark.read.csv("walmart_stock.csv", header = True, inferSchema = True)

# Getting the columns
df.columns

# Getting information about the variables
df.printSchema()

# Getting the first seven rows
for row in df.head(7):
    print(row)
    print("\n")
    
# Getting stats about the dataset
df.describe().show()

# Changing the data type 
from pyspark.sql.functions import format_number

result = df.describe()

result.select(result["summary"],
              formatnumber(result["Open"].cast("float"),2).alias("Open"),
              formatnumber(result["Hight"].cast("float"),2).alias("Hight"),
              formatnumber(result["Low"].cast("float"),2).alias("Low"),
              formatnumber(result["Close"].cast("float"),2).alias("Close"),
              result["Volume"].cast("int").alias("Volume")).show()

# Making calculations (HV ratio)
df2 = df.withColumn("HV Ratio", df["High"]/df["Volume"])
df2.select("HV Ratio").show()

# Pick the highest price
df.orderBy(df["High"].desc()).head(1)[0][0]

# Mean of the Close column
from pyspark.sql.functions import mean
df.select(mean("Close")).show()

# Max and min
from pyspark.sql.functions import max, min
df.select(max("Volume"), min("Volume")).show()

# How many days the close was lower what USD 60
df.filter("Close < 60").count()

# Percentage of the time the High greater than USD 80
(df.filter(df["High"]>80).count() / df.count()) * 100

# Correlation between High and Volume
from pyspark.sql.functions import corr
df.select(corr("High", "Volume")).show()

# What is the max High per year
from pyspark.sql.function import year

yearDF = df.withColumn("Year", year(df["Date"]))
maxDF = yearDF.groupBy("Year").max()

maxDF.select("Year", "max(High)").show()

# What is the average Close for each Month
from pyspark.sql.function import month

monthDF = df.withColumn("Month", month("Date"))
monthAVG = month.select(["Month", "Close"]).groupBy("Month").mean()

monthAVG.select("Month", "avg(Close)").orderBy("Month").show()

##########################################
################MACHINE LEARNING##########
##########################################

##### LINEAR REGRESSION
# Creating the session and importing the dataset
from pyspark.sql import SparkSession
spark = SparkSession.builder.appName("Liner Regression").getOrCreate()

df = spark.read.csv("cruise_ship_info.csv", inferShema = True, header = True)

df.printSchema()

# Changing Cruise line into numbers for better results
df.groupBy("Cruise_line").count().show()

from pyspark.ml.feature import StringIndexer

indexer = StringIndexer(inputCol = "Cruise_line", outputcol = "cruise_cat")
indexed = indexer.fit(df).transform(df)
indexed.head(3)

# Building ML model
from pyspark.ml.linalg import Vectors
from pyspark.ml.feature import VectorAssembler

indexed.columns

# Creating the dataset used for training the model
assembler = VectorAssembler(inputCols=["age", "Tonnage", "passengers", "cruise_cat"],
                            outputCol = "features")

output = assembler.transform(indexed)

final_data = output.select("features", "crew")

train_data, test_data = final_data.randomSplit([0.7,0.3])

# Training the model
from pyspark.ml.regression import LinearRegression

ship_lr = LinearRegression(labelCol = "crew")
trained_ship_model = ship_lr.fit(train_data)

ship_results = trained_ship_model.evaluate(test_data)

# Getting the model metrics
ship_results.rootMeanSquatedError
ship_results.r2

from pyspark.sql.functions import corr

# Getting the correlation
df.describe().show

df.select(corr("crew", "passengers")).show()

##### LOGISTIC REGRESSION
# Creating the session and importing the dataset
from pyspark.sql import SparkSession
spark = SparkSession.builder.appName("Logistics Regression").getOrCreate()
df = spark.read.csv("customer_churn.csv", inferSchema = True, header = True)

# First touch of the dataset
df.printSchema()

df.describe().show()

df.columns

# Creating one variable from all necessary columns of the dataset
from pyspark.ml.feature import VectorAssembler

assembler = VectorAssembler(inputCols = ["Age", "Total_Purchase", "Account_Manager"],
                            outputCol = "features")

output = assembler.transform(df)

final_df = output.select("features", "churn")

train_churn, test_churn = final_df.randomSplit([0.7,0.3])

# Training the model
from pyspark.ml.classification import LogisticRegression

lr_churn = LogisticRegression(labelCol="churn")

fitted_churn = lr_churn.fit(train_churn)

training_sum = fitted_churn.summary

# Predictions
training_sum.predictions.describe().show()

# Model evaluation
from pyspark.ml.evaluation import BinaryClassificationEvaluator

pre = fitted_churn.evaluate(test_churn)

pre.predictions.show()

churn_eval = BinaryClassificationEvaluator(rawPredictionCol = "prediction",
                                           labelCol = "churn")

auc = churn_eval.evaluate(pre.predictions)

##### RANDOM FOREST
# Creating the session and importing the dataset
from pyspark.sql import SparkSession
spark = SparkSession.builder.appName("random_forest").getOrCreate()

data = spark.read.csv("dog_food.csv", inferSchema = True, header = True)

data.head(1)

# Getting together all the numeric variables in a single one
from pyspark.ml.feature import VectorAssembler

data.columns

assembler = VectorAssembler(inputCols = ["A","B", "C", "D"],
                            output = "features")

output = assembler.transform(data)

# Declare the dataset used on the ML
from pyspark.ml.classification import RandomForestClassifier

rfc = RandomForestClassifier(labelCol = "Spoiled",
                             featuresCol = "features")

output.printSchema()

final_data = output.select("features", "Spoiled")

final_data.show()

# Training the model

rfc_model = rfc.fit(final_data)

# Knowing what is the most importante feature
rfc_model.featureImportances

##### K MEANS
# Creating the session and importing the dataset
from pyspark.sql import SparkSession
spark = SparkSession.builder.appName("k means").getOrCreate()

data = spark.read.csv("hack_data.csv", header = True,
                      inferSchema = True)

dataset.head()

# Getting together all the numeric variables in a single one
from pyspark.ml.cluestering import Kmeans
from pyspark.ml.feature import VectorAssembler

data.columns

feat_cols = ["Session_Connection", "Byte Transfarred", "Servers_Corrupted"]

assembler = VectorAssembler(inputCols =feat_cols,
                            outputCol = "features")

final_data = assembler.transform(data)
final_data.printSchema()

# Transforming all numeric data into one scale
from pyspark.ml.feature import StandardScaler

scaler = StandardScaler(inputCol = "features",
                        output = "scaledFeatures")

scaler_model = scaler.fit(final_data)
cluster_final_data = scaler_model.transform(final_data)

cluster_final_data.printSchema()

# Training two models, we want to see if there are two or three people involved
kmeans2 = KMeans(featuresCol = "scaledFeatures", k = 2)
kmeans3 = KMeans(featuresCol = "scaledFeatures", k = 3)

model_k2 = kmeans2.fit(cluster_final_data)
model_k3 = kmeans3.fit(cluster_final_data)

model_k3.transform(cluster_final_data).groupBy("prediction").count().show()

model_k2.transform(cluster_final_data).groupBy("prediction").count().show()