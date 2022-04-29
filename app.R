
library(shiny)
library(rvest)
library(Hmisc)
library(tidyverse)

# get data
people <- c("12719","12929","12713","12712","12891","12934","12933", "13311","13308") #list of IDs

# Week 1
Weekly_total1 <- data.frame(matrix(1, ncol=1, nrow=13)) #create empty table
for (i in people){
    content <- read_html(paste0("https://cricketxi.com/county-championship-2022/league/2859/team/", i , "/1/"))
    tables <- content %>% html_table(fill = TRUE)
    table <- tables[[1]]
    table <- table[c(1,4,5,6,7,9,10,12,14,15,16,17,2),]
    Weekly_total1 <- cbind(Weekly_total1, table)
    names(Weekly_total1)[names(Weekly_total1) == 'matrix.1..ncol...1..nrow...13.'] <- 'Week'
}

# Week 2
Weekly_total2 <- data.frame(matrix(2, ncol=1, nrow=13)) #create empty table
for (i in people){
    content <- read_html(paste0("https://cricketxi.com/county-championship-2022/league/2859/team/", i , "/2/"))
    tables <- content %>% html_table(fill = TRUE)
    table <- tables[[1]]
    table <- table[c(1,4,5,6,7,9,10,12,14,15,16,17,2),]
    Weekly_total2 <- cbind(Weekly_total2, table)
    names(Weekly_total2)[names(Weekly_total2) == 'matrix.2..ncol...1..nrow...13.'] <- 'Week'
}

# Week 3
Weekly_total3 <- data.frame(matrix(3, ncol=1, nrow=13)) #create empty table
for (i in people){
    content <- read_html(paste0("https://cricketxi.com/county-championship-2022/league/2859/team/", i , "/3/"))
    tables <- content %>% html_table(fill = TRUE)
    table <- tables[[1]]
    table <- table[c(1,4,5,6,7,9,10,12,14,15,16,17,2),]
    Weekly_total3 <- cbind(Weekly_total3, table)
    names(Weekly_total3)[names(Weekly_total3) == 'matrix.3..ncol...1..nrow...13.'] <- 'Week'
}

# Week 4
Weekly_total4 <- data.frame(matrix(4, ncol=1, nrow=13)) #create empty table
for (i in people){
    content <- read_html(paste0("https://cricketxi.com/county-championship-2022/league/2859/team/", i , "/4/"))
    tables <- content %>% html_table(fill = TRUE)
    table <- tables[[1]]
    table <- table[c(1,4,5,6,7,9,10,12,14,15,16,17,2),]
    Weekly_total4 <- cbind(Weekly_total4, table)
    names(Weekly_total4)[names(Weekly_total4) == 'matrix.4..ncol...1..nrow...13.'] <- 'Week'
}

Total <- rbind(Weekly_total1, Weekly_total2, Weekly_total3, Weekly_total4)
data <- Total
# Define UI for application that draws a histogram
ui <- fluidPage(
    titlePanel("Cyber Bistro Championship of Cricket (CBCOC)"),
    
    # Create a new Row in the UI for selectInputs
    fluidRow(
        column(4,
               selectInput("week",
                           "Gameweek:",
                           c("All",
                             unique(as.character(data$Week))))
        ),
        column(4,
               selectInput("player",
                           "Players:",
                           c("All",
                             unique(as.character(data$`The Vicars of Sibley`))))
        )
    ),
    # Create a new row for the table.
    DT::dataTableOutput("table")
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    # Filter data based on selections
    output$table <- DT::renderDataTable(DT::datatable({
        data <- Total
        if (input$week != "All") {
            data <- data[data$Week == input$week,]
        }
        if (input$player != "All") {
            data <- data[data$`The Vicars of Sibley` == input$player,]
        }
        data
    }))
    
}
# Run the application 
shinyApp(ui = ui, server = server)
