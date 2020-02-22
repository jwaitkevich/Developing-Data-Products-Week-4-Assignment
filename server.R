#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(rvest)
library(dplyr)
url <- "https://www.basketball-reference.com/leagues/NBA_2019_per_game.html"
nba.ref <- read_html(url)
nba.ds <- nba.ref %>%
    html_nodes(xpath='//*[@id="per_game_stats"]') %>%
    html_table(fill = TRUE)
nba.totals <- nba.ds[[1]]
clean.nba.totals <- subset(nba.totals, Rk != "Rk", select = c("Rk", "Player", "Tm", "TRB", "AST", "PTS"))
clean.nba.totals$Rk <- as.numeric(unlist(clean.nba.totals$Rk))
clean.nba.totals$PTS <- as.numeric(clean.nba.totals$PTS)
clean.nba.totals$TRB <- as.numeric(clean.nba.totals$TRB)
clean.nba.totals$AST <- as.numeric(clean.nba.totals$AST)
points <- clean.nba.totals[,c(1,6)]
assists <- clean.nba.totals[,c(1,5)]
rebounds <- clean.nba.totals[,c(1,4)]

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$distPlot <- renderPlot({

        # generate bins based on input$bins from ui.R
        x    <- switch(input$dist,
                       PTS = points[,2],
                       AST = assists[,2],
                       TRB = rebounds[,2])
        
        bins <- seq(min(x), max(x), length.out = input$bins+1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = "red", border = "blue", xlab = "Per Game Average", main = "Histogram of Selected Stat")

    })
    
    output$instructions <- renderText({
        "To use this app, select which statistic from the three provided you would like to see. Then, select how many bins you want the histogram to show. The defaults are Points and 10 bins. The dataset was pulled from basketball-reference.com"
    })

})
