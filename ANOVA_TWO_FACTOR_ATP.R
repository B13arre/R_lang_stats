# Load necessary packages
library(tidyverse)
library(car)

# Read the data
ATP.data <- read.csv("TreeATP.csv", stringsAsFactors=TRUE)

# No-interaction model
ATPNoInteractModel <- lm(ATP ~ Species + Condition, data = ATP.data)

# Full model with interaction
ATPFullModel <- lm(ATP ~ Species * Condition, data = ATP.data)

# Compare models
anova(ATPNoInteractModel, ATPFullModel)

Anova(ATPFullModel, type = "II")  # Type II for non-significant interaction

# Residuals
aov.resids <- residuals(ATPFullModel)

# Normality test
shapiro.test(aov.resids)

# Plot residuals
plot(residuals(ATPFullModel) ~ fitted(ATPFullModel))
qqPlot(residuals(ATPFullModel))

# Homogeneity of variance
leveneTest(ATP ~ Species * Condition, data = ATP.data)

TukeyHSD(aov(ATPFullModel))
