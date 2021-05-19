# Load libraries

library(lubridate)
library(plotly)
library(rgdal)
library(shiny)
library(shinydashboard)
library(tidyverse)

# Load and clean data
data<-read_csv("https://covid.ourworldindata.org/data/owid-covid-data.csv") 

country_data<-data %>%
    select(iso_code, continent, location, date,
           total_cases, new_cases,
           total_deaths, new_deaths,
           total_vaccinations, people_fully_vaccinated,
           population) %>%
    filter(!str_detect(iso_code, "OWID")) %>%
    mutate(date=as_date(date))

world_data<-data %>%
    select(iso_code, continent, location, date,
           total_cases, new_cases,
           total_deaths, new_deaths,
           total_vaccinations, people_fully_vaccinated,
           population) %>%
    filter(str_detect(location, "World")) %>%
    mutate(date=as_date(date))
