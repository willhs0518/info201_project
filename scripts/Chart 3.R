# Pie chart
library(dplyr)
library(ggplot2)

# function of getting a pie chart
get_pie_chart <- function(dataframe1, team) {
  team_df <- dataframe1 %>%
    filter(TEAM == team) %>%
    mutate(percent = round(GP / 82, 3)) %>%
    select(percent)
  team_df$category[team_df$percent >= 0.9] <- "play more than 90% games"
  team_df$category[team_df$percent < 0.9 & team_df$percent >= 0.7] <-
    "play 70-90% games"
  team_df$category[team_df$percent < 0.7 & team_df$percent >= 0.5] <-
    "play 50-70% games"
  team_df$category[team_df$percent < 0.5 & team_df$percent >= 0.3] <-
    "play 30-50% games"
  team_df$category[team_df$percent < 0.3] <- "play less than 30% games"

  aggre_df <- data.frame(table(team_df$category))
  fill_value <- c("play less than 30% games", "play more than 90% games",
              "play 30-50% games", "play 50-70% games", "play 70-90%  games")
  pie_chart <- ggplot(aggre_df, aes(x = "", y = Freq, fill = Var1)) +
    geom_bar(width = 1, stat = "identity", color = "white") +
    coord_polar("y", start = 0) +
    scale_fill_brewer("participation percentage of all games") +
    theme(
      axis.title.x = element_blank(),
      axis.title.y = element_blank(),
      panel.grid = element_blank(),
      panel.border = element_blank(),
      axis.ticks = element_blank()) +
    geom_text(label = aggre_df$Freq, position = position_stack(vjust = 0.5)) +
    labs(title = paste0("Distribution of ", team, "'s Player Participation
    Percenatges of the Season"))
  return(pie_chart)
}
