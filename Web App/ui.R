library(leaflet)
library(shinydashboard)

dashboardPage(
  
  dashboardHeader(title= "Yelp"),
  
  dashboardSidebar(
    
    sidebarMenu(
      
      ## Insert tabs here
      menuItem("Home", tabName = 'home', icon = icon("home")),
      menuItem("CSV Explorer", tabName = "csvExplorer", icon = icon("th")),
      menuItem("Cognitive Services", tabName = "cognitive", icon = icon("th"))
      
    )
  ),
  
    dashboardBody(
      
      tabItems(
        
        
        ## First Tab
        tabItem(
          
          tabName = "home",
          fluidRow(
            
            box(plotOutput("plot1", height = 250)),
            
            box(
              title = "Controls",
              sliderInput("slider", "Number of observations:", 1, 100, 50)
              )
            
          )
          
        ),
        
        ## Second Tab
        tabItem(
          
            tabName = "csvExplorer",
            fluidRow(
              navbarPage("Files", id="nav",
                         
                         
                         tabPanel("Data explorer",
                                  
                                  fluidRow(
                                    
                                    fileInput("file", "Upload csv", accept = c( "text/csv", "text/comma-separated-values,text/plain", ".csv")),
                                    hr(),
                                    DT::dataTableOutput("ziptable")
                                          ),
                                  
                                  conditionalPanel("false", icon("crosshair"))
                                ),
                         
                         tabPanel("Conversion",
                                  fluidRow(
                                    
                                          )
                                  )
                      )
                   )
                ),
        
        ## Third Tab
        
          tabItem(
            tabName = "cognitive"
            
          )
        
      )
      
    )
    
    
  )
  
  
