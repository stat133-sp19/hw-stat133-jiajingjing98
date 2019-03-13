##################################################
## Title: Make Shots Charts R Script
## Description: Creating shot charts for each player
## Input: shots-data.csv: prepared shot data of five players in data/ folder: 
## Output: 
##    - firstname-lastname-shot-chart.pdf: shot charts for each player stored in images/ folder
##    - gsw-shot-charts.pdf: facetted shot chart of all players in pdf stored in images/ folder
##    - gsw-shot-charts.png: facetted shot chart of all players in png stored in images/ folder
##################################################

library(dplyr)
library(ggplot2)
library(jpeg)
library(grid)

# load prepared data
data_type <- c("character", "character", "integer", "integer", 
               "integer", "integer", "character", "character", 
               "character", "integer", "character", "integer", "integer", 
               "character", "integer")
alldf <- read.csv("../data/shots-data.csv", colClasses = data_type)

# 4.1) create shot charts (with court backgrounds) for each player, and save the plots in PDF format.
court_file <- "../images/nba-court.jpg"

court_image <- rasterGrob(
  readJPEG(court_file),
  width = unit(1, "npc"),
  height = unit(1, "npc"))

iguodala_shot_chart <- ggplot(data = alldf[alldf$name == "Andre Iguodala", ]) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Andre Iguodala (2016 season)') +
  theme_minimal()

pdf(file= "../images/andre-iguodala-shot-chart.pdf", width=6.5, height=5)
iguodala_shot_chart
dev.off()

green_shot_chart <- ggplot(data = alldf[alldf$name == "Draymond Green", ]) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Draymond Green (2016 season)') +
  theme_minimal()

pdf(file= "../images/draymond-green-shot-chart.pdf", width=6.5, height=5)
green_shot_chart
dev.off()

durant_shot_chart <- ggplot(data = alldf[alldf$name == "Kevin Durant", ]) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Kevin Durant (2016 season)') +
  theme_minimal()

pdf(file= "../images/kevin-durant-shot-chart.pdf", width=6.5, height=5)
durant_shot_chart
dev.off()

thompson_shot_chart <- ggplot(data = alldf[alldf$name == "Klay Thompson", ]) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Klay Thompson (2016 season)') +
  theme_minimal()

pdf(file= "../images/klay-thompson-shot-chart.pdf", width=6.5, height=5)
thompson_shot_chart
dev.off()

curry_shot_chart <- ggplot(data = alldf[alldf$name == "Stephen Curry", ]) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Stephen Curry (2016 season)') +
  theme_minimal()

pdf(file= "../images/stephen-curry-shot-chart.pdf", width=6.5, height=5)
curry_shot_chart
dev.off()

# 4.2)

gsw_shot_charts <- ggplot(data = alldf) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Charts: GSW (2016 season)') +
  facet_wrap(~ name) +
  theme_minimal() +
  theme(legend.position = "top")

pdf(file= "../images/gsw-shot-charts.pdf", width=8, height=7)
gsw_shot_charts
dev.off()

png(filename = "../images/gsw-shot-charts.png", width=8, height=7, units="in", res=500)
gsw_shot_charts
dev.off()







