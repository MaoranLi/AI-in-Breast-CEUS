library(readxl)
library(ggplot2)
library(dplyr)
library(tidyr)

data <- read_excel("Supplemental Table 3.xlsx")

rob_data <- data %>%
  select(No, Study, 
         D_Participants, D_Predictors, D_Outcome, D_Analysis,
         E_Participants, E_Predictors, E_Outcome, E_Analysis,
         A_Participants, A_Predictors, A_Outcome) %>%
  pivot_longer(
    cols = -c(No, Study),
    names_to = "Indicator",
    values_to = "Rating"
  ) %>%
  mutate(
    Indicator_clean = case_when(
      Indicator == "D_Participants" ~ "Development: Participants",
      Indicator == "D_Predictors" ~ "Development: Predictors",
      Indicator == "D_Outcome" ~ "Development: Outcome",
      Indicator == "D_Analysis" ~ "Development: Analysis",
      Indicator == "E_Participants" ~ "Evaluation: Participants",
      Indicator == "E_Predictors" ~ "Evaluation: Predictors",
      Indicator == "E_Outcome" ~ "Evaluation: Outcome",
      Indicator == "E_Analysis" ~ "Evaluation: Analysis",
      Indicator == "A_Participants" ~ "Applicability: Participants",
      Indicator == "A_Predictors" ~ "Applicability: Predictors",
      Indicator == "A_Outcome" ~ "Applicability: Outcome",
      TRUE ~ Indicator
    ),
    Rating = case_when(
      Rating == "+" ~ "Low Risk",
      Rating == "-" ~ "High Risk",
      Rating == "?" ~ "Unclear",
      TRUE ~ as.character(Rating)
    ),
    Rating = factor(Rating, levels = c("High Risk", "Unclear", "Low Risk"))
  )

summary_data <- rob_data %>%
  group_by(Indicator_clean, Rating) %>%
  summarise(Count = n(), .groups = "drop") %>%
  group_by(Indicator_clean) %>%
  mutate(
    Total = sum(Count),
    Percentage = Count / Total * 100,
    Label = paste0(round(Percentage, 1), "%")
  ) %>%
  ungroup()

indicator_order <- c(
  "Development: Participants",
  "Development: Predictors", 
  "Development: Outcome",
  "Development: Analysis",
  "Evaluation: Participants",
  "Evaluation: Predictors",
  "Evaluation: Outcome",
  "Evaluation: Analysis",
  "Applicability: Participants",
  "Applicability: Predictors",
  "Applicability: Outcome"
)

summary_data$Indicator_clean <- factor(summary_data$Indicator_clean, 
                                       levels = indicator_order)

p <- ggplot(summary_data, aes(x = Indicator_clean, y = Percentage, fill = Rating)) +
  geom_bar(stat = "identity", position = "stack", width = 0.7) +
  
  scale_fill_manual(values = c(
    "High Risk" = "#DC143C",
    "Unclear" = "#FFD700",
    "Low Risk" = "#2E8B57"
  )) +
  labs(
    title = "PROBAST+AI Assessment: Risk of Bias by Domain",
    subtitle = "Distribution of ratings across development, evaluation, and applicability domains",
    x = NULL,
    y = "Percentage (%)",
    fill = "Risk Rating",
    caption = "Based on 35 studies"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = "bold", hjust = 0.5),
    plot.subtitle = element_text(size = 12, hjust = 0.5, color = "gray40"),
    axis.text.x = element_text(angle = 45, hjust = 1, size = 11),
    axis.text.y = element_text(size = 10),
    axis.title.y = element_text(size = 12, face = "bold"),
    legend.position = "bottom",
    legend.title = element_text(size = 11, face = "bold"),
    legend.text = element_text(size = 10),
    panel.grid.major.x = element_blank(),
    panel.grid.minor = element_blank(),
    plot.margin = margin(10, 20, 10, 20)
  ) +
  scale_y_continuous(limits = c(0, 100), breaks = seq(0, 100, 20))

print(p)

cat("\n", paste(rep("=", 80), collapse = ""), "\n")
cat("PROBAST+AI Assessment Summary Statistics\n")
cat(paste(rep("=", 80), collapse = ""), "\n\n")

summary_table <- summary_data %>%
  select(Indicator_clean, Rating, Count, Percentage) %>%
  arrange(Indicator_clean, Rating)

print(summary_table, n = Inf)

p_grouped <- summary_data %>%
  mutate(
    Group = case_when(
      grepl("Development", Indicator_clean) ~ "Development",
      grepl("Evaluation", Indicator_clean) ~ "Evaluation",
      grepl("Applicability", Indicator_clean) ~ "Applicability"
    ),
    Group = factor(Group, levels = c("Development", "Evaluation", "Applicability"))
  ) %>%
  ggplot(aes(x = Indicator_clean, y = Percentage, fill = Rating)) +
  geom_bar(stat = "identity", position = "stack", width = 0.7) +
  scale_fill_manual(values = c(
    "High Risk" = "#DC143C",
    "Unclear" = "#FFD700",
    "Low Risk" = "#2E8B57"
  )) +
  facet_grid(. ~ Group, scales = "free_x", space = "free_x") +
  labs(
    title = "PROBAST+AI Risk of Bias Assessment",
    x = NULL,
    y = "Percentage (%)",
    fill = "Risk Rating"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = "bold", hjust = 0.5),
    plot.subtitle = element_text(size = 12, hjust = 0.5, color = "gray40"),
    axis.text.x = element_text(angle = 45, hjust = 1, size = 10),
    axis.text.y = element_text(size = 10),
    legend.position = "bottom",
    strip.text = element_text(size = 12, face = "bold"),
    panel.grid.major.x = element_blank(),
    panel.spacing = unit(1, "lines")
  ) +
  scale_y_continuous(limits = c(0, 100), breaks = seq(0, 100, 20))

print(p_grouped)