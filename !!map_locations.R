####################################################
# Get Locations into a map
# nach folgender Anleitung:  https://www.youtube.com/watch?v=2k8O-Y_uiRU
# Need to be online to run the code!
###################################################

rm(list=ls())

version
#libraries needed
#####################
library(tidyverse)
library(googlesheets4)
library(lubridate)
library(openintro)
# answer no at the following prompt: there is no compiler here...
# install.packages("sp", dependencies=TRUE)
library(sp)
# install.packages("ggmap")
library(ggmap)
library(readxl)
library(ggrepel)
library (giscoR)
library(sf)
library(scales)
#######################
# get coordinates from openstreetmap.org mit der Exportfunktion

Gera_map = get_stamenmap(
    bbox = c(left = 13.3324, bottom = 54.0556, right = 13.5068, top =54.1130),
    maptype = "terrain",
    zoom = 13
)
ggmap(Gera_map)
#############

# Read in the file with locations:


dir()
excel_sheets("Locations.xlsx")
locations = read_excel("Locations.xlsx", sheet = "Sheet1")
str(locations)
locations$Site
list(locations)
# plot locations in map

n<-ggmap(Gera_map)+geom_point(data=locations, aes(x=long, y=lat))+ 
    ggsn::scalebar(x.min = 13.44, x.max = 13.50, 
                   y.min = 54.06, y.max = 54.06, 
                   dist = 1,dist_unit = "km", transform = TRUE, 
                   model = "WGS84", height = 0.5, 
                   st.dist = 0.5) 
north2(n, x=.95, y=.85, symbol=9)


n1<-ggmap(Gera_map)+geom_point(data=locations, aes(x=long, y=lat, size=bat_activity, fill=bat_activity), shape=21, alpha=0.8)+
    ggsn::scalebar(x.min = 13.44, x.max = 13.50, y.min = 54.06, y.max = 54.06, dist = 1,dist_unit = "km", transform = TRUE,  
    model = "WGS84", height = 0.5,  st.dist = 0.5) 
    north2(n1, x=.8, y=.8, symbol=9)

