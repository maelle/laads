laads
=====

[![Build Status](https://travis-ci.org/masalmon/laads.svg?branch=master)](https://travis-ci.org/masalmon/laads) [![codecov.io](https://codecov.io/github/masalmon/laads/coverage.svg?branch=master)](https://codecov.io/github/masalmon/laads?branch=master)

laads is under development (and not really usable yet) and will provide an interface to the [NASA API of MODIS Level 1 and Atmosphere data products](https://ladsweb.nascom.nasa.gov/data/api.html).

``` r
library("laads")
library("dplyr")
```

    ## Warning: package 'dplyr' was built under R version 3.2.5

The functions of the package mimick the API methods. The documentation is often a copy of the parameters or API methods documentation. Further below a few workflow examples are given in order to help navigating the different functions.

A bit of information about the API
==================================

What data is accessible via the LAADS API
-----------------------------------------

From the [FAQ](http://modaps.nascom.nasa.gov/services/faq/), "LAADS is being populated with large volumes of MODIS data from the NASA EOS Terra and Aqua spacecrafts as they are produced. These data include Collection 5 and some earlier data from Collection 3 & 4 such as Aqua/Terra Atmosphere Level 2 & 3 products. New Collection 6 MODIS Aqua Level 1 and Level 2 Atmosphere products are available while all Terra and rest of Aqua products will be included soon. LAADS also provide access to MODIS Airborne Simulator (MAS) data (via FTP only; not searchable), NPP VIIRS Level 1, Level 2, and Level 3 products, and ENVISAT MERIS Level 1B Full Resolution (FR) and Reduced Resolution (RR) data sets from European Space Agency (ESA)."

If this does not include the data you are looking for, have a look at [the MODISTools package](https://github.com/seantuck12/MODISTools) that supports retrieving and using MODIS data subsets using ORNL DAAC web service (SOAP) for subsetting from Oak Ridge National Laboratory (ORNL).

How is the data organized
-------------------------

The data is organized by satellite instrument / product / collection / file: each instrument provides different products whose files are organized in different collections. The goal of the package is to help getting the files.

A type of product, for instance Aerosol Optical Density with a given resolution, can be produced by several satellites.

Some files are available online, other have to be ordered. At some point the ordering function will be available in this package.

How to cite the data when using it
----------------------------------

For knowing how to cite the data when using it, please see [this document](http://modaps.nascom.nasa.gov/services/faq/LAADS_Data-Use_Citation_Policies.pdf).

Workflow example
================

Getting files for aerosol optical density near Hyderabad
--------------------------------------------------------

Context: say we want to get Aerosol Optical Density data for a rectangle 17 N to 18 N latitude, 78 E to 79 E longitude, with 3km resolution, for one day of January in 2015.

The first step will be to look for a product that corresponds to this.

``` r
laads_search_datasets(keywords = "aerosol") %>%
  knitr::kable()
```

    ## [1] 31  8

| updated             | author.name | author.email               | title                                                                         | start      | end        | product          |
|:--------------------|:------------|:---------------------------|:------------------------------------------------------------------------------|:-----------|:-----------|:-----------------|
| 2016-07-31 15:37:45 | MODAPS      | <modapsuso@sigmaspace.com> | Terra Global Composite Level 2 browse AEROSOL\_OPTICAL\_DEPTH                 | 2002-08-28 | 2010-04-14 | MOBAOD\_C00      |
| 2016-07-31 15:37:45 | MODAPS      | <modapsuso@sigmaspace.com> | Terra Global Composite Level 2 browse AEROSOL\_OPTICAL\_DEPTH\_RATIO\_SMALL   | 2000-02-24 | 2010-04-14 | MOBARS\_C00      |
| 2016-07-31 15:37:45 | MODAPS      | <modapsuso@sigmaspace.com> | MODIS/Terra Aerosol 5-Min L2 Swath 3km                                        | NA         | NA         | MOD04\_3K        |
| 2016-07-31 15:37:45 | MODAPS      | <modapsuso@sigmaspace.com> | MODIS/Terra Aerosol 5-Min L2 Swath 10km                                       | 2000-02-24 | 2009-11-28 | MOD04\_L2        |
| 2016-07-31 15:37:45 | MODAPS      | <modapsuso@sigmaspace.com> | MODIS/Terra Aerosol Cloud Water Vapor Ozone Daily L3 Global 1Deg CMG          | 2000-02-24 | 2009-11-28 | MOD08\_D3        |
| 2016-07-31 15:37:45 | MODAPS      | <modapsuso@sigmaspace.com> | MODIS/Terra Aerosol Cloud Water Vapor Ozone 8-Day L3 Global 1Deg CMG          | 2000-02-18 | 2010-03-30 | MOD08\_E3        |
| 2016-07-31 15:37:45 | MODAPS      | <modapsuso@sigmaspace.com> | MODIS/Terra Aerosol Cloud Water Vapor Ozone Monthly L3 Global 1Deg CMG        | 2000-02-01 | 2002-09-01 | MOD08\_M3        |
| 2016-07-31 15:37:45 | MODAPS      | <modapsuso@sigmaspace.com> | MODIS/Terra Aerosol, Cloud and Water Vapor Subset 5-Min L2 Swath 5km and 10km | 2000-02-24 | 2009-11-28 | MODATML2         |
| 2016-07-31 15:37:45 | MODAPS      | <modapsuso@sigmaspace.com> | Aqua Global Composite Level 2 browse AEROSOL\_OPTICAL\_DEPTH                  | 2002-07-03 | 2008-12-31 | MYBAOD\_C00      |
| 2016-07-31 15:37:45 | MODAPS      | <modapsuso@sigmaspace.com> | Aqua Global Composite Level 2 browse AEROSOL\_OPTICAL\_DEPTH\_RATIO\_SMALL    | 2002-07-03 | 2008-12-31 | MYBARS\_C00      |
| 2016-07-31 15:37:45 | MODAPS      | <modapsuso@sigmaspace.com> | Deep Blue Aerosol Optical Depth 550 Land center image 10Km resolution         | NA         | NA         | MYBGAODDB\_C10K  |
| 2016-07-31 15:37:45 | MODAPS      | <modapsuso@sigmaspace.com> | Deep Blue Aerosol Optical Depth 550 Land east image 10Km resolution           | NA         | NA         | MYBGAODDB\_E10K  |
| 2016-07-31 15:37:45 | MODAPS      | <modapsuso@sigmaspace.com> | Deep Blue Aerosol Optical Depth 550 Land west image 10Km resolution           | NA         | NA         | MYBGAODDB\_W10K  |
| 2016-07-31 15:37:45 | MODAPS      | <modapsuso@sigmaspace.com> | MODIS/Aqua Aerosol 5-Min L2 Swath 3km                                         | NA         | NA         | MYD04\_3K        |
| 2016-07-31 15:37:45 | MODAPS      | <modapsuso@sigmaspace.com> | MODIS/Aqua Aerosol 5-Min L2 Swath 10km                                        | 2002-07-03 | 2012-05-24 | MYD04\_L2        |
| 2016-07-31 15:37:45 | MODAPS      | <modapsuso@sigmaspace.com> | MODIS/Aqua Aerosol Cloud Water Vapor Ozone Daily L3 Global 1Deg CMG           | 2002-07-03 | 2002-10-08 | MYD08\_D3        |
| 2016-07-31 15:37:45 | MODAPS      | <modapsuso@sigmaspace.com> | MODIS/Aqua Aerosol Cloud Water Vapor Ozone 8-Day L3 Global 1Deg CMG           | 2002-08-29 | 2002-09-30 | MYD08\_E3        |
| 2016-07-31 15:37:45 | MODAPS      | <modapsuso@sigmaspace.com> | MODIS/Aqua Aerosol Cloud Water Vapor Ozone Monthly L3 Global 1Deg CMG         | 2002-09-01 | 2002-09-01 | MYD08\_M3        |
| 2016-07-31 15:37:45 | MODAPS      | <modapsuso@sigmaspace.com> | MODIS/Aqua Aerosol, Cloud and Water Vapor Subset 5-Min L2 Swath 5km and 10km  | 2002-07-03 | 2008-09-14 | MYDATML2         |
| 2016-07-31 15:37:45 | MODAPS      | <modapsuso@sigmaspace.com> | HDF5 VIIRS/NPP Aerosol (aggregated) EDR Ellipsoid Geolocation Data            | NA         | NA         | NP5\_GAERO\_L1   |
| 2016-07-31 15:37:45 | MODAPS      | <modapsuso@sigmaspace.com> | HDF5 VIIRS Aerosol Model Information RIP                                      | NA         | NA         | NP5\_VAMIIP\_L2  |
| 2016-07-31 15:37:45 | MODAPS      | <modapsuso@sigmaspace.com> | HDF5 VIIRS Aerosol Optical Thickness RIP                                      | NA         | NA         | NP5\_VAOTIP\_L2  |
| 2016-07-31 15:37:45 | MODAPS      | <modapsuso@sigmaspace.com> | HDF5 VIIRS Aerosol Optical Thickness (AOT) EDR                                | NA         | NA         | NP5\_VAOT\_L2    |
| 2016-07-31 15:37:45 | MODAPS      | <modapsuso@sigmaspace.com> | VIIRS/NPP Aerosol Model Information 5-Min L2 Swath IP 750m                    | NA         | NA         | NPP\_VAMIIP\_L2  |
| 2016-07-31 15:37:45 | MODAPS      | <modapsuso@sigmaspace.com> | VIIRS/NPP Aerosol Optical Thickness Heap 5-Min L2 Swath IP 750m               | NA         | NA         | NPP\_VAOTHIP\_L2 |
| 2016-07-31 15:37:45 | MODAPS      | <modapsuso@sigmaspace.com> | VIIRS/NPP Aerosol Optical Thickness 5-Min L2 Swath IP 750m                    | NA         | NA         | NPP\_VAOTIP\_L2  |
| 2016-07-31 15:37:45 | MODAPS      | <modapsuso@sigmaspace.com> | VIIRS/NPP Aerosol Optical Thickness 5-Min L2 Swath EDR 6km                    | NA         | NA         | NPP\_VAOT\_L2    |
| 2016-07-31 15:37:45 | MODAPS      | <modapsuso@sigmaspace.com> | VIIRS/NPP Aerosol Optical Thickness 5-Min L2 Swath EDR Geolocation 750m       | NA         | NA         | NPP\_VGAERO\_L2  |
| 2016-07-31 15:37:45 | MODAPS      | <modapsuso@sigmaspace.com> | VIIRS/NPP Subset of Aerosol Model Information 5-Min L2 Swath IP 750m          | NA         | NA         | NPS\_VAMIIP\_L2  |
| 2016-07-31 15:37:45 | MODAPS      | <modapsuso@sigmaspace.com> | VIIRS/NPP Subset of Aerosol Optical Thickness Heap 5-Min L2 Swath IP 750m     | NA         | NA         | NPS\_VAOTHIP\_L2 |
| 2016-07-31 15:37:45 | MODAPS      | <modapsuso@sigmaspace.com> | VIIRS/NPP Subset of Aerosol Optical Thickness 5-Min L2 Swath IP 750m          | NA         | NA         | NPS\_VAOTIP\_L2  |

Two satellites provides "Aerosol 5-Min L2 Swath 3km". The corresponding products are "MYD04\_3K" (from the Aqua satellite) and "MOD04\_3K" (from the Terra satellite).

We will now search the corresponding files.

``` r
files <- laads_search_files(product = c("MYD04_3K", "MOD04_3K"),
                   start_time = "2015-01-01",
                   end_time = "2015-01-02",
                   coords_or_tiles = "coords",
                   south = 17, north = 18,
                   east = 79, west = 78) 
knitr::kable(files)
```

file\_id
--------

1521335279 1521335916 1521376559 1546415765 1548238829 1548244690

As you see, the search function only gives files IDs, nothing else. For getting more information about these files before trying to download them, for instance for knowing if they are available online, we will use another function.

``` r
properties <- laads_file_properties(files$file_id) 
head(properties) %>%
  knitr::kable()
```

| checksum   | file\_id   | file\_name                                    | file\_size\_bytes | file\_type | ingest\_time               | online | start\_time           |
|:-----------|:-----------|:----------------------------------------------|:------------------|:-----------|:---------------------------|:-------|:----------------------|
| 1367971449 | 1521335279 | MYD04\_3K.A2015001.0720.006.2015005143400.hdf | 4301152           | MYD04\_3K  | 2015-01-05 14:42:11.202523 | TRUE   | 2015-01-01 07:20:00.0 |
| 2858661553 | 1521335916 | MYD04\_3K.A2015001.0855.006.2015005144104.hdf | 19874389          | MYD04\_3K  | 2015-01-05 14:44:07.204686 | TRUE   | 2015-01-01 08:55:00.0 |
| 1384416930 | 1521376559 | MYD04\_3K.A2015002.0800.006.2015005161654.hdf | 11040458          | MYD04\_3K  | 2015-01-05 16:21:29.894935 | TRUE   | 2015-01-02 08:00:00.0 |
| 2096251102 | 1546415765 | MOD04\_3K.A2015001.0550.006.2015033060522.hdf | 18108481          | MOD04\_3K  | 2015-02-02 06:11:11.874779 | TRUE   | 2015-01-01 05:50:00.0 |
| 1867147408 | 1548238829 | MOD04\_3K.A2015002.0455.006.2015035114041.hdf | 14572836          | MOD04\_3K  | 2015-02-04 11:44:41.189185 | TRUE   | 2015-01-02 04:55:00.0 |
| 2942480380 | 1548244690 | MOD04\_3K.A2015002.0630.006.2015035114313.hdf | 12103325          | MOD04\_3K  | 2015-02-04 11:56:40.961707 | TRUE   | 2015-01-02 06:30:00.0 |

``` r
all(properties$online == TRUE)
```

    ## [1] TRUE

Now we can get their URL using `laads_file_urls`.

``` r
urls <- laads_file_urls(files$file_id) 
head(urls) %>%
  knitr::kable()
```

| file\_id   | file\_url                                                                                                |
|:-----------|:---------------------------------------------------------------------------------------------------------|
| 1521335279 | <ftp://ladsweb.nascom.nasa.gov/allData/6/MYD04_3K/2015/001/MYD04_3K.A2015001.0720.006.2015005143400.hdf> |
| 1521335916 | <ftp://ladsweb.nascom.nasa.gov/allData/6/MYD04_3K/2015/001/MYD04_3K.A2015001.0855.006.2015005144104.hdf> |
| 1521376559 | <ftp://ladsweb.nascom.nasa.gov/allData/6/MYD04_3K/2015/002/MYD04_3K.A2015002.0800.006.2015005161654.hdf> |
| 1546415765 | <ftp://ladsweb.nascom.nasa.gov/allData/6/MOD04_3K/2015/001/MOD04_3K.A2015001.0550.006.2015033060522.hdf> |
| 1548238829 | <ftp://ladsweb.nascom.nasa.gov/allData/6/MOD04_3K/2015/002/MOD04_3K.A2015002.0455.006.2015035114041.hdf> |
| 1548244690 | <ftp://ladsweb.nascom.nasa.gov/allData/6/MOD04_3K/2015/002/MOD04_3K.A2015002.0630.006.2015035114313.hdf> |

Then one can use them for downloading files via `download.file` and further process them (story to be continued).
