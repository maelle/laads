library("laads")
library("rgdal")
library("gdalUtils")
download.file(laads_file_urls(file_ids = "299343600")$file_url,
              destfile = "inst/test.hdf", mode='wb')

gdalinfo("inst/test.hdf")
