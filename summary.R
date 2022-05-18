library(dplyr)

summary_info <- list()

jail_data <- read.csv("incarceration_trends.csv")

summary_info$number_rows <- nrow(jail_data)
