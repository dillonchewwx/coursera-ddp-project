shinyServer(function(input, output) {
    # Leaflet Map
    output$overview_map<-renderLeaflet({overviewMap(input$sliderDate)})
    # Key Statistics
    output$values_confirmed <- renderValueBox({
            valueBox(
                confirmedCases(input$sliderDate),
            subtitle = "Confirmed Cases",
            color    = "light-blue",
            icon     = icon("virus"),
            width    = NULL
            )
    })
    output$values_deaths <- renderValueBox({
        valueBox(
            confirmedDeaths(input$sliderDate),
            subtitle = "Confirmed Deaths",
            color    = "light-blue",
            icon     = icon("skull-crossbones"),
            width    = NULL
        )
    })
    output$values_prop_vaccinated <- renderValueBox({
        valueBox(
            propVaccinated(input$sliderDate),
            subtitle = "Percentage Vaccinated",
            color    = "light-blue",
            icon     = icon("syringe"),
            width    = NULL
        )
    })
    
    selected_date<-reactive({
        temp<-world_data %>% filter(date<input$sliderDate)
        return(temp)
    })
    output$global_cases<-renderPlotly(global_plot_cases(selected_date()))
    output$global_deaths<-renderPlotly(global_plot_deaths(selected_date()))
    output$global_newcases<-renderPlotly(global_plot_newcases(selected_date()))
    
    selected_country<-reactive({
        temp<-country_data %>% 
            filter(location==as.character(input$country_select)) %>%
            filter(date<=input$countrysliderDate)
        return(temp)
    })
    
    data_table<-reactive({
        temp<-country_data %>%
            filter(date==input$dtsliderDate) %>%
            replace(is.na(.), 0)
        return(datatable(temp, 
                         caption=paste0("COVID-19 Statistics for: ", input$dtsliderDate)))
    })
    
    output$dt<-renderDT(data_table())
    
    output$country_cases<-renderPlotly(country_plot_cases(selected_country()))
    output$country_deaths<-renderPlotly(country_plot_deaths(selected_country()))
    output$country_newcases<-renderPlotly(country_plot_newcases(selected_country()))
    
    # Country Key Stats
    output$country_values_confirmed <- renderValueBox({
        valueBox(
            countryconfirmedCases(input$countrysliderDate, selected_country()),
            subtitle = "Confirmed Cases",
            color    = "light-blue",
            icon     = icon("virus"),
            width    = NULL
        )
    })
    output$country_values_deaths <- renderValueBox({
        valueBox(
            countryconfirmedDeaths(input$countrysliderDate, selected_country()),
            subtitle = "Confirmed Deaths",
            color    = "light-blue",
            icon     = icon("skull-crossbones"),
            width    = NULL
        )
    })
    output$country_values_newcases <- renderValueBox({
        valueBox(
            countrynewcases(input$countrysliderDate, selected_country()),
            subtitle = "Confirmed New cases",
            color    = "light-blue",
            icon     = icon("ambulance"),
            width    = NULL
        )
    })
})

