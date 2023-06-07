library(shiny)
library(ctmm)
library(sf)
library(leaflet)
library(purrr)

# to display messages to the user in the log file of the App in MoveApps
# one can use the function from the src/common/logger.R file:
# logger.fatal() -> logger.trace()

shinyModuleUserInterface <- function(id, label) {
  ns <- NS(id) ## all IDs of UI functions need to be wrapped in ns()
  tagList(
    titlePanel("Occurence"),
    leafletOutput(ns("map"))
  )
}

shinyModule <- function(input, output, session, data){ ## The parameter "data" is reserved for the data object passed on from the previous app
  ns <- session$ns ## all IDs of UI functions need to be wrapped in ns()
  
  
  occu <- occurrence(data[[1]], data[[2]])
  
  occu_sf <- map_dfr(occu, ~ sf::st_as_sf(ctmm::SpatialPolygonsDataFrame.UD(.x)))
  
  sf::st_write(occu_sf, appArtifactPath(glue::glue("homerange.gpkg")))
  
  output$map <- renderLeaflet({
    occu_sf |> 
      sf::st_transform(4326) |> 
      leaflet()  |> 
      addTiles() |> 
      addPolygons()
  })
  
  return(reactive({
    data
    })) ## if data are not modified, the unmodified input data must be returned
}
