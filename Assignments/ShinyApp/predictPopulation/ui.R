#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(gapminder)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Predict Population of a Country"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            selectInput("selected_country",
                        "Select a country",
                        choices = unique(gapminder$country)
            ),
            sliderInput("prediction_year",
                        "Pick an year to Predict Population",
                        min = 2008,
                        max = 2030,
                        value = 2020,
                        sep = ""
            ),
            submitButton(
                "Submit"
            )
        ),

        # Show a plot of the generated distribution
        mainPanel(
            h3(textOutput("selected_country")),
            plotOutput("modelPlot")
            
        )
    )
))
