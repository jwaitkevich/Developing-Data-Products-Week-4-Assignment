#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("NBA Per Game Stats from 2018-19 Season"),

    # Sidebar with a slider input for number of bins
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

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot"),
            textOutput("instructions")
        )
    )
))
