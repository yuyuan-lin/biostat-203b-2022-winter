# Load packages ----
library(shiny)
library(tidyverse)

# Load data ----
icu_cohort <- readRDS("icu_cohort.rds")

# User interface ----
ui <- fluidPage(
  titlePanel("Vistualization of MIMIC IV Data"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Select a lab or vital measurement and a graphic type below.
               The data was from MIMIC IV database"),
      
      selectInput(inputId = "var", label = "Lab/vital measurement",
                  choices = c("Heart rate" = 220045, 
                              "Mean non-invasive blood pressure" = 220181, 
                              "Systolic non-invasive blood pressure" = 220179, 
                              "Body temperature in Fahrenheit" = 223761, 
                              "Respiratory rate" = 220210, 
                              "Creatinine" = 50912, 
                              "Potassium" = 50971, 
                              "Sodium" = 50983, 
                              "Chloride" = 50902, 
                              "Bicarbonate" = 50882, 
                              "Hematocrit" = 51221, 
                              "White blood cell count" = 51301, 
                              "Glucose" = 50931, 
                              "Magnesium" = 50960, 
                              "Calcium" = 50893),
                  multiple = FALSE),
      
      br(),
      
      selectInput(inputId = "geom", label = "Graphic Type",
                  choices = c("Histogram" = "hist",
                              "Density Plot" = "dens",
                              "Box Plot" = "boxp"),
                  multiple = FALSE),
      
      br(),
      
      checkboxInput(inputId = "Compare", 
                    "Compare groups devided by 30-day-mortality", value = FALSE)
    ),
    
    mainPanel(plotOutput(outputId = "plot"),
              tableOutput(outputId = "test"),
              textOutput(outputId = "test2"))
  )
)


# Server logic ----
server <- function(input, output) {
  
  data_plot <- reactive({
    var_name <- str_c("itemid_", input$var)
    icu_cohort %>% 
      select(c(var_name, "thirty_day_mort")) %>%
      mutate(thirty_day_mort = as.factor(thirty_day_mort))
  })
  
  output$plot <- renderPlot({
    var_name <- str_c("itemid_", input$var)
    
    plot <- ggplot(data_plot(), mapping = aes(x = get(var_name))) + 
      theme_classic() +
      labs(title = str_c("Histogram of ", var_name),
           x = var_name)
    
    if (input$geom == "hist") {
      plot <- plot + geom_histogram()
    }
    if (input$geom == "boxp") {
      plot <- plot + geom_boxplot()
    }
    if (input$geom == "dens") {
      plot <- plot + geom_density()
    }
    
    plot
  })
  
  output$test <- renderTable({
    head(data_plot())
  })
  
  output$test2 <- renderText(print(str_c("itemid_", input$var)))
  
}

# Run the app ----
shinyApp(ui, server)
