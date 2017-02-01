library(leaflet)
library(shinydashboard)


dashboardPage(
  
  dashboardHeader(title= "Yelp"),
  
  dashboardSidebar(
    includeCSS("www/styles.css"),
    
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
                                    DT::dataTableOutput("csvtable")
                                          ),
                                  
                                  conditionalPanel("false", icon("crosshair"))
                                ),
                         
                         tabPanel("Feature Engineering",
                                  fluidRow(
                                            a(list.files())
                                          )
                                  )
                      )
                   )
                ),
        
        ## Third Tab
        
          tabItem(
            tabName = "cognitive",
            
            fluidRow( id="cognitiveTab",
              
              h2( style = "margin-left:1%; font-family:helvlight;", "Analyze your data"),
              
            
              navbarPage("Analytics", id="nav-analytics",
                         
                         
                         tabPanel("Microsoft Entity Linking",
                                  
                                  fluidRow(
                                    
                                    actionButton(inputId="analyzeButton", "Start"),
                                    
                                    DT::dataTableOutput("analysis")
                                  )
                         ),
                         
                         tabPanel("Microsoft Text Analytics",
                                  fluidRow(
                                    actionButton(inputId="textaButton", "Begin"),
                                    DT::dataTableOutput("textaTable")
                                  )
                         ),
                        
                         tabPanel("Stanford CoreNLP",
                                  fluidRow(
                                    actionButton(inputId="corenlpButton", "Start Annotation"),
                                    DT::dataTableOutput("corenlptable")
                                    
                                  )
                                  
                                  
                                  )
              )
              
            )
            
          )
        
      )
      
    )
    
    
  )
  
  
