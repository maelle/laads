library("laads")
library("rgdal")
library("gdalUtils")
download.file(laads_file_urls(file_ids = "299343600")$file_url,
              destfile = "inst/test.hdf")

gdalinfo("inst/test.hdf")
# [1] "ERROR 4: `inst/test.hdf' not recognised as a supported file format."
# [2] ""
# [3] "gdalinfo failed - unable to open 'inst/test.hdf'."
# attr(,"status")
# [1] 1
# Warning message:
#   running command '"C:\Program Files (x86)\FWTools2.4.7\bin\gdalinfo.exe" "inst/test.hdf"' had status 1
gdal_chooseInstallation(hasDrivers=c("HDF4","HDF5"))

# see https://gis.stackexchange.com/questions/199647/hdf-files-in-gdal-throwing-an-error-in-r-gdalinfo
# found via https://gis.stackexchange.com/questions/213923/open-hdf4-files-using-gdal-on-windows

gdal_setInstallation(getOption("gdalUtils_gdalPath")[[
  gdal_chooseInstallation(hasDrivers=c("HDF4","HDF5"))]]$path)

gdalinfo("inst/test.hdf")
# same error
