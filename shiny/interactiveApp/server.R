#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$distPlot <- renderPlot({

        randomPoints <- input$randomPoints
        xSliderMin <- input$xSlider[1]
        xSliderMax <- input$xSlider[2]
        ySliderMin <- input$ySlider[1]
        ySliderMax <- input$ySlider[2]
        xLabelCheck <- input$xLabelCheck
        yLabelCheck <- input$yLabelCheck
        titleCheck <- input$titleCheck

        x_points <- runif(randomPoints, xSliderMin, xSliderMax)
        y_points <- runif(randomPoints, ySliderMin, ySliderMax)
        
        plot(
            x_points,
            y_points,
            xlim = c(-100,100),
            ylim = c(-100,100),
            xlab = ifelse(xLabelCheck==1, "X-axis", NA),
            ylab = ifelse(yLabelCheck==1, "Y-axis", NA),
            main = ifelse(titleCheck==1, "Graph of Random Points", NA),
        )

    })

})
