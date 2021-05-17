library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    title="COVID-19 Dashboard", 
    
    # Navigation Bar
    navbarPage(
        tabPanel("Overview", page_overview)    
    )
    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot")
        )
    )
))

#https://github.com/chschoenenberger/covid19_dashboard/blob/master/ui.R
#https://towardsdatascience.com/covid-19-open-source-dashboard-fa1d2b4cd985
#https://chschoenenberger.shinyapps.io/covid19_dashboard/