if(!isNamespaceLoaded("shinydashboard")) library(shinydashboard)
if(!isNamespaceLoaded("shiny")) library(shiny)

### UI

ui <- dashboardPage(
  
  dashboardHeader(title = "Yelp"),
  
  dashboardSidebar(
    
    sidebarMenu(
    menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
    menuItem("Widgets", tabName = "CSV", icon = icon("th"))
  )
  
  ),
  
  dashboardBody(
    
    tabItems(
      # First tab content
      tabItem(tabName = "dashboard",
              fluidRow(
                box(plotOutput("plot1", height = 250)),
                
                box(
                  title = "Controls",
                  sliderInput("slider", "Number of observations:", 1, 100, 50)
                )
              )
      ),
      
      # Second tab content
      tabItem(tabName = "CSV",
              h2("Widgets tab content"),
              sidebarLayout(
                sidebarPanel(
                  fileInput("file1", "Choose CSV File",
                            accept = c(
                              "text/csv",
                              "text/comma-separated-values,text/plain",
                              ".csv")
                  ),
                  tags$hr(),
                  checkboxInput("header", "Header", TRUE)
                ),
                mainPanel(
                  tableOutput("contents")
                )
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
    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, it will be a data frame with 'name',
    # 'size', 'type', and 'datapath' columns. The 'datapath'
    # column will contain the local filenames where the data can
    # be found.
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    
    read.csv(inFile$datapath, header = input$header)
    # View(inFile)
  })
}


shinyApp(ui = ui, server = server)