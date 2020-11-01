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
    titlePanel("Trial Tab UI"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            textInput(
                "text1",
                "Number of bins:",
                value = "Text1"
            ),
            textInput(
                "text2",
                "Number of bins:",
                value = "Text2"
            ),
            textInput(
                "text3",
                "Number of bins:",
                value = "Text3"
            ),
            submitButton(
                "Submit"
            )
        ),

        # Show a plot of the generated distribution
        mainPanel(
            tabsetPanel(
                type = "tabs",
                tabPanel("tab1", br(), textOutput("outputtext1")),
                tabPanel("tab2", br(), textOutput("outputtext2")),
                tabPanel("tab3", br(), textOutput("outputtext3"))
            )
        )
    )
))
