
# Introduction to R and Starting with data --------------------------------


# installing the required packages
if (requireNamespace("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
}

# remotes package is used to install packages from remote repositories like GitHub other than CRAN and Bioconductor
if (requireNamespace("remotes", quietly = TRUE)) {
  install.packages("remotes")
}

BiocManager::install(c("tidyverse", "SummarizedExperiment", "hexbin",
                       "patchwork", "gridExtra", "lubridate"))

# dput(); it will output the R code that is required to generate the exact same object that you call
# iris is an example dataframe that comes with R

dput(head(iris))

# load the required packages
library(ggplot2)

# replicate function
rep(c(1,2,3), 5)

#What if we wanted to repeat the values 1, 2 and 3 five times, but obtain five 1s, five 2s and five 3s in that order? There are two possibilities - see ?rep or ?sort for help.
rep(c(1,2,3), each = 5, times = 1)
sort(rep(c(1,2,3), 5))

### Sequence generation
seq(from = 1, to = 20, by =2) # the default value of by is 1

seq(1, 5, 1)

# to generate a sequence of specific lenght
seq(from = 1, to = 20, length.out = 3)


### Random samples and Permutations
sample(1:10)

# generating a random sample of certain size
sample(letters, 5)

# If i wanted an vector larger than the input vector
# or being able to draw some elements multiple times
# I would need to set the "replace" argument true
sample(1:5, 10, replace = TRUE)

# setting the seed to particular number will help in reproducing the same result
set.seed(10)
sample(1:10)

# Normalized random number generation
rnorm(5)

rnorm(5,2,2)

rnorm(5, 100, 5)

### Data analysis with R

# downloading the file from the URL
download.file(url = "https://github.com/carpentries-incubator/bioc-intro/raw/main/episodes/data/rnaseq.csv",
              destfile = "data/rnaseq.csv")

# load the data
rna <- read.csv("data/rnaseq.csv")

# preview
rna
head(rna) # prints the first 5 rows of the data
View(rna) # outputs the data in the scipt editor

# NOTE: All the functions
# read.csv()
# read.delim()
# read.csv2()
# are wrapper functions for the function read.table()

# you can load the same above file in this manner as well
# rna <- read.table(file = "data/rnaseq.csv",
#                    sep = ",",
#                    header = TRUE)


# inspecting the structure of a dataframe
str(rna)
class(rna)

# other common functions related to dataframe class are 
dim(rna) # it will give you the dimensions of the datafram
nrow(rna) # number of rows of dataframe
ncol(rna) # number of columns in the dataframe

head(rna) #shows the first 6 rows
tail(rna) # shows the last 6 rows

names(rna) # returns the column names of the datafrma, it the synonym of colnames() for dataframe objects
rownames(rna) # returns the rownames

str(rna) # structure of object and information of class, lenght, and content of each column
summary(rna) # summary statistics of each column

### Indexing and subsetting the dataframes

# first element in the first column of the dataframe (as a vector)
rna[1,1]

# first element in the sixth column of the dataframe (as a vector)
rna[1,6]

# first column of the dataframe (as a vector)
rna[, 1]

# first column of a dataframe (as a dataframe)
rna[1]

# first three elements in the seventh column of the dataframe (as a vector)
rna[1:3, 7]

# the third row of dataframe (as a dataframe)
rna[3, ]

# equivalent to head_rna <- head(rna)
head_rna <- rna[1:6, ]
head_rna

# NOTE: ":" is a special function, that creates a numeric vector in increasing and decreasing order

## You can also exclude certain indices of the dataframe using the "-" sign

# the whole dataframe expect the first column
rna[,-1]

# Equivalent to head(rna)
rna[-c(7, 6967), ]

## dataframes can also be subsetted by calling their column names directly
rna["gene"] ## Result as a dataframe
rna[ ,"gene"] ## Result as a vector
rna[["gene"]] ## Result as a vector
rna$gene ## Result as a vector

### Challenge
# 1. Create a data.frame(rna_200) containing only the data in row 200 of rna dataset
rna_200 <- rna[200, ]
rna_200

# 2. Notice how nrow() gave you the number of rows in a dataframe?
nrow(rna)

# 2.1 Use that nrow() number to pull out that last row from the initial rna dataframe
rna[nrow(rna), ]

# 2.2 Compare that with what you see as the last row using tail() to make sure its meeting expectations
identical(rna[nrow(rna), ], tail(rna, 1))

# 2.3 Pull out that last row using nrow() instead of the row number.
# 2.4 Create a new dataframe (rna_last) from that last row
rna_last <- rna[nrow(rna), ]

# 3. Use nrow() to extract the row that is in the middle of the rna dataframe. Store the content of this row in an object named rna_middle
rna_middle <- rna[nrow(rna)/2, ]
rna_middle

# 4. Combine nrow() with the - notation above to reproduce the behavior of head(rna), keeping just the first through 6th rows of the rna dataset
rna[-(7:nrow(rna)), ]


## Factors 

sex <- factor(c("male", "female", "female", "male", "female"))

# NOTE: R will assign levels according to the alphabetical order
levels(sex)

nlevels(sex)

# if you want to specify the level orders, re-ordering of levels
sex <- factor(sex, levels = c("male", "female"))
sex

# when your data is stored as a factor, you can view the number of observations by using the plot function
plot(sex)

# Converting to character
as.character(sex)

# Renaming the factors
levels(sex) <- c("M", "F")

## Challenge
# 1. Rename "F" and "M" to male and female respectively
levels(sex) <- c("Male", "Female")

### Matrices

m <- matrix(1:9, ncol = 3, nrow = 3) # the values are sorted along the columns
m

## Challenge
# 1. Using the installed.packages(), create a character matrix containing all the installed packages in the environment

matrix_packages <- matrix(installed.packages(), ncol = 10)
dim(matrix_packages)

View(matrix_packages)

# 2. Construct a matrix of dimension 1000 by 3 of normally distributed data (mean 0, SD 1)
norm_matrix <- matrix(rnorm(3000), ncol = 3, nrow = 1000)


### Formatting dates

# we are using the ymd() from lubridate library
# Date is a class of data recognized by R as being a date and can be manipulated as such.
# The argument that the function requires is flexible, but, as a best practice, is a character vector formatted as “YYYY-MM-DD”
library(lubridate)

# ymd() takes a vector representing year, month, day, and converts it into a date vector
my_date <- ymd("1999-02-12")
str(my_date)

# now lets paste the year, month, and day seperately- we get the same result
my_date <- ymd(paste("1999", "02", "12", sep= "-"))
str(my_date)

# Date manipulation pipeline
x <- data.frame(year = c(1996, 1992, 1987, 1986, 2000, 1990, 2002, 1994, 1997, 1985),
                month = c(2,  3,  3, 10,  1,  8,  3,  4,  5,  5),
                day = c(24,  8,  1,  5,  8, 17, 13, 10, 11, 24),
                value = c(4,  5,  1,  9,  3,  8, 10,  2,  6,  7))
x

# We create a character vector from the year, month and day columns of x using paste()
paste(x$year, x$month, x$day, sep = "-")

# this character vector can be used as an argument for ymd()
ymd(paste(x$year, x$month, x$day, sep = "-"))

# the resulting date vector can also be added to the x as a new column called date
x$date <- ymd(paste(x$year, x$month, x$day, sep = "-"))
str(x)

# inspect the new column
summary(x)

# if you have the instance, day, month and year, you would need dmy()
dmy(paste(x$day, x$month, x$year, sep = "-"))


### Lists

# lets create a list containing a vector of numbers, characters, a matrix, a dataframe and another list
l <- list(1:10, # numeric
          letters, # character
          installed.packages, # a matrix
          cars, # a dataframe
          list(1,2,3)) # a list
length(l)

str(l)

# list subsetting is done using [] to subset a new sublist or [[]] to extract a single element of that list (using indices or names, if the list is named)
l[[1]] ## first element

# a list of lenght 2
l[1:2]

# a list of lenght 1
l[1]

### Exporting and saving the tabular data 

write.csv(rna, file = "data_output/my_rna.csv")


# Manipulating and analysing data with dplyr and tidyr --------------------

# load the tidyverse packages, incl. dplyr
library("tidyverse")

### load the data with tidyverse

# instead of read.csv(), we will read our data using the read_csv(), from the tidyverse package readr

rna <- read_csv("data/rnaseq.csv")

# view the data
rna

### Selecting the columns and filtering rows

# to select the columns of the dataframe, use select().
# The first argument is the dataframe, and the subsequent arguments are the columns

select(rna, gene, sample, tissue, expression)

# to select all the columns, expect certain ones, put a "-" in front of the variable to exclude it

select(rna, -tissue, -organism)

# to choose rows based on a specific condition, use filter()
filter(rna, sex == "Male")

# Add another conditon
filter(rna, sex == "Male" & infection == "NonInfected")

# subsetting only genes and  hsapiens_homolog_associated_gene_name in a new tibble called genes
genes <- select(rna, gene, hsapiens_homolog_associated_gene_name)
genes

# some mouse genes have no human homologs. These can be retrieved using filter() and the is.na() function, that determines whether something is an NA.
filter(genes, is.na(hsapiens_homolog_associated_gene_name))

# we can filter genes, where the homolog is present
filter(genes, !is.na(hsapiens_homolog_associated_gene_name))


### Pipes

# what if we want to filter and select at the same time
# three ways to do this is: intermediate steps, nested fucntions, pipes

# with intermediate steps

rna2 <- filter(rna, sex == "Male")
rna3 <- select(rna2, gene, sample, tissue, expression)
rna3

# with nested functions

rna3 <- select(filter(rna, sex == "Male"), gene, sample, tissue, expression)
rna3

# with pipes 
# Sending the output of one function to another by using Pipes

rna |> 
  filter(sex == "Male") |> 
  select(gene, sample, tissue, expression)

rna3 <- rna |> 
  filter(sex == "Male") |> 
  select(gene, sample, tissue, expression)
rna3


## challenge
# 1. Using pipes, subset the rna data to keep observations in female mice at time 0, where the gene has an expression higher than 50000, and retain only columns gene, sample, time, expression and age.

rna |> 
  filter(sex == "Female" & time == 0 & expression > 50000) |>
  select(gene, sample, time, expression, age)


### Mutate
# to create new columns from using information from the previously existing columsn

# to create new column of time in hours
rna |> 
  mutate(time_hours = time * 24) |> 
  select(time, time_hours)

# we can create a second new column, based on the first new column within the same call of mutate()
rna |> 
  mutate(time_hours = time * 24,
         time_mn = time_hours * 60) |> 
  select(time, time_hours, time_mn)


### Challenge
# Create a new dataframe from the rna data that meets the following criteria:
# contains only gene, chromosome_name, phenotype_description, sample, and expression columns.
# The expression values should be log-transformed.
# This dataframe must only contain, genes located on sex chromosomes, associated with a phenotype_description, and with a log expression higher than 5.
# Hint: think about how the commands should be ordered to produce this dataframe

rna_new <- rna |> 
  mutate(expression = log(expression)) |> 
  filter((chromosome_name == "X" | chromosome_name == "Y") &
           !is.na(phenotype_description) &
           expression > 5) |> 
  select(gene, chromosome_name, phenotype_description, sample, expression)

rna_new

# or you can do the above step as this as well
rna_new <- rna |> 
  mutate(expression = log(expression)) |> 
  select(gene, chromosome_name, phenotype_description, sample, expression) |> 
  filter(chromosome_name == "X" | chromosome_name == "Y") |> 
  filter(!is.na(phenotype_description)) |> 
  filter(expression > 5)
rna_new

### Split-apply-combine data analysis
# by the use of group_by function

# group the data by gene
rna |> group_by(gene)

# group the data by sample
rna |> group_by(sample)

### Summarise() function

# mean expresion levels of gene by gene
rna |> 
  group_by(gene) |> 
  summarise(mean_expression = mean(expression))

# mean expression levels of all genes by sample
rna |> 
  group_by(sample) |> 
  summarise(mean_expression = mean(expression))

# But we can also groupby multiple columns
rna |> 
  group_by(gene, infection, time) |> 
  summarise(mean_expression = mean(expression))

# Once the data is grouped, youc an also summarise multiple variabels at the same time (and not necessarily on the same variable)
# we could add a column indicating the median expression by gene and by condition

rna |> 
  group_by(gene, infection, time) |> 
  summarise(mean_expression = mean(expression),
            median_expression = median(expression))
  
## Challenge
# Calculate the mean expression level of gene "Dok3" by timepoints

rna |> 
  filter(gene == "Dok3") |> 
  select(gene, time, expression) |> 
  group_by(time) |> 
  summarise(mean_expression = mean(expression))

### Counting 
# count() to count the number of observations found for each factor or the combination of factors

rna |> count(infection)

# the above operation is equivalent to 
rna |> 
  group_by(infection) |> 
  summarise(n = n())

# If we want to count a combination of factors
# we would specify the first and the second factor as the arguments of count()

rna |> 
  count(infection, time)

# which is equivalent to 
rna |> group_by(infection, time) |> 
  summarise(n = n())

# arrange() to sort the table
rna |> 
  count(infection, time) |> 
  arrange(time)

# or by counts  
rna |> count(infection, time) |> 
  arrange(n)

# to sort in descending order
rna |> 
  count(infection, time) |> 
  arrange(desc(n))

### Challenge
#1. how many genes were analysed in each sample

rna |> 
  count(sample)

# 2. Use group_by() and summarise() to evaluate the sequencing depth(the sum of all counts) in each sample.
# which sample has the highest sequencing depth

rna |> 
  group_by(sample) |> 
  summarise(seq_depth = sum(expression)) |> 
  arrange(desc(seq_depth))

# 3. Pick one sample and evalaute the number of genes by biotype
rna |> 
  filter(sample == "GSM2545336") |> 
  count(gene_biotype) |> 
  arrange(desc(n))

# 4. Identify genes associated with the "abnormal DNA methylation" phenotype description, and calcualte thier mean expression(in log) at time 0, time 4 and time 8.
rna |> 
  filter(phenotype_description == "abnormal DNA methylation") |> 
  group_by(gene, time) |> 
  summarise(mean_expression = mean(log(expression))) |> 
  arrange()


### Reshaping the data

rna |> 
  arrange(gene)

## Pivoting the data into wider format

# lets select 3 columns of rna data and use pivot_wider() to transform the data into a wide format

rna_exp <- rna |> 
  select(gene, sample, expression)
rna_exp

# pivot_wider takes three main arguments
  # 1. the data to be transformed
  # 2. the names_from: the column whose values will become new column names
  # 3. the values_from: the column whose values will fill the new columns

rna_wide <- rna_exp |> 
  pivot_wider(names_from = sample,
              values_from = expression)

rna_wide

# Note: by default the pivot_wider() will add NA for missing values
# for eg. In the following fictive example, the gene Cyp2d22 has only one expression value, in GSM2545338 sample.

rna_with_missing_values <- rna |> 
  select(gene, sample, expression) |> 
  filter(gene %in% c("Asl", "Apod", "Cyp2d22")) |> 
  filter(sample %in% c("GSM2545336", "GSM2545337", "GSM2545338")) |> 
  arrange(sample) |> 
  filter(!(gene == "Cyp2d22" & sample != "GSM2545338"))

rna_with_missing_values

# now by default pivot_wider() will add NA to missing values
rna_with_missing_values |> 
  pivot_wider(names_from = sample,
              values_from = expression)

# this can be parameterized with the values_fill arguement
rna_with_missing_values |> 
  pivot_wider(names_from = sample,
              values_from = expression,
              values_fill = 0)

## Pivoting the data into longer format
# It is the opposite of pivot wider 

# pivot_longer() takes four main arguments:
  #1. the data to be transformed
  #2. the names_to: the new column name we wish to create and populate them with the current column names;
  #3. the values_to: the new column name we wish to create and populate with current values
  #4. the names of the columns to be used to populate the names_to and values_to variables(or to drop)

rna_long <- rna_wide |> 
  pivot_longer(names_to = "sample",
               values_to = "expression",
               -gene)
rna_long

# We would also have used a specification for what columns to include.
# this can be useful if you have a large number of identifying columns, and its easier to specify what to gather than what to leave alone.

rna_wide |> 
  pivot_longer(names_to = "sample",
               values_to = "expression",
               cols = starts_with("GSM"))

# this can also be done by using the ":" operator
rna_wide |> 
  pivot_longer(names_to = "sample",
               values_to = "expression",
               GSM2545336:GSM2545380)

## NOTE: if we had missing values in the wide format the NA will be included in the long format aswell

# eg:
rna_with_missing_values

wide_with_NA <- rna_with_missing_values |> 
  pivot_wider(names_from = sample,
              values_from = expression)
wide_with_NA

# now by taking wide_with_NA creating a longer format
wide_with_NA |> 
  pivot_longer(names_to = "sample",
               values_to = "expression",
               -gene)

### Challenge

  #1. starting from the rna table, use the pivot_wider() to create a wide-format table giving the gene expression levels in each mouse.
  # then use the pivot_longer() to restore a long-format table.

rna_wide_2 <- rna |> 
  select(gene, mouse, expression) |> 
  pivot_wider(names_from = mouse,
              values_from = expression)
rna_wide_2

rna_long_2 <- rna_wide_2 |> 
  pivot_longer(names_to = "mouse_id",
               values_to = "counts",
               -gene)
rna_long_2

  #2. subset the genes located on X and Y chromosomes from the RNA dataframe
  # and spread the dataframe with sex as columns, chromosome_name as rows, and the mean expression of genes located in each chromosome as values
  
rna_sex_ch_wide <- rna |> 
  filter(chromosome_name == "X" | chromosome_name == "Y") |> 
  select(chromosome_name, sex, expression) |> 
  group_by(chromosome_name, sex) |> 
  summarise(mean_expression = mean(expression)) |> 
  pivot_wider(names_from = sex, 
              values_from = mean_expression)

  #3. Now take the above rna_sex_ch_wide dataframe and transform it with pivot_longer() so each row is unique chromosome_name by gender combination
rna_sex_ch_long <- rna_sex_ch_wide |> 
  pivot_longer(names_to = "gender",
               values_to = "mean",
               -chromosome_name)
rna_sex_ch_long

  #4. Use the rna dataset to create an expression matrix where each row repressents the mean expression levels of genes and columns represent the different timepoints
rna_time_wide <- rna |> 
  select(gene, time, expression) |> 
  group_by(gene, time) |> 
  summarise(mean = mean(expression)) |> 
  pivot_wider(names_from = time,
              values_from = mean) 
rna_time_wide

  #5. Use the previous data frame containing mean expression levels per timepoint and create a new column containing fold changes
  # between timepoint 8 and 0
  # between timepoint 8 and 4
  # convert this table into a long-format table gathering the fold changes calculated

rna_time_wide |> 
  mutate(time_8_vs_0_fc = `8`/`0`, time_8_vs_4_fc = `8`/`4`) |> 
  pivot_longer(names_to = "comparisons",
               values_to = "fold_change",
               time_8_vs_0_fc: time_8_vs_4_fc)

### Joining tables

# We are going to illustrate the join using a small table, rna_mini that we will be create by subsetting the original rna table, keeping only 3 columns and 10 lines

rna_mini <- rna |> 
  select(gene, sample, expression) |> 
  head(10)
rna_mini

# the second table, annot1, contains 2 columns, gene and gene_description.

download.file(url = "https://carpentries-incubator.github.io/bioc-intro/data/annot1.csv",
              destfile = "data/annot1.csv")
annot1 <- read_csv(file = "data/annot1.csv")
annot1

# Joining two tables into a single one containing all variables using the full_join() from the dplyr package
# the function will automatically find the common variable to match columns from the first and second table.
# In this case, gene is the common variable, such variables are called keys.
# Keys are used to match observations accross different tables.

full_join(rna_mini, annot1)

# NOTE: In real life, gene annotations are sometimes labelled diffently
# The annot2 table is exactly the same than annot1, except that the variable containing the gene name is labelled differently.

download.file(url = "https://carpentries-incubator.github.io/bioc-intro/data/annot2.csv",
              destfile = "data/annot2.csv")
annot2 <- read_csv(file = "data/annot2.csv")
annot2

## Here we can set manually, the variables used for the matching 
# These variables can be set using the 'by' argument
# the variable name in the first table is retained in the joined one

full_join(rna_mini, annot2, by = c("gene" = "external_gene_name"))

### Challenge

  #1. Download the annot3 table by "https://carpentries-incubator.github.io/bioc-intro/data/annot3.csv"
  # Using the full_join(), join tables rna_mini and annot3
  # What has happened for genes Klk6, mt-Tf, mt-Rnr1, mt-Tv, mt-Rnr2, and mt-Tl1 ?

download.file(url = "https://carpentries-incubator.github.io/bioc-intro/data/annot3.csv",
              destfile = "data/annot3.csv")
annot3 <- read_csv(file = "data/annot3.csv")
annot3

full_join(rna_mini, annot3)

### Exporting the data 

write_csv(rna_wide, file = "data_output/rna_wide.csv")


# Data Visualization ----------------------------------------------------


### Objectives
# Produce scatter plots, box plots, line plots etc using ggplot
# Set universal plot settings
# Describe what faceting is and apply faceting in ggplot
# Modify the aesthetics of an existing ggplot plot (including axis labels and color)
# Build complex and customized plots from data in a dataframe

# We start by loading the required packages.
# ggplot2 is included in the tidyverse package

library("tidyverse")

# if not in the workspace, load the  data we saved in the previous section

rna <- read_csv("data/rnaseq.csv")

# use the ggplot() and bind the plot to a specific dataframe using the data argument

ggplot(data = rna)

# Define a mapping using the aesthetic(aes) function,
# by selecting the variables to be plotted and specifying how to present them in the graph;
# eg. as x/y positions or characteristics such as size, shape, color etc

ggplot(data = rna, mapping = aes(x = expression))

# add 'geoms' - geometries, or graphical representations of data in the plot(points, bars, lines)
# ggplot2 offers many different geoms; we will use some common ones,
# * geom_point() - for scatter plots, dot plots, etc.
# * geom_histogram() - for histograms
# * geom_boxplots() - for well, boxplots!
# * geom_line() - for trend lines, time series, etc.

# to add the geom(etry) to the plot use the '+' operator.

# Lets use the geom_histogram() first; 

ggplot(data = rna,
       mapping = aes(x = expression)) +
  geom_histogram()

# The '+' in the ggplot2 package is particularly useful because it allows you to modify the existing ggplot objects.
# This means you can easily set up the plot templates and conveniently explore diffrent types of plots,
# So the above plot can also be assigned to a variable and explored like this

# assign plot to a variable
rna_plot <- ggplot(data = rna, 
                   mapping = aes(x = expression))

# draw the plot
rna_plot + geom_histogram()


### Challenge
  # 1. Change the arguments of bins or binwidth of the geom_histogram() to change the number or width of the bins.

# change the bins
rna_plot  + geom_histogram(bins = 10)

# change the binwidth
rna_plot  + geom_histogram(binwidth = 1000)

# We can observe here that the data are skewed to the right.
# We can apply log2 transformation to have a more symmetric distribution.
# Note that we can add here a small constant value(+1) to avoid having -Inf values  for the expression values equal to 0

rna <- rna |> 
  mutate(expression_log = log2(expression + 1))

# If we draw a histogram of the log2 transformed expression, the distribution is indeed closer to the normal distribution
ggplot(rna, aes(x = expression_log)) +
  geom_histogram()

# NOTE: from now we will be working on the log transformed expresssion values

### Challenge

# Another way to visualize this transformation is to consider the scale of the observation.
# For eg. it may be worth changing the scale of the axis to better distribute the observations in the space of the plot.
# changing the scale of the axes is done similarly to add/modifying other components(i.e., by incrementally adding commands). Let's try making this modification:

  #1. Represent the un-transformed expression on the log10 scale;
  # see scale_x_log10(). Compare it with the previous graph why do you now have warning messages appearing?

ggplot(rna, aes(x = expression)) +
  geom_histogram() +
  scale_x_log10()

### Building plot iteratively

# We will not draw a scatter plot with continuous variables and the geom_point().
# This graph will represent the log2 fc of expression comparing time 8 vs time 0, and time 4 vs time 0.
# To this end, we first need to compute the means of the log-transformed expression values by gene and time, then the log fold changes by substracting the mean log expressions between time 8 and 0 and between time 4 and 0.
# Note, that we also include here gene biotype that we will use later on to represent genes.
# We will save the fold changes in a new dataframe called rna_fc

rna_fc <- rna |> select(gene, time, gene_biotype, expression_log) |> 
  group_by(gene, time, gene_biotype) |> 
  summarise(mean_exp = mean(expression_log)) |> 
  pivot_wider(names_from = time, 
              values_from = mean_exp) |> 
  mutate(time_8_vs_0 = `8` - `0`, 
         time_4_vs_0 = `4` - `0`)

# We can now build a ggplot with a newly created dataset rna_fc.
# Building plots with ggplot2 is typically an iterative precess.
# We start by defining the dataset we'll use, lay out the axes and choose a geom

ggplot(data = rna_fc,
       mapping = aes(x = time_4_vs_0,
                     y = time_8_vs_0)) +
         geom_point()

# We can start to modify this plot to extract more information from it.
# For instance, we can add trasnparenccy (alpha) to avoid overplotting:

ggplot(data = rna_fc, mapping = aes(x = time_4_vs_0,
                                    y = time_8_vs_0)) +
  geom_point(alpha = 0.3)

# We can also add colors for the point

ggplot(data = rna_fc,
       mapping = aes(x = time_4_vs_0,
                     y = time_8_vs_0)) + 
  geom_point(alpha = 0.3, color = "blue")

# We can also color each gene in the plot differently, you can use a vector as an input to the argument color.
# ggplot2 will provide a different color corresponding to different values in the vector.
# Here is an example where we color with gene biotype

ggplot(data = rna_fc,
       mapping = aes(x = time_4_vs_0,
                     y = time_8_vs_0)) +
  geom_point(alpha = 0.3, aes(color = gene_biotype))

# we can also specify the colors directly inside the mapping provided in the ggplot function.
# This will be seen by any geom layers and the mapping will be determined by the x- and y- axis set up in aes()

ggplot(data = rna_fc,
       mapping = aes(x = time_4_vs_0,
                     y = time_8_vs_0,
                     color = gene_biotype)) +
  geom_point(alpha = 0.3)

# We can also add a diagonal line with the geom_abline()

ggplot(data = rna_fc,
       mapping = aes(x = time_4_vs_0,
                     y = time_8_vs_0,
                     color = gene_biotype)) +
  geom_point(alpha = 0.3) +
  geom_abline(intercept = 0)

# Notice we can change the geom layer from geom_point() to geom_jitter() and colors will still be determined by gene_biotype
# geom_jitter(); in this geom the data points are slightly displaced for better visualization 

ggplot(data = rna_fc,
       mapping = aes(x = time_4_vs_0,
                     y = time_8_vs_0,
                     color = gene_biotype)) +
  geom_jitter(alpha = 0.3) +
  geom_abline(intercept = 0)

### Challenge

# Scatter plots can be useful exploratory tools for small datasets.
# For datasets with large number of observations, such as rna_fc, overplotting of points can be a limitation of scatter plots.
# One strategy of handling such settings is to use hexagonal binning of observations.
# The plot space is tessellated into hexagons. 
# Each hexagon is assigned a different color based on the number of observations that fall within its boundaries.

# to use hexagonal binning in ggplot2, first install the R package hexbin from CRAN and load it
install.packages("hexbin")

library(hexbin)

# using the geom_hex() to the hexbin figure
ggplot(data = rna_fc, 
       mapping = aes(x = time_4_vs_0,
                     y = time_8_vs_0,
                     color = gene_biotype)) +
  geom_hex() +
  geom_abline(intercept = 0)

### Boxplots

# We can use boxplots to visualize the distribution of gene expressions within each sample

ggplot(data = rna, 
       mapping = aes(x = sample,
                     y = expression_log)) +
  geom_boxplot()

# By adding points to boxplots, we can have a better idea of the number of measurements and their distribution
ggplot(data = rna, 
       mapping = aes(x = sample,
                     y = expression_log)) +
  geom_jitter(alpha = 0.2, color = 'tomato') +
  geom_boxplot(alpha = 0)

### challenge

  #1. Note how the box plot layer is in front of the jitter plot. 
  # what do we need to change to put the boxplot below the points

ggplot(data = rna, 
       mapping = aes(x = sample,
                     y = expression_log)) +
  geom_boxplot(alpha = 0) +
  geom_jitter(alpha = 0.1, color = 'tomato')

# Lets change the orientation of the labels and adjust them vertically and horizontally so that they do not overlap.
# You can use a 90 degree angle, or experiment to find the appropriate angel for daigonally oriented labels

ggplot(data = rna,
       mapping = aes(x = sample,
                     y = expression_log)) +
  geom_jitter(alpha = 0.2, color = "tomato") +
  geom_boxplot(alpha = 0) +
  theme(axis.text.x = element_text(angle = 90, hjust = 0.5, vjust = 0.5))

### Challenge
  #1. Add color to the data points on your boxplot according to the duration of of the infection(time).
  # Hint: check the class for time, consider changing the class of time from integer to factort directly in the ggplot mapping. 

# time variable as integer
# the color is applied as a gradient starting from 0 to 8
ggplot(data = rna, 
       mapping = aes(x = sample, 
                     y = expression_log)) +
  geom_jitter(alpha = 0.2, aes(color = time)) +
  geom_boxplot(alpha = 0) +
  theme(axis.text.x = element_text(angle = 90,
                                   vjust = 0.5,
                                   hjust = 0.5))

# time variable as a factor
# it assigns distinct color for each time point rather than a gradient of colors

ggplot(data = rna, 
       mapping = aes(x = sample, 
                     y = expression_log)) +
  geom_jitter(alpha = 0.2, aes(color = as.factor(time))) +
  geom_boxplot(alpha = 0) +
  theme(axis.text.x = element_text(angle = 90,
                                   vjust = 0.5,
                                   hjust = 0.5))

 
  #2. Boxplots are useful summaries,  but hide the shape of the distribution.
  # For eg. if the distribution is bimodal, we would not not see that in boxplot.
  # An alternative to the boxplot is the violin plot, where the shape(of the density of points) is drawn.
  # Replace the boxplot with a violin plot; see geom_violin().
  # Fill in the violins according to the time with the argument fill.

ggplot(data =  rna,
       mapping = aes(x = sample,
                     y = expression_log)) +
  geom_violin(aes(fill = as.factor(time))) + 
  theme(axis.text.x = element_text(angle = 90,
                                   v = 0.5,
                                   h = 0.5))

  # Modify the violin plot, to fill the violins by sex
ggplot(data = rna,
       mapping = aes(x = sample,
                     y = expression_log)) +
  geom_violin(aes(fill = sex)) +
  theme(axis.text.x = element_text(angle = 90,
                                   vjust = 0.5,
                                   hjust = 0.5))


### Line plots

# lets calculate the mean expression of per duration of the infection for the 10 genes having the highest log fold changes comparing time 8 vs 0.
# First, we need to select the genes and create a subset of rna called sub_rna containing the 10 selected genes. 
# then we need to group the data and calculate the mean gene expression within each group

rna_fc <- rna_fc |> arrange(desc(time_8_vs_0))

genes_selected <- rna_fc$gene[1:10]

sub_rna <- rna |> filter(gene %in% genes_selected)

mean_exp_by_time <- sub_rna |> group_by(gene, time) |> 
  summarise(mean_exp = mean(expression_log))

mean_exp_by_time

# We can build line plot with duration of infection on the x-axis and the mean expression on the y-axis

ggplot(data = mean_exp_by_time,
       mapping = aes(x = time,
                     y = mean_exp)) +
  geom_line()

# unfortunately, this does not work because we plotted data for all the genes together. 
# We need to tell ggplot to draw a line for each gene by modifying the aes() to include group = gene

ggplot(data = mean_exp_by_time,
       mapping = aes(x = time,
                     y = mean_exp,
                     group = gene)) +
  geom_line()

# We will be able to distinguish genes in the plot if we add color(using color also automatically groups the data)
ggplot(data = mean_exp_by_time,
       mapping = aes(x = time, 
                     y = mean_exp,
                     color = gene)) +
  geom_line()


### Faceting 

# line plot across time for each gene

ggplot(data = mean_exp_by_time,
       mapping = aes(x = time,
                     y = mean_exp)) +
  geom_line() +
  facet_wrap(~gene)

# In the above plot, both x and y axis have the same scale for all the subplots. You can change this default behavior by modifying scales in order to allow a free scale for y-axis

ggplot(data = mean_exp_by_time,
       mapping = aes(x = time,
                     y = mean_exp)) +
  geom_line() +
  facet_wrap(~gene, scales = "free_y")

# Now we would like to split the line in each plot by the sex of the mice.
# To do that we need to calculate the mean expression in the dataaframe grouped by gene, sample and sex:

mean_exp_by_time_sex <- sub_rna |> 
  group_by(gene, time, sex) |> 
  summarise(mean_exp = mean(expression_log))

mean_exp_by_time_sex

# Now we can make the faceted plot by splitting further by sex using color(within a single plot)

ggplot(data = mean_exp_by_time_sex,
       mapping = aes(x = time, 
                     y = mean_exp, 
                     color = sex)) +
  geom_line() +
  facet_wrap(~gene, scales = "free_y")

# Usually plots with white background look more readable when printed,
# we can set the background to white using the function theme_bw().
# additionally we can remove the grid as well

ggplot(data = mean_exp_by_time_sex,
       mapping = aes(x = time,
                     y = mean_exp, 
                     color = sex)) +
  geom_line() +
  facet_wrap(~gene, scales = "free_y") +
  theme_bw() +
  theme(panel.grid = element_blank())


### Challenge

  #1. Use what you just learned to create a plot that depicts how the average expression of each chromosome changes through the duration of infection

mean_exp_by_chromosome <- rna |> 
  group_by(chromosome_name, time) |> 
  summarise(mean_exp = mean(expression_log))

ggplot(data = mean_exp_by_chromosome,
       mapping = aes(x = time,
                     y = mean_exp,
                     )) +
  geom_line() +
  facet_wrap(~chromosome_name, scales = "free_y")

# Note:
# Facet_wrap() geometry extracts plots inta an arbitrary number of dimensions to allow them to cleanly fit on one page.
# On the other hand, facet_grid geometry allows you to explicitly specify how you want your plots to be arranged via a simple formula notation (rows~columns ; a . can be a place holder that indicates only one row or column)

# one column, facet by rows
ggplot(data = mean_exp_by_time_sex,
       mapping = aes(x = time, 
                     y = mean_exp,
                     color = gene)) +
         geom_line() +
         facet_grid(sex ~ .)

# one row, facet by column
ggplot(data = mean_exp_by_time_sex,
       mapping = aes(x = time,
                     y = mean_exp,
                     color = gene)) +
  geom_line() +
  facet_grid(. ~ sex)

### ggplot2 themes

# theme_minimal() and theme_light() are popular,
# theme_void() can be useful as a starting point to create a new handcrafted theme.

### Customization

# Now we can change names of axes to something more informative than 'time' and 'mean_exp', and add a title to the figure

# element_blank() tells ggplot2 not to draw that particular graphical element.
# it removes grid lines fromt the panels

ggplot(data = mean_exp_by_time_sex,
       mapping = aes(x = time,
                     y = mean_exp,
                     color = sex)) +
  geom_line() +
  facet_wrap(~gene, scales = 'free_y') +
  theme_bw() +
  theme(panel.grid = element_blank()) +
  labs(title = "Mean gene expression by duration of Infection",
       x = "Duration of the infection(in days)",
       y = "Mean gene expression")

# the axes have more informative names, but thier readability can be improved by increasing the font size

ggplot(data = mean_exp_by_time_sex,
       mapping = aes(x = time,
                     y = mean_exp,
                     color = gene)) +
  geom_line() +
  facet_wrap(~gene, scales = "free_y") +
  theme_bw() +
  theme(panel.grid = element_blank()) +
  labs(title = "Mean gene expression by duration of Infection",
       x = "Duration of Infection(in days)",
       y = "Mean gene expression") +
  theme(text = element_text(size=16))


## NOTE: It is possible to change the font of your plots. If you are on windows, you may have to install the 'extrafont' package.

# We can futher customize the color of x and y axis text, the color of the grid, etc.
# We can also for example, we can move the legend on the top by setting legend.position = "top.

# axis.text.x controls the appearance of the X-axis tick labels
# axis.text.y controls the appearance of the Y-axis tick labbels
# text argument sets the text size for text elements throughout the plot
# axis.text.x and axis.text.y override the settings given by "text" argument settings 

ggplot(data = mean_exp_by_time_sex,
       mapping = aes(x = time,
                     y = mean_exp,
                     color = sex)) +
  geom_line() +
  facet_wrap(~gene, scales = "free_y") +
  theme_bw() +
  theme(panel.grid =  element_blank()) +
  labs(title = "Mean gene expression by duration of infection",
       x = "Duration of the Infection(in days)",
       y = "Mean gene expression") +
  theme(text = element_text(size = 16),
        axis.text.x = element_text(color = "royalblue4", size = 12),
        axis.text.y = element_text(color = "royalblue4", size = 12),
        panel.grid = element_line(color = "lightsteelblue1"),
        legend.position = "top")
  
# if you like the changes that you created better than the default theme,
# you can save them as an object to be able to easily apply them to other plots you may create.
# here is an histogram we have previously created

# panel.grid refers both major and minor grid lines

blue_theme <- theme(axis.text.x = element_text(color = "royalblue4",
                                               size = 12),
                    axis.text.y = element_text(color = "royalblue4",
                                               size = 12),
                    text = element_text(size = 16),
                    panel.grid = element_line(color = "lightsteelblue1"))


ggplot(rna, aes(x = expression_log)) +
  geom_histogram(bins = 20) +
  blue_theme

### Challenge

  # With all the information in hand, please either improve one of the plots generated in this exercise or create a beautiful graph of your own. 
  
#1. See if you can change the thickness of the lines?
#2. Can you find a way to change the name of the legend? What about labels? (hint: look for a ggplot function starting with scale_)
#3. Try using a different color palatte or manually specifying the colors for the lines.

# For eg. based on this plot

ggplot(data = mean_exp_by_time_sex,
       mapping = aes(x = time, 
                     y = mean_exp,
                     color = sex)) +
  geom_line() +
  facet_wrap(~gene, scales = "free_y") +
  theme_bw() +
  theme(panel.grid = element_blank())

# we can customize in the following ways

#1. change the thickness of the lines
ggplot(data = mean_exp_by_time_sex,
       mapping = aes(x = time,
                     y = mean_exp,
                     color = sex)) +
  geom_line(linewidth = 1.5) + 
  facet_wrap(~gene, scales = "free_y") +
  theme_bw() +
  theme(panel.grid = element_blank())
  
#2. Changing the name of the legend and the labels
ggplot(data = mean_exp_by_time_sex,
       mapping = aes(x = time,
                     y = mean_exp,
                     color = sex)) +
  geom_line(linewidth = 1.5) +
  facet_wrap(~gene, scales = "free_y") +
  theme_bw() +
  theme(panel.grid = element_blank()) +
  scale_color_discrete(name = "Gender", labels = c("F", "M")) # this function assigns colors directly to the categorical variables

#3. Using a different color palatte
ggplot(data = mean_exp_by_time_sex,
       mapping = aes(x = time,
                     y = mean_exp,
                     color = sex)) +
  geom_line(linewidth = 1.5) +
  facet_wrap(~gene, scales = "free_y") +
  theme_bw() +
  theme(panel.grid = element_blank()) +
  scale_color_brewer(name = "Gender",labels = c("F", "M"), palette = "Dark2") # this function assigns colors according to the colorpalette mentioned

#4. manually specifying the colors
ggplot(data = mean_exp_by_time_sex,
       mapping = aes(x = time,
                     y = mean_exp,
                     color = sex)) +
  geom_line(linewidth = 1.5) +
  facet_wrap(~gene, scales = "free_y") +
  theme_bw() +
  theme(panel.grid = element_blank()) +
  scale_color_manual(name = "Gender",
                     labels = c("F", "M"),
                     values = c("royalblue", "deeppink")) # this function assigns color mentioned manually to categorical variables

# changing the legend position
ggplot(data = mean_exp_by_time_sex,
       mapping = aes(x = time,
                     y= mean_exp,
                     color = sex)) +
  geom_line(linewidth = 1.5) +
  facet_wrap(~gene, scales = "free_y") +
  theme_bw() +
  theme(panel.grid = element_blank(),
        legend.position = "top") +
  scale_color_manual(name = "Gender",
                     labels = c("F", "M"),
                     values = c("royalblue",
                                "deeppink"))


### Composing plots

# Let's start creating two plots that we want to plot next to each other 

# The first graph counts the number of unique genes per chromosome.
# we first need to reorder the levels of chromosome_name and filter the unique genes per chromosome.
# We also change the scale of the y-axis to a log10 scale for better readability

rna$chromosome_name <- factor(rna$chromosome_name, levels = c(1:19, "X", "Y"))

count_gene_chromosome <- rna |> 
  select(chromosome_name, gene) |> 
  distinct() |> ggplot() +
  geom_bar(aes(x = chromosome_name),
           fill = "seagreen",
           position = "dodge",
           stat = "count") +
  labs(y = "log10(n genes)", x = "chromosome") +
  scale_y_log10()

count_gene_chromosome

# another plot
exp_boxplot_sex <- ggplot(rna, aes(x = as.factor(time),
                                   y = expression_log,
                                   color = sex)) +
  geom_boxplot(alpha = 0) +
  labs(x = "time",
       y = "Mean gene exp") +
  theme(legend.position = "none")

exp_boxplot_sex

## The "patchwork" package 
# provides an elegant approach to combining figures using "+" to arrange figures(typically side by side).
# More specifically "|" explicitly arranges them side by side 
# "/" stacks them on top of another

install.packages("patchwork")
library(patchwork)

count_gene_chromosome + exp_boxplot_sex

#or

count_gene_chromosome / exp_boxplot_sex

# We can combine further control the layout of the final composition with 'plot_layout' to create more complex layouts:

count_gene_chromosome + exp_boxplot_sex + plot_layout(ncol = 1)

#or

count_gene_chromosome +
  (count_gene_chromosome + exp_boxplot_sex) +
  exp_boxplot_sex +
  plot_layout(ncol = 1)

#The last plot can also be created using the | and / composers:

count_gene_chromosome /
  (count_gene_chromosome | exp_boxplot_sex) /
  exp_boxplot_sex

### gridExtra package
# it allows to combine separate ggplots into a single figure using grid.arrange() 

install.packages("gridExtra")
library(gridExtra)

grid.arrange(count_gene_chromosome, exp_boxplot_sex,
             ncol = 2)

### Exporting plots

# ggsave(), which allows you to easily change the dimensions and resolution of the plot by adjusting the appropriate arguments(width, height, and dpi)

my_plot <- ggplot(data = mean_exp_by_time_sex,
                  mapping = aes(x = time,
                                y = mean_exp,
                                color = sex)) +
  geom_line() +
  facet_wrap(~gene, scales = "free_y") +
  labs(title = "Mean gene expression by duration of infection",
       x = "Duration of the infection(in days)",
       y = "Mean gene expression") +
  guides(color = guide_legend(title = "Gender")) +
  theme_bw() +
  theme(axis.text.x = element_text(color = "royalblue4", size = 12),
        axis.text.y = element_text(color = "royalblue4", size = 12),
        text = element_text(size = 16),
        panel.grid = element_blank(),
        legend.position = "top")

ggsave("fig_output/mean_exp_by_time_sex.png",
       my_plot,
       width = 15,
       height = 10)


# this also works for grid.arrange() plots
combo_plot <- grid.arrange(count_gene_chromosome,
                           exp_boxplot_sex,
                           ncol = 2,
                           widths = c(4, 6))

ggsave("fig_output/combo_plot_chromosome_sex.png",
       combo_plot,
       width = 10,
       dpi = 300)

## NOTE: the parameters width and height determine the font size in the saved plot

### Other packages for visualization

# Base R graphics package

par(mfrow = c(1, 3))
plot(1:20, main = "First layer, produced with plot(1:20)")

plot(1:20, main = "A horizontal red line, added with abline( h = 10)")
abline(h = 10, col = "red")

plot(1:20, main = "A rectangle, added with rect(5,5,15,15)")
abline(h = 10, col = "red")
rect(5, 5, 15, 15, lwd = 3)

### NOTE: Base R graphics, they will adapt the plotting behavior based on the class of the input datatype.

par(mfrow = c(2,2))
boxplot(rnorm(100),
        main = "Boxplot of rnorm(100)")

boxplot(matrix(rnorm(100), ncol = 10),
        main = "Boxplot of matrix(rnorm(100), ncol = 10)")

hist(rnorm(100))
hist(matrix(rnorm(100), ncol = 10))


# Bioconductor and Summarized Experiment ----------------------------------

## Creating a summarized Experiment

# In order to create SummarizedExperiments, we will create individual components
# i.e the count matrix, the sample adn gene metadata from csv files.
# These are typically how RNA-seq data are provided(after raw data have been processed)

# An expression Matrix: we load the count matrix, specifying that the first columns contains row/gene names, and convert the data.frame to a matrix.
# You can download it by link; https://carpentries-incubator.github.io/bioc-intro/data/count_matrix.csv

count_matrix <- read.csv("data/count_matrix.csv", row.names = 1) |> 
  as.matrix()

count_matrix[1:5, ]

dim(count_matrix)

# A table describing the samples, available in this link: https://carpentries-incubator.github.io/bioc-intro/data/sample_metadata.csv

sample_metadata <- read.csv("data/sample_metadata.csv")
sample_metadata

dim(sample_metadata)

# A table describing genes, available at this link; https://carpentries-incubator.github.io/bioc-intro/data/gene_metadata.csv

gene_metadata <- read.csv("data/gene_metadata.csv")
gene_metadata[1:10, 1:4]

### We will create a SummarizedExperiment from these tables that we have created,
# - The count matrix that will be used as the assay
# - The table describing the samples will be used as the sample metadata slot
# - The table describing the genes will be used as the features metadata slot

# To do this we can put the different parts together using the SummarizedExperiment constructor:

BiocManager::install("SummarizedExperiment")
library(SummarizedExperiment)

# First we will make sure that the samples are in the same order in the count matrix and the sample annotation,
# and teh same for the genes in the count matrix and the gene annotation

stopifnot(rownames(count_matrix) == gene_metadata$gene)

stopifnot(colnames(count_matrix) == sample_metadata$sample)

se <- SummarizedExperiment(assays = list(counts = count_matrix),
                           colData = sample_metadata,
                           rowData = gene_metadata)
se

# Saving the reading the R data objects efficiently

saveRDS(se, file = "data_output/se.rds")
rm(se)

se <- readRDS("data_output/se.rds")
head(se)

# Using this data structure we can access the expression matrix using the assay()
head(assay(se))

dim(assay(se))

# we can access the sample metadata by using colData()
colData(se)

dim(colData(se))

# we can also access the feature metadata using the rowData()
rowData(se)

dim(rowData(se))

### Subsetting a SummarizedExperiment

# SummarizedExperiment can be subset just like with dataframes, with numerics or with characters of logicals

# We create a new instance of class summarizedExperiments that contains only the 5 First features for the 3 first samples

se1 <- se[1:5, 1:3]

se1

colData(se1)

rowData(se1)

## We can also use the colData() to subset on something from the sample metadata,
# the rowData() to subset on something from the feature metadata

# For eg. here we keep only the miRNAs and the non infected samples
se1 <- se[rowData(se)$gene_biotype == "miRNA",
          colData(se)$infection == "NonInfected"]

se1

assay(se1)

colData(se1)

rowData(se1)

### challenge

  #1. Extract the gene expression levels of the 3 first genes in samples at time 0 and at time 8

assay(se)[1:3, colData(se)$time == c(0, 8)]


# or 

assay(se)[1:3, colData(se)$time == 0 | colData(se)$time == 8]

## Adding variables to metadata
# we can also add information to the metadata. Suppose that you want to add the center from where the samples are collected

colData(se)$center <- rep("University of Illinois", nrow(colData(se)))

colData(se)

#NOTE: This illustrates that the metadata can grow indefinitely without affecting the other structures.

### tidySummarizedExperiment

# NOTE: we can use tidyverse commands to interact with the SummarizedExperiment objects with "tidySummarizedExperiment" Package

se

# Load tidySummarizedExperiment Package and take a look at the se object again

BiocManager::install("tidySummarizedExperiment")
library("tidySummarizedExperiment")

# Its still a summarizedExperiment object, so maintains the efficient structure, but now we can veiw it as a tibble. 
# Now the first line of the output says this, its a SummarizedExperiment-tibble abstraction.
# We can also see in the second line of the output the number of transcipts and samples

# we can use filter for rows using a condition e.g. to veiw all rows for one sample

se |> filter(sample == "GSM2545336")

# we can also use select to specify columns we want to veiw

se |> filter(sex == "Female")

# We can use mutate to add metadata info

se |> mutate(center = "Heidelberg University")

# We can also combine commands with the tidyverse pipe |> . 
# For e.g. we could combine group_by and summarize to get the total counts for each sample

se |> 
  group_by(sample) |> 
  summarise(total_counts = sum(counts))
  
# We can treat the tidy SummarizedExperiment object as a normal tibble for plotting.

se |> 
  ggplot(aes(counts + 1, group = sample, color = infection)) +
  geom_density() +
  scale_x_log10() +
  theme_bw()
