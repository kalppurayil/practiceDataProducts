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
    titlePanel("Plot Random Numbers"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            numericInput(
                inputId = "randomPoints",
                label = "How Many Random Numbers should be Plotted?",
                value = 500,
                min = 0,
                max = 1000
            ),
            sliderInput(
                "xSlider",
                "Pick minimum and maximum X values.",
                min = -100,
                max = 100,
                value = c(-50, 50)
            ),
            sliderInput(
                "ySlider",
                "Pick minimum and maximum Y values.",
                min = -100,
                max = 100,
                value = c(-50, 50)
            ),
            checkboxInput(
                "xLabelCheck",
                "Show/Hide X-axis label",
                value = TRUE
            ),
            checkboxInput(
                "yLabelCheck",
                "Show/Hide Y-axis label",
                value = TRUE
            ),
            checkboxInput(
                "titleCheck",
                "Show/Hide Title",
                value = TRUE
            )
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot")
        )
    )
))
