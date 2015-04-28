
library(plotKML)
library(leaflet)

setwd("~/temp/keenan_bike")
k_tracks <- readGPX("Today, we explore.gpx")

library(listviewer)
jsonedit(k_tracks)
y <- k_tracks$tracks[[1]][[1]]
write.csv(subset(y, select = c(lat, lon)), 
          file = "keenan_gps.csv", quote = F, row.names = F)

library(rgdal)
dataMap.SP  <- SpatialPointsDataFrame(subset(y, select = c(lat, lon)), y)
str(dataMap.SP) # Now is class SpatialPointsDataFrame

#Write as geojson
writeOGR(dataMap.SP, 'keenan_bike.geojson','dataMap', driver='GeoJSON')

# leaflet plot
p1 <- leaflet() %>% 
  addTiles() %>% 
  setView(lng = -112.0307, lat = 46.57573, zoom = 13) %>% 
  addPolylines(lng = y$lon, lat = y$lat)
p1

jsonedit(p1)

# ggplot
library(ggplot2)
library(ggmap)
qplot(lon, lat, data = y, geom = "path")
gglocator(40)
