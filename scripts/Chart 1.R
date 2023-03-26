# Bar chart
# library
library(dplyr)
library(ggplot2)

# function of getting a bar chart
get_bar_chart <- function(dataframe1) {
  new_df <- dataframe1 %>%
    group_by(TEAM) %>%
    summarize(average_VI = mean(VI))
  bar_chart <- ggplot(data = new_df) +
    geom_col(mapping = aes(x = TEAM, y = average_VI), fill = "blue") +
    theme(
      axis.text.x = element_text(size = 8, angle = 45, hjust = 1, vjust = 1)
    ) +
    labs(
      title = "Average VI of each team during regular season",
      x = "NBA Teams in Regular Season",
      y = "Average VI"
    )
  return(bar_chart)
}
