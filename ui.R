shinyUI(dashboardPage(
    dashboardHeader(title="COVID-19 Dashboard"),
    dashboardSidebar(
        sidebarMenu(
            menuItem("Overview", tabName="overview", icon=icon("globe")),
            menuItem("Country", tabName="country", icon=icon("flag")),
            menuItem("Data Table", tabName="datatable", icon=icon("table")),
            menuItem("About", tabName="about", icon=icon("info-circle"))
        )
    ),
    dashboardBody(
        tabItems(
            tabItem(tabName="overview", 
                    fluidRow(width=12,
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
                    ),
                    fluidRow(width=12,
                             column(width=4,
                                    box(title="Global Confirmed Cases",
                                        solidHeader=TRUE,
                                        status="primary",
                                        width="null",
                                        plotlyOutput("global_cases")
                                    )
                             ),
                             column(width=4, 
                                    box(title="Global New Cases",
                                        solidHeader=TRUE,
                                        status="primary",
                                        width="null",
                                        plotlyOutput("global_newcases")
                                    )
                            ),
                            column(width=4,
                                   box(title="Global Confirmed Deaths",
                                       solidHeader=TRUE,
                                       status="primary",
                                       width="null",
                                       plotlyOutput("global_deaths")
                                   )
                            )
                    )
            ),
            tabItem(tabName="country",
                    fluidRow(width=12,
                            box(pickerInput(
                                inputId="country_select", 
                                label="Country:", 
                                choices=as.character(unique(country_data$location)), 
                                selected=unique(country_data$location)[1],
                                multiple=FALSE
                                )
                            )
                    ),
                    fluidRow(width=12,
                             valueBoxOutput("country_values_confirmed"), 
                             valueBoxOutput("country_values_newcases"),
                             valueBoxOutput("country_values_deaths")
                    ),
                    fluidRow(width=12,
                             column(width=4,
                                 box(title="Confirmed Cases",
                                     solidHeader=TRUE,
                                     status="primary",
                                     width="null",
                                     plotlyOutput("country_cases")
                                     )
                                 ), 
                             column(width=4,
                                 box(title="Confirmed New Cases",
                                     solidHeader=TRUE,
                                     status="primary",
                                     width="null",
                                     plotlyOutput("country_newcases")
                                 )
                             ),
                             column(width=4,
                                 box(title="Confirmed Deaths",
                                     solidHeader=TRUE,
                                     status="primary",
                                     width="null",
                                     plotlyOutput("country_deaths")
                                 )
                             )
                    ),
                    fluidRow(
                        column(width=10, offset=1,
                               sliderInput("countrysliderDate",
                                           label="Select Date:",
                                           min=min(world_data$date),
                                           max=max(world_data$date),
                                           value=max(world_data$date), 
                                           width="100%")
                        )
                    )
            ),
            tabItem(tabName="datatable", 
                    fluidRow(
                        column(width=10, offset=1,
                               sliderInput("dtsliderDate",
                                           label="Select Date:",
                                           min=min(country_data$date),
                                           max=max(country_data$date),
                                           value=max(country_data$date), 
                                           width="100%")
                        )
                    ), 
                    fluidRow(width=12,
                        box(title="Data Table", 
                            solidHeader=TRUE, 
                            status="primary", 
                            width="null", 
                            DTOutput("dt")
                        )
                    )
            ), 
            tabItem(tabName="about",
                    fluidRow(width=12,
                             box(title="About this project",
                                 width=12,
                                 "This dashboard shows the recent development of the COVID-19 pandemic on a global and country scale. Data is obtained in real time from ",
                                 tags$a(href="https://ourworldindata.org/coronavirus-source-data", "Our World in Data"), 
                                 "which is constantly updated by ", 
                                 tags$a(href="https://coronavirus.jhu.edu/map.html", "Johns Hopkins University"),
                                 ". The data is summarised and presented in a form of a map, key numbers, and plots. In addition, the data table used to generate the numbers can also be accessed.", 
                                 tags$p(),
                                 "This was created as part of a Coursera course project on ",
                                 tags$a(href="https://coursera.org/data-products", "Developing Data Products"), 
                                 " and thus any feedback on how to improve is always appreciated. ", 
                                 tags$p(), 
                                 "Last updated: 23 May 2021"
                             )
                    ), 
                    fluidRow(width=12,
                             box(title="Developer & Contact Information",
                                 width=12,
                                 "Dillon Chew @", 
                                 tags$a(href="https://www.linkedin.com/in/dillonchewwx/", "Linkedin |"), 
                                 tags$a(href="https://github.com/dillonchewwx", "Github"), )
                             )
                    )
            )
    )
))