library("tidyverse")

# Chart 2- Variable Comparison Chart
# x = year, y = percent change in black inmates

jail_data <- read.csv("incarceration_trends.csv")

pct_black <- jail_data %>% group_by(year) %>% summarise(people = sum(black_jail_pop, na.rm = TRUE)) %>% filter(year > 1984) %>% mutate(Race = "Black") %>% mutate(Change = ((people - lag(people, n = 1)) / people * 100))

ggplot(data = pct_black) +
  geom_col(aes(x = year, y = Change), fill = "sienna4", color = "darksalmon") +
  labs(title = "Change in Black Incarcerations", x = "Year", y = "% change in Black incarcerations") +
  scale_x_continuous(breaks = round(seq(1986, 2018, by = 1))) +
  scale_y_continuous(breaks = seq(-10, 30, 2)) +
  theme(axis.text.x = element_text(angle = 90))
