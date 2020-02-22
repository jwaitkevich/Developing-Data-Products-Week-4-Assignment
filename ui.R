
library(shiny)

shinyUI(fluidPage(

    titlePanel("NBA Per Game Stats from 2018-19 Season"),

    sidebarLayout(
        sidebarPanel(
            radioButtons("dist", "Statistic:",
                         c("Points" = "PTS",
                           "Assists" = "AST",
                           "Rebounds" = "TRB")),
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 30,
                        value = 10),
        ),

        mainPanel(
            plotOutput("distPlot"),
            textOutput("instructions")
        )
    )
))
