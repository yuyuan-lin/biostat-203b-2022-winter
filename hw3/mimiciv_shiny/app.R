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
      helpText("Select a lab or vital measurement."),
      
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
      
      helpText("Select a graphic type and whether comparing between 
               different 30-day-mortality groups to generate a plot"),
      
      selectInput(inputId = "geom", label = "Graphic Type",
                  choices = c("Histogram" = "hist",
                              "Density Plot" = "dens",
                              "Box Plot" = "boxp"),
                  multiple = FALSE),
      
      checkboxInput(inputId = "comp", 
                    "Compare groups devided by 30-day-mortality", 
                    value = FALSE),
      
      br(),
      
      helpText("Select a demographic variable to compare the measurement"),
      
      selectInput(inputId = "demo", label = "Demographic variable",
                  choices = c("Gender" = "gender",
                              "Ethinicity" = "ethnicity",
                              "Language" = "language",
                              "Insurance" = "insurance",
                              "Marital Status" = "marital_status"),
                  multiple = FALSE),
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel(title = "Plot", plotOutput(outputId = "plot")),
        tabPanel(title = "Table by demographic", tableOutput(outputId = "tble"))
      )
    )
  )
)


# Server logic ----
server <- function(input, output) {
  
  # interactive data for plot ----
  data_plot <- reactive({
    var_name <- str_c("itemid_", input$var)
    icu_cohort %>% 
      select(c(var_name, "thirty_day_mort")) %>%
      mutate(thirty_day_mort = as.factor(thirty_day_mort)) %>%
      drop_na()
  })
  
  # interactive data for table ----
  data_table <- reactive({
    var_name <- str_c("itemid_", input$var)
    icu_cohort %>% 
      select(c(var_name, input$demo)) %>%
      drop_na()
  })
  
  # plot output ----
  output$plot <- renderPlot({
    var_name <- str_c("itemid_", input$var)
    
    plot <- ggplot(data_plot(), mapping = aes(x = get(var_name))) + 
      theme_classic() +
      labs(title = str_c("Histogram of ", var_name),
           x = var_name)
    
    if (input$comp) {
      if (input$geom == "hist") 
        plot <- plot + geom_histogram(mapping = aes(fill = thirty_day_mort), 
                                      position = "stack")
      if (input$geom == "boxp") 
        plot <- plot + geom_boxplot(mapping = aes(y = thirty_day_mort))
      if (input$geom == "dens")
        plot <- plot + geom_density(mapping = aes(fill = thirty_day_mort), 
                                    alpha = 0.5)
    }else{
      if (input$geom == "hist") 
        plot <- plot + geom_histogram(fill = "light blue")
      if (input$geom == "boxp") 
        plot <- plot + geom_boxplot()
      if (input$geom == "dens")
        plot <- plot + geom_density()
    }
    
    plot
    
  })
  
  # table output ----
  output$tble <- renderTable({
    var_name <- str_c("itemid_", input$var)
    data_table() %>%
      group_by(get(input$demo)) %>%
      summarize(
        n = n(), 
        `mean of selected measurements` = mean(get(var_name)),
        `SD of selected measurements` = sd(get(var_name)),
        `median of selected measurements` = median(get(var_name)),
        `min of selected measurements` = min(get(var_name)),
        `max of selected measurements` = max(get(var_name))
      ) %>%
      rename(`Selected demographic variable` = "get(input$demo)")
  })

}

# Run the app ----
shinyApp(ui, server)
