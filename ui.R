library(ggplot2)
library(dplyr)
library(shiny)
library(tidyverse)
library(shinycssloaders)
library(plotly)
library(DT)
library(shinythemes)

my.ui <- fluidPage(
  includeCSS("myStyle.css"),
  titlePanel("Movie Filter"),
  sidebarPanel(
    selectInput("genre", "Movie's Genre:", choices = c("Select" = "", "Action", "Adventure", "Animation", "Biography", "Comedy", "Crime", "Documentary", 
                                                         "Drama", "Family", "Fantasy", "Foreign", "History", "Horror", "Mystery", "Musical","Romance", 
                                                         "Sci-Fi", "Sport", "Thriller","War")),
    
    selectInput("country", "Movie's Country:", choices = c("Select" = "", "Afghanistan", "Argentina", "Australia", "Belgium", "Brazil", "Canada", "China", 
                                                           "Denmark", "France", "Germany", "Hong Kong", "India", "Ireland", "Israel", "Russia", "Slovalia",
                                                           "Slovenia", "South Africa", "Italy", "Japan", "Mexico", "Netherlands", "New Zealand","Norway", 
                                                           "Poland","South Korea", "Spain", "Sweden", "Switzerland", "Taiwan", "Thailand", "Turkey", "UK", "USA")),
    radioButtons("c_rating", "Movie's Content Rating:", choices = c("Select" = "", "G", "PG", "PG-13", "R", "TV-14", "TV-PG" ), selected = NULL, inline = FALSE,
                 width = NULL), 
    textInput("year", label = "Year Released", value = ""),
    sliderInput("i_rating", label = "Rating:", min = 0, max = 10, value = c(0, 10)),
    width = 4

  ),
  mainPanel(
    textOutput("info"),
    br(), 
    textOutput("data_info"),
    br(),
    dataTableOutput('table'),
    br(),
    plotlyOutput('plot1'),
    br(),
    plotlyOutput('plot2'),
    br(),
    plotlyOutput('plot3'),
    br(),
    textOutput("graph_info"),
    br(),
    br()
  )
)

shinyUI(my.ui)
