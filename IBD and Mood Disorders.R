# Load required libraries
library(ggplot2)
library(ggtext)

# Create the plot
p <- ggplot() +
  # Set the plot boundaries
  xlim(0, 10) +
  ylim(0, 6) +
  
  # Add rectangles for IBD and Mood Disorders
  annotate(
    "rect",
    xmin = 2, xmax = 4, ymin = 2, ymax = 4,
    fill = "#f8d7da", color = "#721c24", alpha = 0.8
  ) +
  annotate(
    "rect",
    xmin = 6, xmax = 8, ymin = 2, ymax = 4,
    fill = "#d4edda", color = "#155724", alpha = 0.8
  ) +
  
  # Add text labels
  annotate(
    "text", x = 3, y = 3,
    label = "Inflammatory\nBowel Disease",
    size = 4, fontface = "bold"
  ) +
  annotate(
    "text", x = 7, y = 3,
    label = "Anxiety and\nDepression",
    size = 4, fontface = "bold"
  ) +
  
  # Add arrows
  annotate(
    "segment",
    x = 4, xend = 6, y = 2.7, yend = 2.7,
    arrow = arrow(length = unit(0.3, "cm")),
    size = 0.8
  ) +
  annotate(
    "segment",
    x = 6, xend = 4, y = 3.3, yend = 3.3,
    arrow = arrow(length = unit(0.3, "cm")),
    size = 0.8
  ) +
  
  # Add arrow labels
  annotate("text", x = 5, y = 2.4, label = "Inflammation", size = 3.5) +
  annotate("text", x = 5, y = 3.6, label = "Stress Response", size = 3.5) +
  
  # Add Gut-Brain Axis label
  annotate(
    "text", x = 5, y = 1.5,
    label = "Gut-Brain Axis Mediates This Relationship",
    size = 4, fontface = "italic"
  ) +
  
  # Add title
  ggtitle("Bidirectional Relationship Between IBD and Mood Disorders") +
  
  # Apply theme adjustments
  theme_void() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 14, face = "bold")
  )

# Display the plot
print(p)
