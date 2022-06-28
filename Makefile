.PHONY: download_data

#################################################################################
# Globals

DATA_DIR = data
DATA_RAW_DIR := $(DATA_DIR)/raw

$(DATA_DIR):
	mkdir $@
    
$(DATA_RAW_DIR): | $(DATA_DIR)
	mkdir $@

#################################################################################
# Download the data

## variables
### URIS
#### Land cover
LC_URI := https://dap.ceda.ac.uk/neodc/esacci/land_cover/data/land_cover_maps/v2.0.7/ESACCI-LC-L4-LCCS-Map-300m-P1Y-2012-v2.0.7.tif
#### Climate
PPT_URI := https://climate.northwestknowledge.net/TERRACLIMATE-DATA/TerraClimate_ppt_2012.nc
TMAX_URI := https://climate.northwestknowledge.net/TERRACLIMATE-DATA/TerraClimate_tmax_2012.nc
#### Other
WORLDPOP_URI := https://data.worldpop.org/GIS/Population/Global_2000_2020/2012/CIV/civ_ppp_2012_UNadj.tif
EARTHNIGHT_URI := https://eoimages.gsfc.nasa.gov/images/imagerecords/144000/144896/BlackMarble_2012_B1_geo_gray.tif
EDGES_URI = https://zenodo.org/record/5564798/files/edges_gis_osm_roads_free_1_filtered.gpkg?download=1
GADM_URI = https://biogeo.ucdavis.edu/data/gadm3.6/gpkg/gadm36_CIV_gpkg.zip
### URI lists
TIF_URIS := $(LC_URI) $(WORLDPOP_URI) $(EARTHNIGHT_URI)
CLIM_URIS := $(PPT_URI) $(TMAX_URI)

### filepaths
DATA_RAW_FILEPATH = $(DATA_RAW_DIR)/$(notdir $(DATA_RAW_URI))
EDGES_GPKG := $(DATA_RAW_DIR)/$(notdir $(subst ?download=1,$(),$(EDGES_URI)))
GADM_GPKG := $(DATA_RAW_DIR)/$(notdir $(subst _gpkg.zip,.gpkg,$(GADM_URI)))
LC_TIF := $(DATA_RAW_DIR)/$(notdir $(LC_URI))
WORLDPOP_TIF := $(DATA_RAW_DIR)/$(notdir $(WORLDPOP_URI))
EARTHNIGHT_TIF := $(DATA_RAW_DIR)/$(notdir $(EARTHNIGHT_URI))
DATA_RAW_TIF_FILEPATHS := $(LC_TIF) $(WORLDPOP_TIF) $(EARTHNIGHT_TIF)
DATA_RAW_NC_FILEPATHS := $(foreach DATA_RAW_URI, $(CLIM_URIS), \
	$(DATA_RAW_FILEPATH))
DATA_RAW_GPKG_FILEPATHS := $(EDGES_GPKG) $(GADM_GPKG)
DATA_RAW_FILEPATHS := $(DATA_RAW_TIF_FILEPATHS) $(DATA_RAW_NC_FILEPATHS) \
	$(DATA_RAW_GPKG_FILEPATHS)

## rules
### TIFs
define DOWNLOAD_DATA_RAW
$(DATA_RAW_FILEPATH): | $(DATA_RAW_DIR)
	wget "$(DATA_RAW_URI)" -O $$@
endef
$(foreach DATA_RAW_URI, $(TIF_URIS) $(CLIM_URIS), \
	$(eval $(DOWNLOAD_DATA_RAW)))
#### gpkgs
$(EDGES_GPKG): | $(DATA_RAW_DIR)
	wget "$(EDGES_URI)" -O $@
$(DATA_RAW_DIR)/gadm36_%.zip: | $(DATA_RAW_DIR)
	wget "$(GADM_URI)" -O $@
$(DATA_RAW_DIR)/gadm36_%.gpkg: $(DATA_RAW_DIR)/gadm36_%_gpkg.zip
	unzip $< '$(notdir $@)' -d $(DATA_RAW_DIR)
	touch $@
#### phony to rule them all
download_data: $(DATA_RAW_FILEPATHS)
