library(dplyr)
library(scales) 

summary_info <- list()

jail_data <- read.csv("incarceration_trends.csv")
state_data <- jail_data %>% group_by(state) %>% filter(year == max(year)) %>% summarise(Inmates = sum(total_pop))
pct_black <- jail_data %>% group_by(year) %>% summarise(people = sum(black_jail_pop, na.rm = TRUE)) %>% filter(year > 1984) %>% mutate(Race = "Black") %>% mutate(Change = ((people - lag(people, n = 1)) / people * 100))

abberviations <- read.csv("abbreviations.csv")
abberviations <- rename(abberviations, state = Code)
state_data <- left_join(abberviations, state_data)

# Find number of rows in the data
summary_info$number_rows <- label_comma() (nrow(jail_data))

# Find number of columns in the data
summary_info$number_columns <- ncol(jail_data)

# Find state with highest number of incarcerations
summary_info$state_highest <- state_data %>% filter(Inmates == max(Inmates)) %>% pull(State)

# Find year of highest increase in Black incarcerations 
summary_info$highest_increase <- pct_black %>% filter(Change == max(na.omit(Change))) %>% pull(year)

# Find year of highest decrease in Black incarcerations
summary_info$highest_decrease <- pct_black %>% filter(Change == min(na.omit(Change))) %>% pull(year)

# Find total number of incarcerations
summary_info$total_incarcerations <- label_comma() (sum(state_data$Inmates))
