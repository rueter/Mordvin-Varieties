# install.packages("tidyverse")
# install.packages("leaflet")

list.of.packages <- c("rmarkdown", "tidyverse", "leaflet")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

suppressPackageStartupMessages(library(tidyverse))
library(leaflet)

dg2dec <- function(varb, Dg="°", Min="′", Sec="″", SW.Hemisphere="S|W") {
  # Dg=decimal, Min=minutes and Sec=seconds; 
  # NOTE 1 - if the format is "degrees decimal minutes - DdM" (e.g. 40° 26.767′ N) and not 
  # "degrees minutes seconds - DMS" (e.g. 40° 26′ 46″ N), then call the function only with 
  # Dg and Min arguments, like dg2dec(varb, Dg="°", Min="′N"). 
  # Same applies when there is no seconds symbol (e.g. 45°12'7.38).
  # Note that one should not use blank spaces in Dg, Min or Sec arguments (will return NA).
  # For more details on formats see: 
  # https://en.wikipedia.org/wiki/Geographic_coordinate_conversion#Coordinate_format_conversion
  
  # Use paste0("[", Dg, Min, Sec, "]") to build regex [] pattern
  # therefore, strsplit() will split string "varb" by what symbols you give to Dg, Min, Sec
  DMS <- sapply(strsplit(varb, paste0('[', Dg, Min, Sec, ']')), as.numeric)
  
  # DMS is a matrix; first row contains degrees; second - minutes; third - seconds.
  # If the format is "degrees decimal minutes" (e.g. 40° 26.767′ N) and not 
  # "degrees minutes seconds" (e.g. 40° 26′ 46″ N), then the matrix has only two valid rows: 
  # first row contains degrees; the second - minutes;
  # therefore, compute conversion for seconds only if there are more than 2 rows in DMS 
  # and Sec is different from NA (if there are seconds in the DMS format)
  decdg <- abs(DMS[1, ]) + DMS[2, ]/60 + ifelse(dim(DMS)[1] > 2  & !is.na(Sec), DMS[3, ]/3600, 0)
  
  # all cordinates from Southern or Western Hemispheres become negative in their decimal format
  SW <- grepl(pattern = SW.Hemisphere, x = varb, ignore.case = TRUE)
  return(ifelse(SW, -1, 1) * decdg)
}

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
   slice(1:301) %>%
   mutate(language = "Mordva") %>%
   mutate(coordinate = str_trim(coordinate)) %>%
   separate(coordinate, into = c("latitude", "longitude"), sep = ", ") %>%
   mutate(latitude = str_squish(latitude)) %>%
   mutate(longitude = str_squish(longitude)) %>%
   mutate(longitude = str_remove(longitude, "и ")) %>%
   mutate(latitude = dg2dec(latitude)) %>%
   mutate(longitude = dg2dec(longitude))

}

read_Bashk2014_file <- function(filename){
   read_tsv(filename) %>%
   mutate(language = "Mordva") %>%
   mutate(coordinate = str_trim(coordinate)) %>%
   separate(coordinate, into = c("latitude", "longitude"), sep = ", ") %>%
   mutate(latitude = str_squish(latitude)) %>%
   mutate(longitude = str_squish(longitude)) %>%
   mutate(longitude = str_remove(longitude, "и ")) %>%
   mutate(latitude = dg2dec(latitude)) %>%
   mutate(longitude = dg2dec(longitude))

}

read_census2002_file <- function(filename){
   read_tsv(filename) %>%
   #slice(1:410) %>%
   mutate(language = "Mordva") %>%
   mutate(dialect = lang) %>%
   mutate(coordinate = str_trim(coordinate)) %>%
   separate(coordinate, into = c("latitude", "longitude"), sep = ", ") %>%
   mutate(latitude = str_squish(latitude)) %>%
   mutate(longitude = str_squish(longitude)) %>%
   mutate(longitude = str_remove(longitude, "и ")) %>%
   mutate(latitude = dg2dec(latitude)) %>%
   mutate(longitude = dg2dec(longitude))

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
              opacity = 1
    )
  
}

make_Bashk2014_map <- function(tsv_file){
  
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
              opacity = 1
    )
  
}

make_census2002_map <- function(tsv_file){
  
  mordva_dataframe <- read_census2002_file(tsv_file)
  
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
              opacity = 1
    )
  
}
