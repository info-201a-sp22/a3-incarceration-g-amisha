
library("tidyverse")

# Chart 1- Trends over time
# This chart will show the pattern of black and white inmates over time
# type = line chart; x-axis = year; y-axis = number of inmates

# Load data
jail_data <- read.csv("incarceration_trends.csv")

grouped_jail_data_white <- jail_data %>% group_by(year) %>% summarise(people = sum(white_jail_pop, na.rm = TRUE)) %>% filter(year > 1984) %>% mutate(Race = "White") %>% mutate(Difference = people - lag(people, n = 1))

grouped_jail_data_black <- jail_data %>% group_by(year) %>% summarise(people = sum(black_jail_pop, na.rm = TRUE)) %>% filter(year > 1984) %>% mutate(Race = "Black") %>% mutate(Difference = people - lag(people, n = 1))

grouped_jail_data <- rbind(grouped_jail_data_black, grouped_jail_data_white)

grouped_jail_data$people <- as.numeric(grouped_jail_data$people )

# Plot values by year
ggplot(grouped_jail_data, mapping = aes(x = year, y = people, color = Race)) + 
  geom_line() +
  geom_point() +
  labs(title = "White vs. Black inmates by year", x = "Year", y = "Number of inmates") +
  scale_x_continuous(breaks = round(seq(1985, 2018, by = 1))) +
  scale_y_continuous(breaks = seq(0, 350000, 15000)) +
  theme(axis.text.x = element_text(angle = 90))
