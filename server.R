# Final Project
library(ggplot2)
library(dplyr)
library(shiny)
library(tidyverse)



setwd <- ("~/Desktop/final")
m_data <- read.csv("movie_metadata.csv") %>% as.data.frame()
  
my.server <- function(input, output) {
  output$data_info <- renderText({
    paste("Data generated from the IMDB dataset")
  })
  output$info <- renderText({
    paste("This application generates movie recommendation based on the user's input.
          The user will be asked to select its preferred genre of the movie, country where the movie is filmed,
          content rating of the movie, as well as the IMDB rating of the movie. After selecting those preferences,
          this application will filter out movies that match the user's preference. The table below shows the title 
          of the movie, the plot keywords of the movie, the duration of the movie, and lastly, the raing of the movie.")
  })
  filter_data <- reactive({
    high_rating <- input$i_rating[2]
    low_rating <- input$i_rating[1]
    r_country  <- input$country
    r_year <- input$year
    r_rating <- input$c_rating
    data <- m_data %>% filter(title_year == r_year) %>% filter(imdb_score <= high_rating) %>% filter (imdb_score >= low_rating) %>% 
      filter(str_detect(genres, input$genre)) %>% filter(content_rating == r_rating)
    num <- nrow(data)
    if (num > 10) {
      num <- 10
    }
    data <- sample_n(data, num)
  })
  output$table <- renderDataTable({
    DT::datatable((select(filter_data(), c("movie_title", "plot_keywords", "duration", "imdb_score"))), 
                  options = list(paging = FALSE), rownames = FALSE)
  })
  output$plot <- renderPlot({
    plot_data <- filter(filter_data())
    ggplot(plot_data, aes((x = imdb_score), y = (movie_facebook_likes), label=movie_title)) +
      labs(y = "Number of Likes on Facebook", x = "IMDB Score") +
      geom_text(aes(label=movie_title),hjust=-.5, vjust=.5) +
      ggtitle("Likes vs Rating Chart ") + 
      theme(plot.title = element_text(face="bold", size=30, color = "grey")) +
      theme(axis.title = element_text(face="bold", size=20, color = "yellowgreen")) +
      theme(panel.background = element_rect(fill = "lightsteelblue2",colour = "lightsteelblue2", size = 1, linetype = "solid"))
  })
}
shinyServer(my.server)