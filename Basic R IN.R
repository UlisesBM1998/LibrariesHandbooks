ls() #Shows all the variables and data
rm(simpleSample) #Remove variables and data
cat('\14') #Clean the console

#########################
#######DATA TYPES########
#########################

#Character

##MATRIX
mat = matrix(c("Fire", "Water", "Ground", "Flying", "Charizard", "Totodile", "Diglet", "Talonflame"), nrow = 4)
colnames(mat) = c("Type", "Pokemon")
mat

##DATAFRAME
df = data.frame(Company=c("Apple", "Microsoft", "Amazon"), Symbol=c("AAPL", "MSFT", "AMZN"), Ranking=c(3,2,1))
df


#Numeric

123L
class(123L)

##TRANSFORM
as.numeric("123")

as.character(123)
as.character(TRUE)

as.logical("TRUE")
as.logical(123)
as.logical(1)
as.logical(0)
as.logical("apple")

#########################
########VECTORS##########
#########################

#Single data
curr_month = "Aug 2023"

class(curr_month)
length(curr_month)

curr_day = "5"
curr_day = as.numeric(curr_day)
class(curr_day)

#Multiple data
numOfDays = c(1,2,3,4,5,6,7)
nameOfDays = c("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat")
yeardays = 1:365
yeardays

names(numOfDays) = nameOfDays
numOfDays

numOfDays["Wed"]
numOfDays[c(1:4)]
numOfDays[c("Thu", "Sat")]

#Factor
facNumOfDays = factor(numOfDays)
facNumOfDays

#Blank Vectors
charVec = character(10)
charVec
class(charVec)
object.size(charVec)

numVec = numeric(10)
numVec
class(numVec)
object.size(charVec)

intVec = integer(10)
intVec
class(intVec)
object.size(intVec)

logVec = logical(10)
logVec
class(logVec)
object.size(logVec)

#Combined vectors
a = c(1,2,3,4,5)
b = c(6,7,8,9,10)

combined = c(a,b)
combined

####################################
##############LISTS#################
####################################

l1 = c("A","B", "C")
l2 = c(1,2,3)
l3= c(TRUE, FALSE, FALSE)

finalList = list(l1,l2,l3)
class(finalList)
finalList

finalList[1]
finalList[3]

finalList[[1]][2]

finalList[[2]]

#Put names on the list
finalListwithNames = list(Letters = l1, Numbers = l2, Binary = l3)
finalListwithNames

finalListwithNames$Binary

#Return the list into a Vector
finalListConvertoToVector = unlist(finalListwithNames)
finalListConvertoToVector

####################################
############DATAFRAMES##############
####################################

country    <- c("France", "Germany", "Greece", "Italy", "Portugal", "Spain")
gdp_growth <- c(1.3, 0.3, 1.9, 0.3, NA, 2)
mkt_type   <- factor(c("High", "High", "Low", "Medium", "Low", "Medium"))

df <- data.frame(country = country, gdp_grwth = gdp_growth, `market typ` = mkt_type)
df
class(df)
typeof(df)

View(df)
df_edited <- edit(df)

#Metadata
attributes(df)

attr(df, 'source') = 'manmade'
attributes(df)

comment(df) <- "Performance Dataframe"
comment(df)

df$gdp_grwth

# Create a new column
df$new_column <- abbreviate(df$country, 3)

# If a single value is provided, it gets repeated in all rows
dfdummy <- data.frame(country     = country, 
                 gdp_grwth   = gdp_growth, 
                 market_typ  = mkt_type, 
                 dummycolumn = 0)

dfdummy

# If the column lengths are not the same the values get cycled
dfdummy <- data.frame(country     = country, 
                 gdp_grwth   = gdp_growth, 
                 market_typ  = mkt_type, 
                 dummycolumn = c(1,2,3))
dfdummy

#Info about the dataframe
str(df)

class_of_df <- sapply(df, class)  
class_of_df

# Alternately use as.character to change the column type
df <- data.frame(country    = country, 
                 gdp_grwth  = gdp_growth, 
                 market_typ = mkt_type)
str(df)
df$country <- as.character(df$country)

#Add more information to the dataframe depending of the position

df = data.frame(Number = c(1,1,1), Letter = c("A","B","C"))

# Append dataframe column wise
df2 <- cbind(df, df)
df2

# row bind: Append dataframe row wise
df3 <- rbind(df, df)
df3

str(df3)

#See the Bottom 6 Rows
head(df)
head(df, 10)

#See the Bottom 6 Rows
tail(df)
tail(df, 10)

#Check dimensions of dataframe
dim(df) # Get number of Rows and Columns

#Number of rows and columns
nrow(df)  # number of Rows
NROW(df)  # Number of Rows alternate

ncol(df)  # Number of Columns
NCOL(df)  # Alternate for number of rows

# use nrow() and NROW() on vectors
nrow(country)  # doesnt work
NROW(country)  # works on vectors

# Check and assign row names and column names
rownames(df) # Check row name
rownames(df) <- paste0('row_', rownames(df))
rownames(df)

colnames(df) # Check column name
colnames(df) <- c("Country", "GDP Growth", "Market Type")  # Col names cannot begin with numbers.
colnames(df)

summary(df)

#Accessing into cols and rows

df[,c("country")]
df[, c(2)]

df[c(1,2,3,4,5), c('country')]
df[-c(6), c('country')]

#Delete a column
df$country <- NULL
head(df)

# Show all except few given rows (1,3,5)
df[-c(1, 3, 5), ]

#Export and Import dataframes

#Set the working directory
dir_path <- 'C:/Users/NDH00130/Documents/Playground'
setwd(dir_path)
getwd()

write.csv(df, "economic_performance.csv", row.names = F)

# Form the file path
dir_name       <- "C:/Users/NDH00130/Documents/Playground"
file_name      <- "economic_performance_newpath"
ext            <- "csv"
file_name_ext  <- paste0(file_name, '.', ext)

path <- file.path(dir_name, file_name_ext) # full path
path

# Check if file exists and then write
if(file.exists(path)){
  # Add '_copy' to end of file name and write
  file_name <- paste0(file_name, '_copy')
  file_name_ext <- paste0(file_name, '.', ext)
  path <- file.path(dir_name, file_name_ext) # full path
  write.csv(df, path, row.names = F)
}else{
  # write
  write.csv(df, path, row.names = F)  # write to file
}

# Save the entire list of object in your R console
save.image('all_data.RData')

#Read data
df_gdpgrowth <- read.table(path, sep=",", header = T) 
df_gdpgrowth

##Alternately, use read.csv()
df_gdpgrowth <- read.csv(path) 
df_gdpgrowth

# Install packages for export and import in Excel
install.packages(c('haven', 'xlsx'))
library(haven)   # import SAS, SPSS and Stata files
library(xlsx)

# Import data
path <- file.path(dir_name,"Inflation_Rate.xlsx")
df_inf <- xlsx::read.xlsx(path, sheetName="Sheet1")
View(df_inf)

#Summarizing info

Hmisc::describe(df)

pastecs::stat.desc(df)

df_skimmed <- skimr::skim(df)
View(df_skimmed)

summarytools::descr(df)

psych::describe(df)

#Conditional

index    <- which(df$Scope == "Include")  # Returns all row numbers where scope is "Include"
index 

df_include2 <- df[df$Scope == "Include", ]

all.equal(df_include, df_include2)

index_available <- !is.na(df$Country)

df_clean2 <- df_clean[!df_clean$Country == '', ]
View(df_clean2)

df_clean <- na.omit(df)
dim(df_clean)

df[df == ""] <- NA
View(df_clean)

#Transposing
mat_regions <- t(df) 

object.size(df_regions)

#Joins
x <- merge(df_gdp, df_inflation, by.x="Country", by.y="Country", all=T)   # Outer Join
x <- merge(df_gdp, df_inflation, by.x="Country", by.y="Country")   # INNER Join
df_gdp_inflation <- merge(df_gdp, df_inflation, by.x="Country", by.y="Country", all.x=T) #Left

#Sorting
x <- df[order(df$Last_inflation), ] #ASC
x <- df[order(-df$Last_inflation), ] #DESC

#Sum

rowSums(score)  # Total score for a quarter
colSums(score)  # Total score for a year 
cumsum(score)   # cumulatively sums within a column

#Grouping
df_gdp_by_region <- aggregate(`Annual.GDP.Growth` ~ `Operating.Region`, data=df, FUN=mean) # Here is weight is a function of Diet, from the dataset ChickWeight. By setting the FUN to `mean`
df_gdp_by_region

aggregate(`Last_inflation` ~ `Operating.Region`+ gdp_cat, data=df, FUN=sum)

View(aggregate(`Country` ~ `Operating.Region`, data=df, FUN=length))
table(df$Operating.Region) #COUNTING

####################################
########REPS and Sequences##########
####################################

#Repetitions
letters = c("a","b","c")
lettersTwice = rep(letters,2)
lettersTwice
lettersTwice = rep(letters,each = 5)
lettersTwice
weekEndX5 = rep(c("Sun", "Sat"), 5)
weekEndX5

#Sequences
mySeq1 = seq(from = 7.1, by = 0.1, length = 7)
mySeq1

mySeq2 = seq(from = 100, to= 200, length= 7)
mySeq2

####################################
########Random and Rounding#########
####################################

#Random Numbers
visitors = runif(30)
visitors

visitors = runif(30, min = 10, max=100)
visitors

#Random Numbers but with normalization
height = rnorm(30, mean = 1.75, sd= .5)
height

#Sampling
mySamp1 = sample(1:100, 5) #From 1 to 100, choose five without replacement
mySamp1

mySamp2 = sample(0:1, 5, replace = T)
mySamp2

#Round
n = 1.1234567
n2 = 112.3924567
round(n,3)
round(n2,2)

ceiling(n)
ceiling(n2)

floor(n)
floor(n2)

trunc(n)
trunc(n2)

options(digits = 4)
n
n2

options(digits = 6)
n
n2

# By setting the scipen parameter, you can get rid of the scientific notation, that is the 'e' notation
options(scipen=999)
1200000000000000

####################################
############Subsets#################
####################################

myList = c(0,1,2,3,4,5,6,7,8,9)

higherThan5 = which(myList>5)
myList[higherThan5]

higherThan5AndLowerThan6 = which(myList>5 & myList<8)
myList[higherThan5AndLowerThan6]

higherThan5OrEven = which(myList>5 | myList %% 2==0)
myList[higherThan5OrEven]

####################################
#########Missing Values#############
####################################

myList = round(runif(30,0,50))
myList
myList[7] = NA
myList[14]= NA
myList[21]= NA
myList[2]= Inf
myList[6]= Inf
myList[8]= Inf

##If there is NA
#Method 1
anyNA(myList)

#Method 2
NA %in% myList

##Removing by NA and Inf
#Method 1
NAvalues = is.na(myList)
myList[NAvalues]

noNAvalues = !is.na(myList)
myList[noNAvalues]

Infvalues = is.infinite(myList)
myList[Infvalues]

noInfvalues = !is.infinite(myList)
myList[noInfvalues]

#Method 2
na.omit(myList)

##Replacing
naPositions = which(is.na(myList))
naPositions
myList[naPositions] = 10
myList

####################################
########Binning Operations##########
####################################

numCars = round(runif(100,0,5))
bins = c(0,2,4,5)
labels = c("Low", "Medium", "High")
carsTable = cut(numCars, bins, labels)
table(carsTable)

limits = pretty(numCars,5)
labels = c("Low", "Medium", "High", "Highest")
carsTable = cut(numCars, limits, labels)
table(carsTable)

####################################
########Formulas for Vectors########
####################################

sales = round(runif(100, 5000, 6000))

unique(sales)
length(unique(sales))
duplicated(sales)
mean(sales, na.rm = T) #Does not count NA values
median(sales, na.rm = T)
sum(sales)
max(sales)
min(sales)
sort(sales, decreasing = F)
rev(sort(sales))
quantile(sales, prob=c(0.25,0.5,0.75), na.rm= T)
summary(sales)

####################################
############Set Operations##########
####################################

m1 <- c(1, 1, 1, 2, 2, 2, 2, 4, 4, 4, 4, 5, 5, 5, 5, 5, 7, 7, 7, 7)
m2 <- c(1, 1, 1, 3, 3, 3, 3, 4, 4, 4, 4, 6, 6, 6, 6, 6, 7, 7, 7, 7)
m1
m2

#Data that exist on the other dataset
result = m1 %in% m2
result
m1[result]

#Unique data
unique(m1)
length(unique(m1))

#Dataset that combine all unique data on all the datasets
union(m1,m2)

#Dataset that only accept unique data that is on all the datasets
intersect(m1,m2)

# Data that are not on both  datasets
setdiff(m1, m2)

####################################
################IF ELSE#############
####################################

a=1
b=2

if (a>b){
  print("A is higher than B")
}else{
  print("B is higher than A")
}

result = ifelse(a>b, "A is higher than B","B is higher than A" )
print(result)

sales = rnorm(30, mean= 5000, sd= 0.5)
result = ifelse(sum(sales)>10000, "Good sales", "Bad sales")
print(result)

####################################
################LOOPS###############
####################################

#FOR
numOfPills = 1:1000
pillType = sample(c("Real", "Placebo"), length(numOfPills), replace = T, prob=c(0.9,0.1))
placeboID = c()

for(i in 1:50) {
  if(pillType[i]=="Placebo"){
    placeboID = c(placeboID, pillType[i])
  }
}

#break next()

#WHILE

iteration <- 1
total_sales <- sum(sample(sale_price, 10))

while(total_sales < 100){
  print(paste('Iteration: ', iteration))
  total_sales <- sum(sample(sale_price, 10))
  if(total_sales >= 100) {
    print(total_sales)
    break
  }
  iteration <- iteration + 1
}

#REPEAT
iteration <- 1
repeat {  total_sales <- sum(sample(sale_price, 10))
if (total_sales >= 100) {
  print(total_sales)
  break
}
iteration <- iteration + 1
}

####################################
###########TIME AND MEMORY##########
####################################

system.time ({
  item_id_hypo <- numeric()
  for(i in 1:100000){
    item_id_hypo <- c(item_id_hypo, i) 
  }
  item_id_hypo
})

####################################
########STRING MANIPULATION#########
####################################

library(stringr) 

coupon_code <- "MOVUK773101"
str_count(coupon_code)

coupon_code_2 <- c("MUSCH255367", "MOVUK773101")
str_count(coupon_code_2)

region <- substr(coupon_code, 4, 5) # Find region
region

sentence1 <- "Good Morning, Train Number RL324 is late by 41 minutes "
sentence2 <- "Good Morning, Train Number KL324 is late by 10 minutes "
word(sentence1, c(5,9,10))
word(sentence2, c(5,9,10))

cust_type <- "SL"
new_coupon_code <- paste (cust_type,coupon_code) # Concatenate with space
new_coupon_code

# Remove space while concat
new_coupon_code <- paste(cust_type,coupon_code,sep = "") 
new_coupon_code

new_coupon_code <- paste(cust_type,coupon_code,sep = "#") 
new_coupon_code

# collapse them into a single sting
paste(c("SL", "GO"),c("MOVUK773101", "MUSCH470803"), sep="#", collapse="-")

review <- "WOW!! seats & gears were cOmfOrtable,smOOth. I was AMAZED!! 512341   "

str_to_upper(review) # change to upper case

str_to_lower(review) # change to lower case

str_to_title(review) # to title case

str_trim(b, side="both") # trim white spaces 

review_word_list <- str_split(review, " ")  
review_word_list

review_words <- unlist(review_word_list) # Unlist

str_detect(review, "!") # detect presence of '!' 

str_replace_all(review, "&", "L") # Replace specific char. - here replace & with "and"
str_replace_all(review, "[:punct:]", "") #remove punctuations
str_replace_all(review, "[0-9]", "") # Remove vistor number to just get the review
str_replace_all(review, "[a-z A-Z]", "") # Remove alphabets to just get the vistor number

####################################
#############Debugging##############
####################################

debug(largest_hypotenuse)
largest_hypotenuse(first, second)
largest_hypotenuse(first, second)

options(error = utils::recover) # not function specific

output <- tryCatch({hypotenuse(10, 'A')}, error=function(x){print(x)}, finally=print("Finally, print this!"))
output

####################################
###############Apply################
####################################

# apply(): row-wise sum for the first 3 columns-------------------------------------------------
apply(mtcars[, 1:3], 1, sum)  # sum of all columns by row




# apply(): column-wise sum --------------------------------------------
apply(mtcars[, 1:3], 2, sum)  # sum of all rows by column


ss <- function(mpg, cyl, disp){
  return(mpg^2) + (cyl^2) + (disp^2)
}

apply(mtcars, 1, FUN = ss) # Result is wrong

#Lapply
# 1. lapply() ----------------------------------------------------------
# lapply() applies a function to every item and returns the result as a list. 
# For example, Let use lapply to find the mean of each item in this list:
x <- list(a1 = 1:10, a2 = 100:105, a3 = 10:20)


# Use lapply() on a list
out <- lapply(x, mean) # calls list x and applies mean function

# 2. sapply() -----------------------------------------------------
# sapply() function returns either a vector or a matrix, whichever is suitable.
# Very similar to lapply(), but returns vector instead of list()
out_s <- sapply(x, mean)
out_s

# 2. sapply() -----------------------------------------------------
# sapply() function returns either a vector or a matrix, whichever is suitable.
# Very similar to lapply(), but returns vector instead of list()
out_s <- sapply(x, mean)

# 3. vapply () -------------------------------------------------------
# Fast version of sapply, but need to specify the format of output.
vapply(mtcars[, 1:4], mean, FUN.VALUE = numeric(1))  # vapply -- exactly similar to sapply. But, need to explicitly specify the datatype of the result output in FUN.value. So, it is faster.



# 4. mapply() ----------------------------------------------------
# mapply() is different from the rest of the apply functions.
# It applies any given function `FUN` over and over. The arguments of `FUN`
# are passed as arguments to mapply()

# example 1
mapply(sum, 1:4, 14:17)

#Exercice

# Solution ------------------------------------------------------------
second_largest <- function(x){
  x[order(-x)][2]
}


# 1
apply(mtcars, 2, second_largest)


# 2
sapply(mtcars, second_largest)


# 3
vapply(mtcars, second_largest, FUN.VALUE = numeric(1))


# 4
output <- lapply(mtcars, second_largest)
output
as.data.frame(output)

####################################
###############DATES################
####################################

mydate <- as.Date('1970-01-31')
mydate
class(mydate)

mydate <- strptime('1970-31-01', format = '%Y-%d-%m', tz = 'UTC')
mydate

#Convert the date into a str
mydatestring <- strftime(x=mydate, format = '%B %d, %Y')
mydatestring

#Date Operations
n_days_millenium <- as.Date('2029-12-31') - as.Date('2020-01-01')
n_days_millenium

#Date Functions
mydate <- as.Date('2029-12-31')
weekdays(mydate)   # day of week
months(mydate)     # name of month
quarters(mydate)   # quarter

#Date Sequence
##Day Sequences
day_Sequence   <- seq(as.Date('2020-01-01'), length.out = 36, by='day')
day_Sequence

##Month Sequences
month_Sequence <- seq(as.Date('2020-01-01'), length.out = 36, by='month')
month_Sequence

##Year Sequences
year_Sequence  <- seq(as.Date('2020-01-01'), length.out = 36, by='year')
year_Sequence

install.packages(c('lubridate', 'anytime'))
library(lubridate)
Sys.time()
class(Sys.time())


# Converting date strings to Date
d1 <- "2014-11-28"
d2 <- "2-19-11"
d3 <- "04 May 2016"
d4 <- "October 19th 2016"
d5 <- "2016-06-25 04:30:00"

# Convert these strings to POSIXct object:
d1 <- ymd(d1)
d2 <- mdy(d2)
d3 <- dmy(d3)
d4 <- mdy(d4)
d5 <- ymd_hms(d5)

# Automatically determine the date format
library(anytime)
d4 <- "04 May 2016"
d4 <- anydate(d4)
d4
class(d4)

# Operations possible on date now
nextday <- d1 + 1
d1
nextday

# Operations between date
receipt_date <- mdy("6-07-2016")
shipped_date <- mdy("5-24-2016")
ordered_date <- mdy("5-14-2016")

transportation_lead_time <- receipt_date - shipped_date
transportation_lead_time

total_lead_time <- receipt_date - ordered_date
total_lead_time

# That gives a text string, whose class is difftime:
class(total_lead_time) # difftime
as.numeric(total_lead_time)  # conversion to numeric format


# Time difference in any time unit.
difftime(receipt_date, shipped_date, unit="sec") #sec unit
difftime(receipt_date, shipped_date, unit="week") #week unit

# Given a date, extract the day of month, month of year etc. For example, the date d1 is:

day(receipt_date)  # the 28th day of month
month(receipt_date)  # falls on the 11th month of the year
months(receipt_date)  # if you want month in character
week(receipt_date)  # falls on the 48th week
weekdays(receipt_date)  # is a friday
quarter(receipt_date)  # falls on the 4th quarter
quarters(receipt_date) # alternate format of quarter - Q4
year(receipt_date) # find year 

install.packages('Hmisc')
library(Hmisc)

monthDays(receipt_date) #find number of days in month of d1
yearDays(receipt_date) # find the number of days in the year

####################################
###############VIZ################
####################################

plot(1:10, type = "b")
plot(1:10, type = "l")

plot(mtcars$wt, mtcars$mpg, main = "Titulo", xlab = "titulo x", ylab = "y titulo", pch = 3, col = "red", ylim = c(0,40), xlim = c(1,7),
lwd = 2, col.main = "blue", col.lab = "brown", col.axis = "orange", cex = 1.5, cex.axis = 3, cex.lab = 5)
#pch forma del puntero
#col.main el color de una parte especifica
#cex tamaño de partes
#lwd line width

text (4.5, 30, labels = "Car Makes", cex = 2, col = "red")

mtext("left margin", side = 4, cex = 1.5, at = 13, col = "red3")

legend("bottomright", inset = .01, title = "legend", legend = c("variable 1", "variable2"),
fill = "red", horiz = TRUE)

#sAVING PICTURE
png("titulo.png", height = 600, width = 600)

#Two viz in one

plot(year, population, type = "b", main = "titulo")

lines(year, gdp, type = "b", col = "red") #segunda linea

par(new = T)
par(mar = c(5,4,4,5)+ 0.1, bg = "wheat") #Margenes, background 

axis 4,ylim = c(30,60) #segundo axis del grafico

#Histogram
hist(mtcars$mpg, breaks = 5)
##Frecuancy table
mpg_new = cut(mtcars$mpg, breaks = c(0,10,15,20,25,30,35))
tl1 = table(mpg_new)
tl1

#Barplot
barplot(tb1, main = "MPG")

separadores = table(mtcars$cy1, mtcars$gear)
barplot(df, main = "MPG", xlab = "Number of Gears", col = c("tomato", "green", "blue"),
legend = rownames(separadores), beside=TRUE) #beside para que sea stack pero separados

#Boxplots
boxplot(mtcars$wt)
boxplot(mpg~cyl, data = mtcars) #el cyl es para agruparlo en esas categorias

#dotchart
mtcars = mtcars[order(mtcars$mpg)]
dotchart(mtcars$mpg, labels = row.names(mtcars), cex = .7, main = "MPG", xlab = "MPG", groups = variable)

#Density chart

plot(density(mtcars$mpg), main = "", xlab="", ylab="", axes = F)

hist(mtcars$mpg, probability=T)
lines(density(mtcars$mpg))

#Multiples charts
par(mfrow=c(2,2))

plot()
plot()
plot()

####################################
##############GGPLOT2###############
####################################

g = ggplot(dataset, aes(x = area, y=poptotal))
plot(g)

#############

g = ggplot(dataset) + geom_point(aes(x=area, y = poptotal))

############

g = ggplot(dataset, aes(x=area, y = poptoal)) + geom_point() + geom_smooth(method = "lm", se=FALSE) #quitar la sombra
plot(g)

g + xlim(c(0,0.1)) + ylim(c(0,1000000))
g + coord_cartesian(xlim=c(0,0.1), ylim(c(0,1000000))

g + labs(title="Area vs population", subtitle = "From midwest dataset",
y = "population", x = "area")

geom_point(aes(col=state, size = scale(variable), show.legend = F))

g + scale_colour_brewer(palette = "nombre")

g+scale_x_continuous(breaks = breakes)

g + theme_minimal()

g + geom_text(aes(label = large_country), size = 2, data = dataset)

g + geom_label_repel(aes(label = lague_country), size = 3, data = dataser, alpha = 0.9)

g + coord_flip()

g + scale_x_reverse()

g + annotation_custom(my_text) + theme(legend.position="None")

#######################

gg <- ggplot (midwest, aes (x=area, y=poptotal)) +
  geom_point (aes (col=state, size-popdensity)) +
  geom_smooth (method="Im", col="firebrick", se=F) +
  coord_cartesian (xlim=c(0, 0.1). ylim=c(0, 250000)) +
  labs (title= "Area vs Population", y= "population", x="Area")

gg + them(legend.position="none")
gg + theme(legend.position="left") #outside the plot

gg + theme(legend.justification = c(1,0), legend.position = c(1,0))

gg <- gg + theme (legend_title = element_text(size=12),
                                               color="firebrick"),
                  legend.text = element_text(size=10),
                  legend_key = element_rect(fill="gray") +
            guides(colour=guide_legend(override.aes = list(size=2,
                                                        stroke=1.5)))

g + facet_wrap(~ class, scales = "free")

g + facet_grid(~ class)

g=ggplot(mpg, aes(manufacturer)) + geom_bar(width = 0.5, fill ="steelblue")
g=ggplot(mpg, aes(manufacturer)) + geom_bar(width = 0.5, fill =class, positon = "dodge",
                                            scale_fill_brewer(palette="set3")))

g = ggplot(mpg, aes(cty))
g+geom_bar() + labs(title="Titulo")
g + geom_bar(stat="Indentity")

g + geom_histogram(binwidth = 15, bins = 100)

g = ggplot(mpg, aes(y=cty)) + geom_boxplot(aes(fill=class), width = 0.5) + labs(title="Boxplot")

g = ggplot(mpg, aes(y=cty)) + geom_violin(aes(fill=class), width = 0.5) + labs(title="Boxplot")

ggplot(ts, aes(data, value)) + geom_line(color = "firebrick") + labs(title="Titulo")
###############
#Dplyr
install.packages("dplyr")
library(dplyr)

output = mtcars %>%
  filter(hp>150)%>%
  group_by(cyl)%>%
  summarise_all(mean)%>%
  round(2)%>%
  transform(kpl = mpg * 0.42)
output

mtcars %>% filter(cyl==8) %$% cor(mpg,wt)

install.packages("magrittr")
library(magrittr)

rnorm(10) %T>% plot(main="Titulo") %>% sum 

oi = mtcars$mpg %<>% sqrt
oi

mtcars_t = as.tbl(mtcars)
mtcars_t

filter(mtcars_t, cyl > 3, wt<2)
mtcars_t %>% filter(cyl > 3, wt<2)

slice(mtcars_t, 4:10)

"["(mtcars_t, 1:5)

select(mtcars_t, hp, cyl)
select(mtcars_t, 1, 2)
select(mtcars_t, c(3,6))
select(mtcars_t, contains("cy"))
select(mtcars_t, starts_with("cy"))
select(mtcars_t, ends_with("cy"))

rename(mtcars_t, Cilindraje = cyl)

mtcars=)mutate(yearmonth = paste0(year, Month) %>% as.numeric,
                  date = paste0(yearmonth, DayofMonth))

mtcars=transmutemtcars, yearmonth = paste0(year, Month) %>% as.numeric)

mtcars_t %>% arrange(Year, desc(Month))

hflights_group = hflights %>% group_by(uniqueCarrier) %>% summarize(mean_dist = mean(Distance))

left_join(tb1, tb2, c("carname", "car"))

right_join(tb1, tb2, c("carname", "car"))

inner_join(tb1, tb2, c("carname", "car"))

full_join(tb1, tb2, c("carname", "car"))

semi_join(tb1, tb2, c("carname", "car"))

anti_join(tb1, tb2, c("carname", "car"))