# install.packages("tidyverse")
# install.packages("leaflet")

list.of.packages <- c("rmarkdown", "tidyverse", "leaflet")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

suppressPackageStartupMessages(library(tidyverse))
library(leaflet)

my_colors <-
  c(
    "#1f77b4",
    "#ff7f0e",
    "#2ca02c",
    "#d62728",
    "#9467bd",
    "#8c564b",
    "#e377c2",
    "#7f7f7f",
    "#17becf",
    sample(grDevices::colors()[!grepl("ivory|azure|white|gray|grey|black|pink|1",
                                      grDevices::colors())])
  )


read_mordva_file <- function(filename){
  
  read_csv(filename) %>% 
    slice(-1) %>%
    mutate(language = "Mordva") %>%
    mutate(coordinate = str_trim(coordinate)) %>%
    separate(coordinate, into = c("latitude", "longitude"), sep = ", ") %>%
    mutate(latitude = as.numeric(latitude)) %>%
    mutate(longitude = as.numeric(longitude))
  
}

read_Feok2005_file <- function(filename){
   read_tsv(filename) %>%
#   slice(10:20) %>%
   mutate(language = "Mordva") %>%
   mutate(coordinate = str_trim(coordinate)) %>%
   mutate(coordinate = str_remove_all(coordinate, "″")) %>%
   mutate(coordinate = str_replace_all(coordinate, "[°′]", ":")) %>%
   separate(coordinate, into = c("latitude", "longitude"), sep = ", ") %>%
   mutate(latitude = celestial::dms2deg(latitude)) %>%
   mutate(longitude = celestial::dms2deg(longitude))

}


make_mordva_map <- function(csv_file){
  
  mordva_dataframe <- read_mordva_file(csv_file)
  
  pal <- colorFactor({my_colors[1:length(unique(mordva_dataframe$dialect))]},
                     domain = mordva_dataframe$dialect)
  
  leaflet(data = mordva_dataframe, width = "100%") %>%
    addTiles() %>%
    addCircleMarkers(popup = ~id,
                     color = ~pal(dialect),
                     radius = 5,
                     stroke = FALSE, 
                     fillOpacity = 1,
                     lat = ~latitude,
                     lng = ~longitude) %>%
    addLegend("bottomright", pal = pal, values = ~dialect,
              title = "Dialect codes",
              #                     labFormat = labelFormat(prefix = "$"),
              opacity = 1
    )
  
}

make_Feok2005_map <- function(tsv_file){
  
  mordva_dataframe <- read_Feok2005_file(tsv_file)
  
  pal <- colorFactor({my_colors[1:length(unique(mordva_dataframe$dialect))]},
                     domain = mordva_dataframe$dialect)
  
  leaflet(data = mordva_dataframe, width = "100%") %>%
    addTiles() %>%
    addCircleMarkers(popup = ~Russian_name,
                     color = ~pal(dialect),
                     radius = 5,
                     stroke = FALSE, 
                     fillOpacity = 1,
                     lat = ~latitude,
                     lng = ~longitude) %>%
    addLegend("bottomright", pal = pal, values = ~dialect,
              title = "Dialect codes",
              #                     labFormat = labelFormat(prefix = "$"),
              opacity = 1
    )
  
}