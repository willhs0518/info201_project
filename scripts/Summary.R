library("dplyr")



# Summary of regular season

get_summary_info <- function(dataframe) {
  result <- list()
  #find the number of players participated
  result$player_num <- nrow(dataframe)
  #find the number of teams participated
  result$team_num <- length(unique(dataframe$TEAM))
  #find the best player with the highest VI value
  result$best_player <- dataframe %>%
    filter(VI == max(VI, na.rm = TRUE)) %>%
    pull(FULL.NAME)
  #find the number of game played by the best player
  result$best_player_game_played <- dataframe %>%
    filter(VI == max(VI, na.rm = TRUE)) %>%
    pull(GP)
  #find the player with the highest points per game
  result$highest_point_player <- dataframe %>%
    filter(PPG == max(PPG, na.rm = TRUE)) %>%
    pull(FULL.NAME)
  return(result)
  }
