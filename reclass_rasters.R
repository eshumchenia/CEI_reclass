library(raster)
library(rgdal)

grids <- list.files("./data/mdat/fish/", pattern = "*.tif$")

#function to reclassify rasters and write a new reclassified tif file for each
batch_reclass <- function(grids){
  for (i in 1:length(grids)) {
    #read in raster and reclassify
    r <- raster(paste0("./data/mdat/fish/", grids[i]))
    q <- quantile(r, c(0, 0.9))
    quants <- findInterval(getValues(r), q)
    reclassr <- setValues(r, quants)
    #write each reclass to a new file 
    writeRaster(reclassr, filename = paste0("./data/mdat/fish/reclass/", "rc_", grids[i]), format="GTiff", overwrite=TRUE)
  }
}
#run the function
batch_reclass(grids)