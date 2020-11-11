#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(gapminder)
library(dplyr)
library(ggplot2)
library(plotly)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    
    total_df <- reactive({
        
        base_df <- subset(gapminder, country == input$selected_country)
        base_df$obs_or_pred <- "Obs"
        
        selected_country <- input$selected_country
        selected_continent <- unique(base_df$continent)
        prediction_year <- input$prediction_year
        
        model_pop <- lm(
            formula = pop ~ year,
            data = base_df
        )
        
        prediction_df <- data.frame(year = prediction_year, country = selected_country, continent = selected_continent)
        prediction_df$lifeExp <- 0
        prediction_df$pop <- predict(model_pop, data.frame(year = prediction_year))
        prediction_df$gdpPercap <- 0
        prediction_df$obs_or_pred <- "Pred"
        
        rbind(base_df, prediction_df)
        
    })
    
    output$modelPlot <- renderPlot({
        p <- ggplot(
            data = total_df(),
            mapping = aes(
                x = year,
                y = pop
            )
        )
        
        p + 
            geom_point(
                data = total_df(),
                aes(color = obs_or_pred)
            ) +
            geom_smooth(
                aes(
                    color = "Pred", 
                    linetype = "Pred"
                ),
                method = "lm", 
                se = FALSE, 
                fullrange = TRUE
            ) + 
            geom_smooth(
                data = subset(total_df(), obs_or_pred == "Obs"), 
                mapping = aes(
                    color = "Obs", 
                    linetype = "Obs"
                ),
                size = 1.15, 
                se = FALSE, 
                method = "lm"
            ) +
            labs(
                x = "Year", 
                y = "Population"
            )  +
            scale_color_discrete(
                name = "Color/Linetype"
            ) +
            scale_y_continuous(label=scales::comma)
    
    })
    
    output$selected_country <- renderText({input$selected_country})
    

})
