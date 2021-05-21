shinyUI(dashboardPage(
    dashboardHeader(title="COVID-19 Dashboard"),
    dashboardSidebar(
        sidebarMenu(
            menuItem("Overview", tabName="overview", icon=icon("globe")),
            menuItem("Graphs", tabName="graphs", icon=icon("chart-line")),
            menuItem("About", tabName="about", icon=icon("info-circle"))
        )
    ),
    dashboardBody(
        tabItems(
            tabItem(tabName="overview", 
                    fluidRow(
                        valueBoxOutput("values_confirmed"), 
                        valueBoxOutput("values_deaths"),
                        valueBoxOutput("values_prop_vaccinated")
                    ),
                    fluidRow(width=12,
                             box(title="World Overview",
                                 solidHeader=TRUE,
                                 status="primary",
                                 width="null",
                                 leafletOutput("overview_map")
                             )
                    ),
                    fluidRow(
                        column(width=10, offset=1,
                               sliderInput("sliderDate",
                                           label="Select Date:",
                                           min=min(world_data$date),
                                           max=max(world_data$date),
                                           value=max(world_data$date), 
                                           width="100%")
                        )
                    )
            ),
            tabItem(tabName="graphs",
                    h2("graph")),
            tabItem(tabName="about",
                    h2("about"))
        )
    )
))