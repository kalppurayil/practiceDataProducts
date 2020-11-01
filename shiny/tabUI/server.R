#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    outputfn <- reactive({
        paste(input$text1, "__") 
    })

    output$outputtext1 <- renderText(outputfn())
    output$outputtext2 <- renderText(input$text2)
    output$outputtext3 <- renderText(input$text3)

})
