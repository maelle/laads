laads
=====

[![Build Status](https://travis-ci.org/masalmon/laads.svg?branch=master)](https://travis-ci.org/masalmon/laads) [![codecov.io](https://codecov.io/github/masalmon/laads/coverage.svg?branch=master)](https://codecov.io/github/masalmon/laads?branch=master)

laads is under development and will provide an interface to the [NASA API of MODIS Level 1 and Atmosphere data products](https://ladsweb.nascom.nasa.gov/data/api.html).

``` r
library("laads")
```

Its functions mimick the API methods

Product information
===================

listSatelliteInstruments
------------------------

``` r
laads_satellite_instruments()
```

    ## # A tibble: 5 x 2
    ##    Name                 Description
    ##   <chr>                       <chr>
    ## 1  AM1M                 Terra MODIS
    ## 2   ANC              Ancillary Data
    ## 3  PM1M                  Aqua MODIS
    ## 4  AMPM Combined Aqua & Terra MODIS
    ## 5   NPP             Suomi NPP VIIRS

listProducts
------------

``` r
laads_products()
```

    ## # A tibble: 190 x 3
    ##       Name
    ##      <chr>
    ## 1  MCD15A2
    ## 2  MCD43A1
    ## 3  MCD43A2
    ## 4  MCD43A3
    ## 5  MCD43A4
    ## 6  MCD43B1
    ## 7  MCD43B2
    ## 8  MCD43B3
    ## 9  MCD43B4
    ## 10 MCD43C1
    ## # ... with 180 more rows, and 2 more variables: Description <chr>,
    ## #   DefaultCollection <chr>

listProductsByInstrument
------------------------

``` r
laads_products_instrument(instrument = "AM1M", group = "LL3L4_A")
```

    ## # A tibble: 6 x 1
    ##       Name
    ##      <chr>
    ## 1 MOD09CMG
    ## 2  MOD11C1
    ## 3  MOD11C2
    ## 4  MOD11C3
    ## 5  MOD13C1
    ## 6  MOD13C2

listProductGroups
-----------------

``` r
laads_product_groups(instrument = "AM1M")
```

    ## # A tibble: 16 x 2
    ##           Name                                              Description
    ##          <chr>                                                    <chr>
    ## 1      LL3L4_A             Terra Land Level 3/Level 4      CMG Products
    ## 2    LL3L4YT_A         Terra Land Level 3/Level 4 Yearly Tiled Products
    ## 3        N8DAT               Terra NACP 8-Day and Annual Tiled Products
    ## 4         L1_D                                  Terra  Level 1 Products
    ## 5         L0_D                                   Terra Level 0 Products
    ## 6   LL3L48DT_A      Terra Land Level 3/Level 4     8-Day Tiled Products
    ## 7        LL2_P                              Terra Land Level 2 Products
    ## 8   LL3L4DTL_A Terra Land Level 3/Level 4      Daily Tiled LST Products
    ## 9        L1B_A                            Terra Level 1 Browse Products
    ## 10     LL2DT_P                 Terra Land Level 2G Daily Tiled Products
    ## 11 LL3L416DT_A      Terra Land Level 3/Level 4    16-Day Tiled Products
    ## 12        LB_A                               Terra Land Browse Products
    ## 13        AB_A                         Terra Atmosphere Browse Products
    ## 14       AL3_A                        Terra Atmosphere Level 3 Products
    ## 15   LL3L4MT_A      Terra Land Level 3/Level 4   Monthly Tiled Products
    ## 16       AL2_A                        Terra Atmosphere Level 2 Products

getCollections
--------------

``` r
laads_collections(product = "MCD15A2")
```

    ## # A tibble: 1 x 2
    ##    Name                             Description
    ##   <chr>                                   <chr>
    ## 1     5 MODIS Collection 5 - L1, Atmos and Land
