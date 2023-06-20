library(shiny)
library(ctmm)
library(sf)
library(glue)
library(dplyr)
library(purrr)
library(mapview)
library(leaflet)

shinyModuleUserInterface <- function(id, label) {
  ns <- NS(id) ## all IDs of UI functions need to be wrapped in ns()
  tagList(
    leafletOutput(ns("map"))
  )
}

shinyModule <- function(input, output, session, data){ ## The parameter "data" is reserved for the data object passed on from the previous app
  ns <- session$ns ## all IDs of UI functions need to be wrapped in ns()
  
  occu <- occurrence(data[[1]], data[[2]])
  occu_sf <- map_dfr(occu, ~ sf::st_as_sf(ctmm::SpatialPolygonsDataFrame.UD(.x)))
  sf::st_write(occu_sf, appArtifactPath(glue::glue("homerange.gpkg")))
  
  output$map <- renderLeaflet({
    
    m <- mapview(occu_sf)
    # export as geopackage
    akde_sf |> 
      sf::st_write(appArtifactPath(glue::glue("homerange.gpkg")))
    m@map
  })
  
  return(reactive({ 
    list(data[[1]], occu, data[[2]])
  })) ## if data are not modified, the unmodified input data must be returned
}
