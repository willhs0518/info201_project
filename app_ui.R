library(shiny)
library(ggplot2)
library(plotly)
library(shinythemes)
library(dplyr)

# Introduction Page
intro_page <- tabPanel(
  "Introduction",
  titlePanel("Introduction"),
    mainPanel(
      tags$img(src = "nba.jpg", height = 300, width = 700),
      h3("Background/ Domain of Interest"),
      p("\n", "As the world knows, the Coronavirus outbreak has affected
        many things in the world. One of the many things that was
        affected was sports. Ａ lot of sports were put on hold in light
        of health safety concerns during the COVID period. We are
        interested in using the data of the latest NBA game season to
        look ahead and evaluate each team and each individual player’s
        performance."),
      br(),
      h3("Our data"),
      p("\n", "We will be using the NBA player stats dataset for the
        latest 2018-2019 game season as the 2019-2020 season was
        suspended due to the pandemic.", a("This",
        href = "https://www.nbastuffer.com/2018-2019-nba-player-stats/"),
        "is the link to the website of our used datasets. We downloaded
        the datasets and save them as csv files."),
      br(),
      h3("Objectives"),
      p("\n", "We aim to analyze the latest game season that was played
        in the NBA before the pandemic hit. We will be providing
        interactive visualizations to better aid your understanding of
        our examination of performance of each player, team, and position
        in the season. In addition, we would like to help you make better
        predictions as to who is more likly to have better performance as
        a player and as a team in the next season based on their
        performance in this season."),
      br(),
      h3("Questions to be answered?"),
      p("\n", "As mentioned above, we will be examining the performance
        data of 2018-2019 NBA seasons. In our alaysis, we're looking to
        answer the basic questions, including how was the performance of
        each player, each team, and each position in the latest season,
        as well as some critical thinkings brought along with these basic
        questions. We want to know can scoring ability define a player's
        ability, for teams that also participated in the playoffs, was
        there any difference between regular season and playoffs in terms
        of the team's performance, and was there any difference among
        positions in terms of winning strategies. These questions can be
        better understood after exploring data using our app. We hope to
        make the basktball lovers in looking forward to upcoming seasons
        post the pendemic"),
      br(),
      h3("Our members"),
      p("\n", "This shiny app is created collaboratively by: Emily Yu,
        William Huang, Mekides Demile, Quynh Doan"),
      br()
  )
)

# Player Page (interactive page 1)
page_one <- tabPanel(
  "Exploring Player's Performance",
  titlePanel("Player's Performance"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "name",
                   label = h3("Select Player"),
                   choices = regular_df %>%
                    arrange(FULL.NAME) %>%
                    select(FULL.NAME),
                   selected = "Aaron Gordon"
      ),
      uiOutput("textui"),
      br(),
    ),
    mainPanel(
      h3("Critical Question: How did each player perform in the latest
         NBA Season? Can scoring ability define a player's ability?"),
      br(),
      plotlyOutput(outputId = "player_bar"),
      br(),
      p("\n", strong("Description:"), "This page allows you to search for
        the performance of a particular player in the season. The plots
        summarize the player's performance based on different categories.
        It is important to note that most of the players may have points
        per game higher than other categories, but there are still some
        players having value in categories other than points per game,
        meaning they relatively focus on defense rather than offensive or
        trying to score. Players can contribute to the score in
        different ways.")
    )
  )
)

# Team Page (interactive page 2 for all teams)
page_two <- tabPanel(
  "Exploring Team's Performance",
  titlePanel("Team's Performance"),
  sidebarLayout(
    sidebarPanel(
      radioButtons(inputId = "radio2",
                   label = h3("View Teams"),
                   choices = list(
                     "Atl" = "Atl",
                     "Bos" = "Bos",
                     "Bro" = "Bro",
                     "Cha" = "Cha",
                     "Chi" = "Chi",
                     "Cle" = "Cle",
                     "Dal" = "Dal",
                     "Den" = "Den",
                     "Det" = "Det",
                     "Gol" = "Gol",
                     "Hou" = "Hou",
                     "Ind" = "Ind",
                     "Lac" = "Lac",
                     "Lal" = "Lal",
                     "Mem" = "Mem",
                     "Mia" = "Mia",
                     "Mil" = "Mil",
                     "Min" = "Min",
                     "Nor" = "Nor",
                     "Nyk" = "Nyk",
                     "Okc" = "Okc",
                     "Orl" = "Orl",
                     "Phi" = "Phi",
                     "Pho" = "Pho",
                     "Por" = "Por",
                     "Sac" = "Sac",
                     "San" = "San",
                     "Tor" = "Tor",
                     "Uta" = "Uta",
                     "Was" = "Was"
                   ),
                   selected = "Atl"
      ),
    ),
    mainPanel(
      h3("Critical Question: Averagely, how did each team perform in the
         latest NBA Season?"),
      br(),
      plotlyOutput(outputId = "bar"),
      br(),
      p("\n", strong("Description:"), "This page allows you to search for
        the performance of a particular team in the season. The plots
        summarize the team's average performance. These average values
        are obtained by taking the mean of performance data of all
        players in the team, so the team's average performance can be
        better presented as there can be talented star players and new
        players in the same team.")
    )
  )
)

# Team Page (interactive page 3 for teams also participated in playoff)
page_three <- tabPanel(
  "Teams in Regular Season vs Playoffs",
  titlePanel("Team's Performance"),
  sidebarLayout(
    sidebarPanel(
      radioButtons(inputId = "radio3",
                   label = h3("View Teams Participated in Playoffs"),
                   choices = list(
                     "Boston Celtics" = "Bos",
                     "Brooklyn Nets" = "Bro",
                     "Denver Nuggets" = "Den",
                     "Detroit Pistons" = "Det",
                     "Golden State Warriors" = "Gol",
                     "Houston Rockets" = "Hou",
                     "Indiana Pacers" = "Ind",
                     "LA Clippers" = "Lac",
                     "Milwaukee Bucks" = "Mil",
                     "Oklahoma City Thunder" = "Okc",
                     "Orlando Magic" = "Orl",
                     "Philadelphia 76ers" = "Phi",
                     "Portland Trail Blazers" = "Por",
                     "San Antonio Spurs" = "San",
                     "Toronto Raptors" = "Tor",
                     "Utah Jazz" = "Uta"
                   ),
                   selected = "Bos"
      ),
    ),
    mainPanel(
      h3("Critical Question: For teams that also participated in the
         playoffs, was there any difference between regular season and
         playoffs in terms of the team's performance?"),
      br(),
      plotlyOutput(outputId = "plot"),
      br(),
      p("\n", strong("Description:"), "This page allows you to search for
        the performance of a particular team in the regular season and
        the playoffs. The plot displays the VI values in both the regular
        season and the playoffs. Note that not all the teams participate
        in the playoffs, and this page is for teams participated in both
        types of games only.")
    )
  )
)


# Position Page (interactive page 4)
page_four <- tabPanel(
  "Exploring Position's Performance",
  titlePanel("Position's Performance"),
  sidebarLayout(
    sidebarPanel(
      radioButtons(inputId = "radio4",
                   label = h3("View Positions in Courts"),
                   choices = list(
                     "C" = "C",
                     "C-F" = "C-F",
                     "F" = "F",
                     "F-C" = "F-C",
                     "F-G" = "F-G",
                     "G" = "G",
                     "G-F" = "G-F"
                   ),
                   selected = "C"
      )
    ),
    mainPanel(
      h3("Critical Question: How did each position in courts perform in
         the latest NBA Season? Was there any difference among positions
         in terms of winning strategies?"),
      br(),
      plotlyOutput(outputId = "graph"),
      br(),
      plotlyOutput(outputId = "scatter"),
      br(),
      p("\n", strong("Description:"), "This page allows you to search for
        the performance of a particular position in courts. The plots
        show the performance data of points per game and VI values of all
        players playing that position as well as the overall offensive
        and defensive ratings of all players colored based on
        positions.")
    )
  )
)

# Summary/ takeaways page
summary_page <- tabPanel(
  "Summary",
  titlePanel("Summary & Major Takeaways"),
    mainPanel(
      h3("Can scoring ability (PPG) define a player's ability?"),
      h4("Insights"),
      p("\n", "After exploring performance data of different players
        using our exploring player's performance page, we believe you
        would notice that most of the players have value of points per
        game(PPG) higher than any other categories, but there are still
        some players having higher value in categories other than PPG,
        meaning they focus on defense rather than offense. An example is
        shown below."),
      br(),
      tags$img(
        src = "defensive_player.png",
        height = 400,
        width = 500
      ),
      br(),
      br(),
      h4("Implications"),
      p("\n", "Those talented players who are good at shooting and
        getting points will definitely catch people’s attention, but it
        is important to not ignore the fact that each player can
        contribute to the game or scoring in different ways, such as
        getting rebounds, blocking the ball for their teammates. We hope
        that the importance of these players can be recognized as well."),
      br(),
      h3("Relationship between a player's points per game (PPG) and VI"),
      h4("Insights"),
      p("\n", "After using our exploring position's performance page,
        you would notice that PPG and VI chart for positions show a trend
        that the points represent players do not form a linear line with
        coefficient 1. As many people believe that VI basically measure
        a player's ability to score and get points, we hope that through
        using our app you can understand that this is incorrect."),
      br(),
      tags$img(
        src = "ppg_vs_vi.png",
        height = 400,
        width = 500
      ),
      br(),
      br(),
      h4("Implications"),
      p("\n", "VI, Versatility Index, is a metric that measures a
        player’s ability. A typical player will have a VI value around 5
        while some talented players can have a value of 10. It measures
        a player's ability to produce not only in points, but also in
        other categories, including rebounds and assists. As many people
        have misunderstood the definition of VI measurement, we hope that
        through these visualizations people can have a better
        understandings about these performance data and measurements. As
        shown in the graph, even though it shows a linear trend, it is
        definitely not a linear line with coefficient 1, proven that
        the VI is not just defined by a player's scoring, otherwise, the
        graph would just be a linear line with a constant coefficient."),
      br(),
      h3("Different nature of each position in courts"),
      h4("Insights"),
      p("\n", "After using our exploring position's performance page,
        you could see the graph showing the overall offensive rate
        versus defensive rate among all positions in courts. The graph
        suggests that different position can have slightly different
        strategies on winning or playing the game."),
      br(),
      tags$img(
        src = "position.png",
        height = 400,
        width = 500
      ),
      br(),
      br(),
      h4("Implications"),
      p("\n", "The graph shows that some posisitons generally have a
        higher offensive rate over defensive rate while some other
        positions have a higher defensive rate compared to offensive
        rate. This suggests the different nature of each position as
        they focus on different strategies and different ways of
        contributing to the game. As stated above that VI is measure
        not only based on players' scoring. The different nature of
        positions is the main reason of defining VI in such way as
        it will be unfair to define a player's ability just by looking
        at the ability to score. The importance of defensive should not
        be ignored."),
      br(),
      h3("Conclusion"),
      p("\n", "After using our app to explore NBA performance data from
        different perspectives, we hope that this app brings a better
        understandings about the detailed performance of each player,
        team, and position in courts as well as the importance of each
        player and position. This apps allows you to make better
        predictions about players or teams which might have a better
        performance in the future based on this lastest game season, but
        please also be aware that a lot of things or factors could affect
        players or teams' performance, such as injury and improvement.")
    ),
  br()
)

ui <- navbarPage(
  "NBA Statistics",
  theme = shinytheme("cosmo"),
  intro_page,
  page_one,
  page_two,
  page_three,
  page_four,
  summary_page,
  includeCSS("style.CSS")
)
