# Scatter Plot

### we try to only include code for functions in the scripts
### and only read in data in rmd file

# library
library(dplyr)
library(ggplot2)

# function of getting a scatter plot
get_scatter_plot <- function(dataframe1, dataframe2) {
  new_df1 <- dataframe1 %>%
    mutate(type_of_game = "regular")
  new_df2 <- dataframe2 %>%
    mutate(type_of_game = "playoff")
  combined_df <- rbind(new_df1, new_df2)
  scatter_plot <- ggplot(data = combined_df) +
    geom_point(mapping = aes(x = TEAM, y = VI, color = type_of_game)) +
    theme(
      axis.text.x = element_text(size = 8, angle = 45, hjust = 1, vjust = 1)
    ) +
    labs(
      title = "Regular Season vs Playoffs VI Values of Each Team",
      x = "NBA Teams",
      y = "VI Value of Players",
      colour = "Type of Games"
      )
  return(scatter_plot)
}
