library(gapminder)
library(dplyr)
library(ggplot2)
library(plotly)

selected_continent <- "Asia"
selected_country <- "Afghanistan"
prediction_year <- 2020

base_df <- subset(gapminder, country == selected_country)
base_df$obs_or_pred <- "Obs"

model_lifeExp <- lm(
  formula = lifeExp ~ year,
  data = base_df
)

model_pop <- lm(
  formula = pop ~ year,
  data = base_df
)

model_gdpPercap <- lm(
  formula = gdpPercap ~ year,
  data = base_df
)

prediction_df <- data.frame(year = prediction_year, country = selected_country, continent = selected_continent)
prediction_df$lifeExp <- predict(model_lifeExp, data.frame(year = prediction_year))
prediction_df$pop <- predict(model_pop, data.frame(year = prediction_year))
prediction_df$gdpPercap <- predict(model_gdpPercap, data.frame(year = prediction_year))
prediction_df$obs_or_pred <- "Pred"

total_df <- rbind(base_df, prediction_df)

p <- ggplot(
  data = total_df,
  mapping = aes(
    x = year,
    y = lifeExp
  )
)

q <- p + 
  geom_point(
    data = total_df,
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
    data = base_df, 
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
    y = "Life Expectancy"
  ) +
  guides(
    linetype = FALSE,
    color = FALSE
  ) +
  scale_color_discrete(
    name = "Color/Linetype"
  )

myplot <- ggplotly(q)
myplot$x$data[[1]]$name <- "Observations"
myplot$x$data[[2]]$name <- "Prediction"
myplot$x$data[[3]]$name <- "Extrapolated"
myplot$x$data[[4]]$name <- "Fitted"
myplot
