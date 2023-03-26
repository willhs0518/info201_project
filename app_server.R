library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)
library(tidyr)

# read in data
regular_df <- read.csv(
  "data/2018-2019-NBA-Player-Stats-NBAstuffer-regularseasons.csv",
  stringsAsFactors = F)

playoff_df <- read.csv(
  "./data/2018-2019-NBA-Player-Stats-NBAstuffer-playoffs.csv",
  stringsAsFactors = FALSE)

# create functions
server <- function(input, output) {
  # position page start here
  df_position <- reactive({
    regular_df %>%
      filter(POS == input$radio4)
  })
  # position page graph 1
  output$graph <- renderPlotly({
    plot <- ggplot(data = df_position()) +
      geom_point(mapping = aes(x = PPG, y = VI, color = POS)) +
      labs(
        title = paste0(
          "PPG vs VI Values of all Players with Position ",
          input$radio4
        ),
        x = "Points per Game",
        y = "VI Values"
      )
    final_plot <- ggplotly(plot)
    return(final_plot)
  })

  # position page graph 2 (this graph won't change when selecting different
  # position as it shows the offensive/defensive rate among all position,
  # but it will still display detailed information when hovering over)
  output$scatter <- renderPlotly({
    plotly <- plot_ly(
      data = regular_df,
      x = ~ORTG,
      y = ~DRTG,
      color = ~POS,
      type = "scatter",
      mode = "markers",
      hovertemplate = paste(
        "<br>", "Player's name: ", regular_df$FULL.NAME,
        "<br>", "Offensive rate: ", regular_df$ORTG,
        "<br>", "Deffensive rate: ", regular_df$DRTG
      )
    ) %>%
      layout(
        title = "Overall Offensive versus Defensive among All Positions",
        xaxis = list(title = "Offensive Rate"),
        yaxis = list(title = "Defensive Rate")
      )
    return(plotly)
  })
  # position page ends here

  # team page starts here
  new_df <- reactive({
    playoff_df %>%
      left_join(regular_df, by = "FULL.NAME") %>%
      filter(TEAM.x == input$radio3)
  })
  # team page (for teams participated in both regular season and playoffs)
  output$plot <- renderPlotly({
    plot2 <- ggplot(data = new_df()) +
      geom_point(mapping = aes(x = VI.y, y = VI.x, color = POS.x)) +
      labs(
        title = paste0(
          input$radio3,
          "'s Player Performance in Regular Season vs Playoffs"
        ),
        x = "Regular Season VI",
        y = "Playoff Season VI",
        colour = "Position"
      )
    final_plot2 <- ggplotly(plot2)
    return(final_plot2)
  })
  # team page (all teams)
  df_average <- reactive({
    regular_df %>%
      group_by(TEAM) %>%
      summarize(avergae_PPG = round(mean(PPG), 3),
                average_RPG = round(mean(RPG), 3),
                average_APG = round(mean(APG), 3),
                average_SPG = round(mean(SPG), 3),
                average_BPG = round(mean(BPG), 3),
                average_TOPG = round(mean(TOPG), 3)) %>%
      filter(TEAM == input$radio2) %>%
      select(
        TEAM,
        avergae_PPG,
        average_RPG,
        average_APG,
        average_SPG,
        average_BPG,
        average_TOPG
      ) %>%
      gather(key = Category, value = performance, -TEAM)
  })
  output$bar <- renderPlotly({
    bar <- ggplot(data = df_average()) +
      geom_col(
        mapping = aes(x = TEAM, y = performance, fill = Category),
        position = "dodge"
      ) +
      labs(
        title = paste0(input$radio2, " Team's Average Performance"),
        x = "Team",
        y = "Performance"
      )
    final_bar <- ggplotly(bar)
    return(final_bar)
  })
  # team page ends here

  # player page starts here
  player_df <- regular_df %>%
    select(
      "FULL.NAME",
      "TEAM",
      "GP",
      "AGE",
      "PPG",
      "RPG",
      "APG",
      "SPG",
      "BPG",
      "TOPG"
    ) %>%
    gather("category", "value", 5:10) %>%
    arrange(desc(FULL.NAME))

  # sidebar player's profile function
  get_chart_text <- function(df, name) {
    new_df <- regular_df %>%
      filter(FULL.NAME == name) %>%
      filter(GP == max(GP, na.rm = TRUE)) %>%
      select("TEAM", "POS", "AGE", "GP")
    new_df
  }

  get_ui <- function(dataframe) {
    tagList(
      p(
        h3("Team"),
        h4(style = "color:#E95420; padding-top:0px;margin-top:0px",
           dataframe$TEAM)
      ),
      p(
        h3("Position"),
        h4(style = "color:#E95430; padding-top:0px;margin-top:0px",
           dataframe$POS)
      ),
      p(
        h3("Age"),
        h4(style = "color:#E95420; padding-top:0px;margin-top:0px",
           dataframe$AGE)
      ),
      p(
        h3("Game Played"),
        h4(style = "color:#E95420; padding-top:0px;margin-top:0px",
           dataframe$GP)
      )
    )
  }

  output$textui <- renderUI(get_ui(get_chart_text(player_df, input$name)))

  player_data <- reactive({
      regular_df %>%
      filter(FULL.NAME == input$name) %>%
      filter(GP == max(GP, na.rm = TRUE)) %>%
      select(PPG, RPG, APG, SPG, BPG, TOPG) %>%
      gather(key = Category, value = performance)
  })

  # player page graph 1
  output$player_bar <- renderPlotly({
    title <- paste0(input$name, "'s Perfomance Data")
    p1 <- ggplot(data = player_data(), aes(x = Category, y = performance)) +
      geom_bar(stat = "identity", fill = "#92B5D8", width = 0.7,
               color = "#000080") +
      theme_minimal() +
      geom_text(aes(label = performance), vjust = -10,
                color = "#383A3A", size = 4) +
      scale_x_discrete(limits = c("PPG", "RPG", "APG", "SPG", "BPG", "TOPG")) +
      labs(x = "Value", y = "Category",
           title = title)
    return(p1)
  })
  # player page ends here

}
