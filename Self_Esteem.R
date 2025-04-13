# Load necessary libraries
library(tidyverse)

# Read the data
esteem <- read.csv("Esteem.csv")

# Reshape data from wide to long format
esteem_long <- esteem %>%
  pivot_longer(cols = starts_with("t"), 
               names_to = "Time", 
               values_to = "SelfEsteem")

# Plot with individual colors
ggplot(esteem_long, aes(x = Time, y = SelfEsteem, group = id, color = factor(id))) +
  geom_line() +
  geom_point() +
  labs(x = "Time Point", 
       y = "Self-Esteem Score", 
       color = "Participant ID",
       title = "Change in Self-Esteem Over Time by Individual") +
  theme_minimal()
