if(!isNamespaceLoaded("shinydashboard")) library(shinydashboard)
if(!isNamespaceLoaded("shiny")) library(shiny)

### UI

ui <- dashboardPage(
  
  dashboardHeader(title = "Yelp"),
  
  dashboardSidebar(
    
    sidebarMenu(
    menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
    menuItem("CSV", tabName = "CSV", icon = icon("th")),
    menuItem("Cognitive Services", tabName = "Cognitive", icon = icon("th"))
  )
  
  ),
  
  dashboardBody(
    
    tabItems(
      # First tab content
      tabItem(
        
        tabName = "dashboard",
        fluidRow(
          
            box(plotOutput("plot1", height = 250)),
                
            box(
                title = "Controls",
                sliderInput("slider", "Number of observations:", 1, 100, 50)
                )
            
              )
        
      ),
      
      # Second tab content
      tabItem(
        
        tabName = "CSV",
        h2("CSV Viewer"),
        sidebarLayout(
        sidebarPanel(
        fileInput("file1", "Choose CSV File",
                      accept = c(
                      "text/csv",
                      "text/comma-separated-values,text/plain",
                      ".csv")
                  ),
        tags$hr(),
        checkboxInput("header", "Header", TRUE), width = "10%"
              ),
        
        mainPanel( tableOutput("contents") )
          )
        ),
      
      
      # Third tab content
      tabItem(
        
        tabName = "Cognitive",
        box(
          
          
          
        )
        
              
              
              
        )
      
    )
    
  )
  
)


### Server Side

server <- function(input, output) {
  set.seed(122)
  histdata <- rnorm(500)
  
  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
  })
  
  output$contents <- renderTable({
    if (is.null(inFile))
      return(NULL)
    inFile <- input$file
    
    read.csv(inFile$datapath, header = input$header)
  })
  
  
  
  
  
}


shinyApp(ui = ui, server = server)









