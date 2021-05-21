# Load libraries

library(leaflet)
library(lubridate)
library(plotly)
library(rgdal)
library(scales)
library(shiny)
library(shinydashboard)
library(tidyverse)

# Load and clean data
data<-read_csv("https://covid.ourworldindata.org/data/owid-covid-data.csv") 

country_data<-data %>%
    select(iso_code, continent, location, date,
           total_cases, new_cases,
           total_deaths, new_deaths,
           people_fully_vaccinated,
           population) %>%
    filter(!str_detect(iso_code, "OWID")) %>%
    mutate(date=as_date(date))

world_data<-data %>%
    select(iso_code, continent, location, date,
           total_cases, new_cases,
           total_deaths, new_deaths,
           people_fully_vaccinated,
           population) %>%
    filter(str_detect(location, "World")) %>%
    mutate(date=as_date(date))

# World Statistics
confirmedCases<-function(chosenDate){
    return(comma_format()(world_data$total_cases[world_data$date==chosenDate]))
}
confirmedDeaths<-function(chosenDate){
    return(comma_format()(world_data$total_deaths[world_data$date==chosenDate]))
}
propVaccinated<-function(chosenDate){
    return(paste0(round(world_data$people_fully_vaccinated[world_data$date==chosenDate]/world_data$population[world_data$date==chosenDate]*100,3),"%"))
}

# Leaflet Plot
if(!file.exists("./Data/TM_WORLD_BORDERS_SIMPL-0.3.shp")){
    dir.create("./Data")
    download.file("http://thematicmapping.org/downloads/TM_WORLD_BORDERS_SIMPL-0.3.zip", 
                  destfile="./Data/world_shape_file.zip")
    unzip(zipfile="./Data/world_shape_file.zip", exdir="./Data")
}

world<-readOGR( 
    dsn=paste0(getwd(), "/Data"), 
    layer="TM_WORLD_BORDERS_SIMPL-0.3",
    verbose=FALSE
)

overviewMap<-function(chosenDate){
    country_data_today<-country_data %>%
        filter(date==chosenDate)
    world@data<-world@data %>% 
        select(ISO3) %>% 
        rename(iso_code=ISO3) %>%
        left_join(country_data_today, by="iso_code")
    
    mybins<-c(0, 5000, 50000, 500000, 1000000, max(world_data$total_cases))
    mypal<-colorBin( palette="YlOrRd", domain=world@data$total_cases, na.color="white", bins=mybins)
    
    mytext<-paste(
        "Country: ", world@data$location,"<br/>", 
        "Total Cases: ", world@data$total_cases, "<br/>", 
        "Total Deaths: ", world@data$total_deaths, "<br/>",
        "Population: ", round(world@data$population, 2), 
        sep="") %>%
        lapply(htmltools::HTML)
    
    leaflet(world) %>% 
        setMaxBounds(-180, -90, 180, 90) %>%
        setView(0, 20, zoom = 1) %>%
        addTiles() %>%
        addPolygons(fillColor=~mypal(total_cases), 
                    stroke=TRUE, 
                    fillOpacity=0.9,
                    color="white", 
                    smoothFactor=0.5,
                    weight=0.3, 
                    label=mytext, 
                    labelOptions=labelOptions( 
                        style = list("font-weight" = "normal", padding = "3px 8px"), 
                        textsize = "13px", 
                        direction = "auto"
                    )
        ) %>% 
        addLegend(pal=mypal, 
                  values=~total_cases, 
                  opacity=0.7, 
                  title=paste0("Number of Cases as of ", chosenDate), 
                  position="bottomleft")
}

# Plotly Line Graph
lineGraph<-function(yaxis, countries){
    plot_ly(country_data %>%
                select(location, date, yaxis) %>%
                filter(location %in% countries) %>%
                replace(is.na(.),0), 
            x=~date,
            y=~yaxis,
            color=~location, 
            type="scatter", 
            mode="lines")
}

countries=c("Spain", "Brazil")
yaxis="total_cases"
total<-country_data %>%
    select(location, date, total_cases) %>%
    filter(location %in% countries) %>%
    replace(is.na(.),0)
plot_ly(total, 
        x=~date,
        y=%(yaxis),
        color=~location, 
        type="scatter", 
        mode="lines")

# fix plotly chart
