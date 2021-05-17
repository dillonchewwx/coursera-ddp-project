library(lubridate)
library(plotly)
library(shiny)
library(tidyverse)

shinyServer(function(input, output) {
    # Load data from Our World In Data Website
    # To keep things simple, we will filter the data to only keep several variables. 
    data<-read_csv("https://covid.ourworldindata.org/data/owid-covid-data.csv") %>%
        select(1:6, 
               total_deaths, new_deaths, 
               total_cases_per_million, new_cases_per_million, 
               total_deaths_per_million, new_deaths_per_million,
               total_vaccinations, people_fully_vaccinated, 
               population) %>%
        filter(!str_detect(iso_code, "OWID"))
    
})

# 
# data_today<-data %>%
#     filter(date==today()-2) %>%
#     filter(!str_detect(iso_code, "OWID"))
# 
# plot_ly(type="choropleth",
#         locations=data_today$iso_code,
#         z=data_today$total_cases,
#         text=data_today$location,
#         color=data_today$total_cases, 
#         colors="Reds") %>%
#     colorbar(title="Number of Cases", 
#              y=0.75) %>%
#     layout(title=list(text=paste0("Number of COVID-19 cases as of ", today()-2), y=0.9))