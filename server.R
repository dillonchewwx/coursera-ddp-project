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
    output$linegraph<-renderPlotly({linegraph(input$yaxis, input$countries)})
})
