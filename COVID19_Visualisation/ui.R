shinyUI(fluidPage(
    titlePanel("COVID-19 Dashboard"),
    
    fluidRow(
        fluidRow(
            uiOutput("keyFigures")
        ), 
        fluidRow(
            column(
                leafletOutput("overview_map")
            ), 
            column(
                uiOutput("summary")
            ),
            column(
                sliderInput(
                    "sliderDate", 
                    label="Select Date", 
                    min=min(world_data$date),
                    max=max(world_data$date), 
                    value=max(world_data$date)
                )
            )
        )
    ),
    
    # mainPanel(
    #     plotlyOutput('covidMap')
    # )
)
)
