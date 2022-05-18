library("tidyverse")
library(usmap)
library(scales)
options(scipen = n)
# Map - Distribution of the number of incarcerations by state 
# Answers the question: What state had the most number of incarcerations in 2018?
jail_data <- read_csv("incarceration_trends.csv")
state_data <- jail_data %>% group_by(state) %>% filter(year == max(year)) %>% summarise(Inmates = sum(total_pop))

incarcerations_map <- plot_usmap("states", data = state_data, values = "Inmates", labels = TRUE) + 
  theme(legend.position = "right") +
  scale_fill_gradient(low = "lightpink", high = "red", labels = comma) +
  scale_x_continuous(name = "Inmates", breaks = seq(550000, 30000000, 500000)) +
  labs(title = "Incarcerations in the U.S. by State in 2018") 

incarcerations_map$layers[[2]]$aes_params$size <- 2
print(incarcerations_map)
