library(tidyverse)
library(meta)
library(metafor)
library(ggplot2)

data <- data.frame(
  No = 1:37,
  StudyNo = c(2,3,4,5,6,7,8,9,10,11,12,13,14,14,15,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,35),
  Study = c("Wan et al. 2025", "Chen et al. 2021", "Xu et al. 2022", "Gong et al. 2023", 
            "Wang et al. 2023", "Oshino et al. 2025", "Zheng et al. 2025", "Ioannidis et al. 2022",
            "Kondo et al. 2023", "Zhang et al. 2025", "Chen et al. 2023", "Wang et al. 2025",
            "Li et al. 2025", "Li et al. 2025", "Gong et al. 2023", "Gong et al. 2023",
            "Zhu et al. 2022", "Sun et al. 2024", "Zheng et al. 2022", "Shen et al. 2025",
            "Chen et al. 2020", "Yan et al. 2025", "Niu et al. 2025", "Fu et al. 2025",
            "Chen et al. 2025", "Li et al. 2025", "Chen et al. 2025", "Chen et al. 2025",
            "Li et al. 2025", "Lun et al. 2024", "Varghese et al. 2022", "Wang et al. 2025",
            "Li et al. 2025", "Song et al. 2024", "Guo et al. 2024", "Li et al. 2024",
            "Li et al. 2024"),
  Category = c("Diagnosis", "Diagnosis", "Diagnosis", "Diagnosis", "Diagnosis", "LNM", 
               "Diagnosis", "Diagnosis", "Diagnosis", "HER2", "HER2", "Prognosis", 
               "LNM", "Prognosis", "Diagnosis", "Subtype", "Diagnosis", "LNM", 
               "Diagnosis", "Diagnosis", "HER2", "LNM", "LVI", "Diagnosis", "LNM",
               "Diagnosis", "Subtype", "Diagnosis", "Diagnosis", "LNM", "Diagnosis",
               "HER2", "Subtype", "LNM", "Diagnosis", "Diagnosis", "LNM"),
  SampleSize = c(333, 217, 187, 554, 161, 788, 441, 25, 119, 104, 335, 239, 682, 682, 
                 170, 120, 190, 111, 334, 411, 119, 282, 981, 339, 246, 80, 193, 3390,
                 333, 243, 131, 140, 1388, 401, 332, 253, 253),
  SEN = c(0.9364, 0.972, 0.774, 0.9417, 0.915, 0.88, 0.742, 0.892, 0.92, 1, 0.8801,
          0.894, NA, NA, 0.875, 0.465, 0.708, 0.917, 0.888, 0.667, 0.7062, 0.688,
          0.911, NA, 0.8182, 0.9839, 0.903, 0.9806, 0.973, 0.6667, 0.68, 0.9286,
          0.81, 0.9, 0.9091, NA, NA),
  SPE = c(0.8987, 0.925, 0.924, NA, 0.905, 0.95, 0.804, 0.771, 0.55, 0.668, 0.8704,
          0.829, NA, NA, 0.802, 0.816, 0.859, 0.857, 0.75, 0.892, 0.7897, 0.879,
          0.775, NA, 0.9259, 0.8889, 0.78, NA, 0.804, 0.7273, 0.69, 0.9634, NA,
          0.8, 0.90432, NA, NA),
  AUC = c(0.9014, NA, 0.849, NA, 0.91, 0.93, 0.836, 0.91, 0.875, 0.869, 0.876, 0.91,
          0.77, 0.8, 0.953, 0.96, 0.84, 0.901, 0.891, 0.837, 0.8082, 0.81, 0.914,
          0.896, NA, 0.936, 0.857, NA, 0.949, 0.713, 0.72, 0.969, 0.89, 0.903,
          0.943, 0.966, 0.832),
  ACC = c(0.8925, 0.863, 0.871, 0.8773, 0.908, 0.93, 0.768, NA, 0.816, 0.722, 0.8623,
          NA, NA, NA, 0.854, 0.725, 0.76, NA, 0.819, 0.808, 0.7949, 0.841, 0.816,
          NA, 0.8776, 0.9625, 0.801, 0.9845, 0.851, 0.6667, NA, 0.9524, 0.89, NA,
          0.88238, NA, NA),
  PPV = c(NA, NA, NA, 0.8381, 0.796, NA, NA, NA, 0.841, NA, 0.8594, NA, NA, NA, 
          0.916, 0.468, NA, NA, NA, NA, NA, 0.579, 0.641, NA, NA, 0.9683, 0.721,
          0.9825, NA, NA, NA, NA, NA, NA, NA, NA, NA),
  NPV = c(NA, NA, NA, NA, 0.963, NA, NA, NA, 0.749, NA, NA, NA, NA, NA, 
          0.722, 0.814, NA, NA, NA, NA, NA, 0.921, 0.952, NA, NA, 0.9412, 0.903,
          NA, 0.987, NA, NA, NA, NA, NA, NA, NA, NA),
  F1 = c(0.9196, 0.887, NA, 0.8738, NA, NA, NA, NA, 0.877, NA, NA, NA, NA, NA, 
         NA, NA, 0.72, NA, NA, NA, NA, NA, NA, NA, 0.8571, NA, 0.725, 0.9843,
         0.783, NA, NA, NA, 0.89, NA, 0.88038, NA, NA),
  YI = c(NA, NA, 0.698, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 
         0.814, 0.823, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,
         NA, NA, NA, NA, NA, NA, NA, NA, NA)
)

all_metrics <- c("SEN", "SPE", "AUC", "ACC", "PPV", "NPV", "F1", "YI")
categories <- unique(data$Category)

weighted_mean_by_category <- function(data, metric, categories) {
  results <- data.frame()
  
  for (cat in categories) {
    cat_data <- data[data$Category == cat & !is.na(data[[metric]]), ]
    
    if (nrow(cat_data) > 0) {
      weighted_mean <- sum(cat_data[[metric]] * cat_data$SampleSize, na.rm = TRUE) / 
        sum(cat_data$SampleSize, na.rm = TRUE)
      
      weighted_var <- sum(cat_data$SampleSize * (cat_data[[metric]] - weighted_mean)^2, na.rm = TRUE) / 
        (sum(cat_data$SampleSize, na.rm = TRUE) - 1)
      weighted_se <- sqrt(weighted_var / nrow(cat_data))
      
      lower_ci <- weighted_mean - 1.96 * weighted_se
      upper_ci <- weighted_mean + 1.96 * weighted_se
      
      simple_mean <- mean(cat_data[[metric]], na.rm = TRUE)
      simple_sd <- sd(cat_data[[metric]], na.rm = TRUE)
      simple_se <- simple_sd / sqrt(nrow(cat_data))
      
      results <- rbind(results, data.frame(
        Category = cat,
        Metric = metric,
        N_studies = nrow(cat_data),
        Total_sample = sum(cat_data$SampleSize, na.rm = TRUE),
        Weighted_mean = round(weighted_mean, 4),
        Weighted_SE = round(weighted_se, 4),
        Weighted_CI_lower = round(max(0, lower_ci), 4),
        Weighted_CI_upper = round(min(1, upper_ci), 4),
        Simple_mean = round(simple_mean, 4),
        Simple_SE = round(simple_se, 4),
        Simple_SD = round(simple_sd, 4),
        Min = round(min(cat_data[[metric]], na.rm = TRUE), 4),
        Max = round(max(cat_data[[metric]], na.rm = TRUE), 4)
      ))
    }
  }
  
  return(results)
}

all_weighted_results <- data.frame()
for (metric in all_metrics) {
  cat_results <- weighted_mean_by_category(data, metric, categories)
  all_weighted_results <- rbind(all_weighted_results, cat_results)
}

print(all_weighted_results)

summary_table <- all_weighted_results %>%
  select(Category, Metric, N_studies, Total_sample, Weighted_mean, 
         Weighted_CI_lower, Weighted_CI_upper) %>%
  mutate(Result = paste0(Weighted_mean, " (", Weighted_CI_lower, "-", Weighted_CI_upper, ")")) %>%
  select(Category, Metric, N_studies, Total_sample, Result) %>%
  pivot_wider(names_from = Metric, values_from = Result, values_fill = "NA")

print(summary_table)