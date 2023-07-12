# Calculate a Kriged occurrence distribution estimate

MoveApps

Github repository: https://github.com/ctmm-initiative/ctmmMoveApp_occurrence

## Description
This function calculates an occurrence distribution from telemetry data and a continuous-time movement model.

## Documentation
After fitting a continuous-time movement model, this app allows to reconstruct the path where the animal possibly went. 

### Input data

### Output data

### Artefacts

`occurrence.gpkg`: A geopackage with the calculated occurrence distributions.

`occurrence_uds.zip`: A zipped archive of individual occurrence distributions (saved as tifs). 

### Settings

`Isopleth level`: Coverage level of the utilization distribution area. 

`Opacity`: The opacity of the estimated home range on the map. 

`Remove all animals from map`: This button will remove all home-ranges from the map. They can be added individually again. 

`Store settings`: click to store the current settings of the app for future workflow runs

### Most common errors
Calculating of occurrence distribution can potentially take a long time if a lot of data is available for an animal. 

### Null or error handling
Please file an issue [here](https://github.com/ctmm-initiative/ctmmMoveApp_occurrence/issues) if you repeatedly encounter a specific error.