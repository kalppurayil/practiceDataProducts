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
    mtcars$mpgsp <- ifelse(mtcars$mpg - 20 > 0, mtcars$mpg - 20, 0)
    model1 <- lm(hp ~ mpg, data = mtcars)
    model2 <- lm(hp ~ mpg + mpgsp, data = mtcars)
    
    predHPmodel1 <- reactive({
        mpgInput <- input$sliderMPG
        predict(model1, data.frame(mpg = mpgInput))
    })
    
    predHPmodel2 <- reactive({
        mpgInput <- input$sliderMPG
        predict(
            model2, 
            data.frame(
                mpg = mpgInput,
                mpgsp = ifelse(mpgInput-20>0, mpgInput-20, 0)
            )
        )
    })

    output$modelPlot <- renderPlot({
        mpgInput <- input$sliderMPG
        plot(
            x = mtcars$mpg,
            y = mtcars$hp,
            type = "p",
            xlab = "Miles per Gallon",
            ylab = "Horsepower"
        )
        if(input$showModel1){
            abline(
                a = model1$coefficients[1],
                b = model1$coefficients[2],
                col = "red"
            )
        }
        if(input$showModel2){
            model2lines <- predict(
                model2, 
                data.frame(
                    mpg = 1:35,
                    mpgsp = ifelse(1:35-20>0, 1:35-20, 0)
                ))
            lines(
                x = 1:35,
                y = model2lines
            )
        }
        legend(25, 250, c("Model 1 Prediction", "Model 2 Prediction"), pch = 16, 
               col = c("red", "blue"), bty = "n", cex = 1.2)
        points(mpgInput, predHPmodel1(), col = "red", pch = 16, cex = 2)
        points(mpgInput, predHPmodel2(), col = "blue", pch = 16, cex = 2)
    })
        
    output$resultsModel1 <- renderText(
        predHPmodel1()
    )
    
    output$resultsModel2 <- renderText(
        predHPmodel2()
    )

})
