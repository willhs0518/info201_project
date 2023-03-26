# Aggregated Summary Table

### we try to only include code for functions in the scripts
### and only read in data in rmd file


# library
library(dplyr)
# get rid of override with `.groups` argument
options(dplyr.summarise.inform = FALSE)

# Summary Table
# To better evaluate each individual player's performance, we need to
# understand the difference among each posiiton in the court as each
# position focuses on different strategy
position_difference <- function(dataframe) {
  position_data <- dataframe %>%
    group_by(POS) %>%
    summarize(

      point_per_game_mean = round(mean(PPG, na.rm = TRUE), 3),
      rebound_per_game_mean = round(mean(RPG, na.rm = TRUE), 3),
      assist_per_game_mean = round(mean(APG, na.rm = TRUE), 3),
      steal_per_game_mean = round(mean(SPG, na.rm = TRUE), 3),
      block_per_game_mean = round(mean(BPG, na.rm = TRUE), 3),
      turnover_per_game_mean = round(mean(TOPG, na.rm = TRUE), 3)

    ) %>%
    # arranging it starting from the position getting the highest points
    # to the position getting the lowest points
    arrange(-point_per_game_mean)
  # well-formateed column names
  colnames(position_data) <- c(
    "Position",
    "Average points per game",
    "Average rebounds per game",
    "Average assists per game",
    "Average steals per game",
    "Average blocks per game",
    "Average turnovers per game"
  )
  return(position_data)
}
