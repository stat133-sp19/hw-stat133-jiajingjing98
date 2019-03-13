##################################################
## Title: Make Shots Data R Script
## Description: Data preparation for visualization phase.
## Input: Shot data of five players in data/ folder: 
##       - andre-iguodala.csv
##       - draymond-green.csv
##       - kevin-durant.csv
##       - klay-thompson.csv
##       - stephen-curry.csv
## Output: 
##       - firstname-lastname-summary.txt: summary texts for shot data of each player stored in output/
##       - shots-data-summary.txt: summary text for all shot data stored in output/
##       - shots-data.csv: combined shot data stored in data/
##################################################
library(dplyr)

# Read in the five data sets, using relative file paths
data_type <- c("character", "character", "integer", "integer", 
               "integer", "integer", "character", "character", 
               "character", "integer", "character", "integer", "integer")
iguodala <- read.csv("../data/andre-iguodala.csv", colClasses = data_type)
green <- read.csv("../data/draymond-green.csv", colClasses = data_type)
durant <- read.csv("../data/kevin-durant.csv", colClasses = data_type)
thompson <- read.csv("../data/klay-thompson.csv", colClasses = data_type)
curry <- read.csv("../data/stephen-curry.csv", colClasses = data_type)

# Add a column name to each imported data frame, that contains the name of the
# corresponding player:
iguodala <- mutate(iguodala, name="Andre Iguodala")
green <- mutate(green, name="Draymond Green")
durant <- mutate(durant, name="Kevin Durant")
thompson <- mutate(thompson, name="Klay Thompson")
curry <- mutate(curry, name="Stephen Curry")

# Change the original values of shot_made_flag to more descriptive values: 
# replace "n" with "shot_no", and "y" with "shot_yes".
iguodala$shot_made_flag[iguodala$shot_made_flag=="y"] <- "shot_yes"
iguodala$shot_made_flag[iguodala$shot_made_flag=="n"] <- "shot_no"
green$shot_made_flag[green$shot_made_flag=="y"] <- "shot_yes"
green$shot_made_flag[green$shot_made_flag=="n"] <- "shot_no"
durant$shot_made_flag[durant$shot_made_flag=="y"] <- "shot_yes"
durant$shot_made_flag[durant$shot_made_flag=="n"] <- "shot_no"
thompson$shot_made_flag[thompson$shot_made_flag=="y"] <- "shot_yes"
thompson$shot_made_flag[thompson$shot_made_flag=="n"] <- "shot_no"
curry$shot_made_flag[curry$shot_made_flag=="y"] <- "shot_yes"
curry$shot_made_flag[curry$shot_made_flag=="n"] <- "shot_no"

# Add a column minute that contains the minute number where a shot occurred.
iguodala <- mutate(iguodala, minute=iguodala$period*12 - iguodala$minutes_remaining)
green <- mutate(green, minute=green$period*12 - green$minutes_remaining)
durant <- mutate(durant, minute=durant$period*12 - durant$minutes_remaining)
thompson <- mutate(thompson, minute=thompson$period*12 - thompson$minutes_remaining)
curry <- mutate(curry, minute=curry$period*12 - curry$minutes_remaining)

# Use sink() to send the summary() output of each imported data frame into individuals text files:
sink(file = "../output/andre-iguodala-summary.txt")
summary(iguodala)
sink()
sink(file = "../output/draymond-green-summary.txt")
summary(green)
sink()
sink(file = "../output/kevin-durant-summary.txt")
summary(durant)
sink()
sink(file = "../output/klay-thompson-summary.txt")
summary(thompson)
sink()
sink(file = "../output/stephen-curry-summary.txt")
summary(curry)
sink()

# Use the row binding function rbind() to stack the tables into one single data frame
alldf <- rbind(iguodala, green, durant, thompson, curry)

# Export (i.e. write) the assembled table as a CSV file shots-data.csv inside the folder data/.
write.csv(
  x = alldf,
  file = '../data/shots-data.csv',
  row.names=FALSE
)

# Use sink() to send the summary() output of the assembled table
sink(file = "../output/shots-data-summary.txt")
summary(alldf)
sink()

