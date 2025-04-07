library(tidyverse)
library(rstatix)
library(ggpubr)
library(ggplot2)
library(tidyverse)

# Load and inspect data
cancer_data <- read.csv("cancer.csv", stringsAsFactors = TRUE)
head(cancer.data)

# Clean and reshape to long format
cancer_data <- cancer_data |>
  na.omit() |>
  rowid_to_column() |>
  pivot_longer(
    cols = -c(ID, TRT, AGE, WEIGHIN, STAGE, rowid),
    names_to = "Week",
    values_to = "OralCond"
  ) |>
  mutate(
    ID = factor(ID),
    TRT = factor(TRT),
    STAGE = factor(STAGE),
    Week = gsub("TOTALC", "", Week),
    Week = fct_recode(Week, "W0" = "IN"),
    Week = factor(Week, levels = c("W0", "W2", "W4", "W6"))
  )

#OR

cancer.data <- cancer.data %>% 
  na.omit() %>% #remove missing obs
  rowid_to_column() %>%  #set a new var to track original row
  pivot_longer(cols =-c(ID, TRT, AGE, WEIGHIN, STAGE, rowid),
               names_to="Week",
               values_to="OralCond") %>%
  mutate(ID = factor(ID),
         TRT = factor(TRT),
         STAGE = factor(STAGE),
         Week = gsub("TOTALC", "", Week),
         Week = factor(fct_recode(Week, "W0"="IN"),
                       levels=c("W0", "W2", "W4", "W6")
         )
  )


head(cancer.data)
tail(cancer.data)

# Calculate mean and SD for each combination of TRT and week
library(tidyverse)
cancer.data %>%
  group_by(Week, TRT) %>%
  summarise(n = sum(!is.na(OralCond)),
            mean = mean(OralCond, na.rm=TRUE),
            sd = sd(OralCond, na.rm=TRUE))

#OR

# Mean and SD per Treatment & Week
cancer_data |>
  group_by(Week, TRT) |>
  get_summary_stats(OralCond, show = c("n", "mean", "sd"))

ggboxplot(cancer_data, x = "Week", y = "OralCond",
          color = "TRT", palette = "jco") +
  ylab("Oral Condition") +
  xlab("Week")

#OR

#Replicate above with libraries we know.
library(ggplot2)
ggplot(cancer.data, aes(x=Week, y=OralCond, color=TRT))+
  geom_boxplot()+
  #ggsci::scale_color_jco()+ could work
  #scales::show_col(ggsci::pal_jco(2)) to find hex val.
  scale_color_manual(values=c("#0073C2FF", "#EFC000FF"))+
  theme_classic()+
  theme(legend.position = "top")+
  ylab("Oral Condition")+
  xlab("Week")

# Optional: Remove participant ID 24 if needed
cancer_data <- cancer_data |>
  filter(ID != 24)

# Identify outliers
cancer_data |>
  group_by(TRT, Week) |>
  identify_outliers(OralCond)

cancer_data |>
  group_by(TRT, Week) |>
  shapiro_test(OralCond)

# Repeated Measures ANOVA
cancer_anova <- cancer_data |>
  anova_test(dv = OralCond, wid = ID, within = Week, between = TRT)

# View full results
cancer_anova

# ANOVA Table with HF correction
cancer_anova |>
  get_anova_table(correction = "HF")

cancer_data |>
  pairwise_t_test(
    OralCond ~ Week,
    paired = TRUE,
    p.adjust.method = "bonferroni"
  )

# Interpretation: 
# Dependent variable: OralCond
# Within-subject variable: Week
# Between-subject variable: TRT
# Week is significant:
# F(2.59, 51.78) = 10.321, p < .001, η²g = 0.202
# Oral condition changes over time.

# TRT (Treatment) not significant:
# F(1, 20) = 0.927, p = 0.347
# No evidence Aloe Juice was more effective than placebo.

# TRT × Week interaction not significant:
# F(2.59, 51.78) = 0.160, p = 0.90