library(ggplot2)
library(dplyr)

detailed_data <- data.frame(
  Task = rep(c("Diagnosis of breast tumor", "Prediction of LNM", 
               "Prediction of HER2 expression", "Prediction of molecular subtypes",
               "Prediction of prognosis", "Prediction of LVI"), each = 8),
  Metric = rep(c("SEN", "SPE", "AUC", "ACC", "PPV", "NPV", "F1", "YI"), 6),
  Value = c(0.914, 0.838, 0.888, 0.910, 0.951, 0.893, 0.935, 0.753,
            0.827, 0.877, 0.845, 0.865, 0.579, 0.921, 0.857, NA,
            0.878, 0.845, 0.882, 0.848, 0.859, NA, NA, NA,
            0.796, 0.794, 0.891, 0.868, 0.624, 0.869, 0.870, 0.823,
            0.894, 0.829, 0.829, NA, NA, NA, NA, NA,
            0.911, 0.775, 0.914, 0.816, 0.641, 0.952, NA, NA),
  References = c(17, 15, 16, 15, 6, 5, 8, 2, 
                 6, 6, 7, 4, 1, 1, 1, NA,
                 4, 4, 4, 4, 1, NA, NA, NA,
                 3, 2, 3, 3, 2, 2, 2, 1,
                 1, 1, 2, NA, NA, NA, NA, NA,
                 1, 1, 1, 1, 1, 1, NA, NA),
  SampleSize = c(7408, 3464, 3839, 7252, 4474, 863, 5468, 357,
                 2071, 2071, 2760, 1559, 282, 282, 246, NA,
                 698, 698, 698, 698, 335, NA, NA, NA,
                 1701, 313, 1701, 1701, 313, 313, 1581, 120,
                 239, 239, 921, NA, NA, NA, NA, NA,
                 981, 981, 981, 981, 981, 981, NA, NA),
  stringAsFactors = FALSE
)

detailed_data = subset(detailed_data, !is.na(Value))

desired_order = c(
  "Diagnosis of breast tumor",
  "Prediction of LNM",
  "Prediction of HER2 expression",
  "Prediction of molecular subtypes",
  "Prediction of prognosis",
  "Prediction of LVI"
)

desired_metric_order = c("SEN", "SPE", "AUC", "ACC", "PPV", "NPV", "F1", "YI")

detailed_data$Task = factor(detailed_data$Task, levels=desired_order)
detailed_data$Metric = factor(detailed_data$Metric, levels=desired_metric_order)

detailed_data$RefLabel = ifelse(is.na(detailed_data$References), "", paste0("Ref=", detailed_data$References))

ss_min <- min(detailed_data$SampleSize, na.rm = TRUE)
ss_max <- max(detailed_data$SampleSize, na.rm = TRUE)


ggplot(detailed_data, aes(x = Metric, y = Value)) +
  geom_point(aes(size = SampleSize, color = Task), alpha = 0.7) +
  geom_text(aes(label = sprintf("%.3f", Value), vjust= -1.5 - 1.5*(SampleSize - ss_min) / (ss_max - ss_min)), size = 2.6) +
  geom_text(aes(label = paste0("Ref=", References), vjust = 2.5 + 1.8 * (SampleSize - ss_min) / (ss_max - ss_min)), size = 2.2, color = "gray30") +
  scale_size_continuous(range = c(3, 12), name = "Sample Size") +
  scale_color_viridis_d(option = "viridis") +
  scale_y_continuous(limits = c(0.5, 1)) +
  facet_wrap(~Task, ncol = 2) +
  labs(
    x = "Performance Metrics",
    y = "Weighted Mean Value"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", size = 14, hjust = 0.5),
    plot.subtitle = element_text(size = 10, hjust = 0.5, color = "gray50"),
    axis.text.x = element_text(angle = 45, hjust = 1),
    legend.position = "right",
    strip.text = element_text(face = "bold")
  )