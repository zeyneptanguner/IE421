library(shiny)
library(ggplot2)

mpgData <- mtcars
mpgData$am <- factor(mpgData$am, labels = c("Automatic", "Manual"))

ui <- fluidPage(
  
  titlePanel("Miles per Gallon"),
  sidebarLayout(
    
    sidebarPanel(
      
      selectInput("variable", "Variable:",
                  c("Cylinders" = "cyl",
                    "Transmission" = "am",
                    "Gears" = "gear")),
      
      checkboxInput("outliers", "Show outliers", TRUE)
      
     
    ),
    mainPanel(
      
      
      h3(textOutput("caption")),
      
      
      plotOutput("mpgPlot")
      
    )
    
  )
  
)
server <- function(input, output) {
  

  formulaText <- reactive({
    paste("mpg ~", input$variable)
  })
  

  output$caption <- renderText({
    formulaText()
  })
  
  output$mpgPlot <- renderPlot({
    ggplot(data=mtcars, aes(mpg)) + 
      geom_histogram(binwidth=5,col="steelblue", 
                     fill="steelblue", 
                     alpha = 1) + 
    
      labs(x="mpg", y="Count") + facet_wrap(facets=. ~mpgData[[input$variable]], nrow=3)
    
  })
  
}
  
shinyApp(ui, server) 
