laads
=====

[![Build Status](https://travis-ci.org/masalmon/laads.svg?branch=master)](https://travis-ci.org/masalmon/laads) [![codecov.io](https://codecov.io/github/masalmon/laads/coverage.svg?branch=master)](https://codecov.io/github/masalmon/laads?branch=master)

laads is under development and will provide an interface to the [NASA API of MODIS Level 1 and Atmosphere data products](https://ladsweb.nascom.nasa.gov/data/api.html).

``` r
library("laads")
```

Its functions mimick the API methods. The documentation is often a copy of the parameters or API methods documentation. For knowing how to cite the data when using it, please see [this document](http://modaps.nascom.nasa.gov/services/faq/LAADS_Data-Use_Citation_Policies.pdf).

I will try to give a few workflow examples.

What data is accessible via the LAADS API
=========================================

From the [FAQ](http://modaps.nascom.nasa.gov/services/faq/), "LAADS is being populated with large volumes of MODIS data from the NASA EOS Terra and Aqua spacecrafts as they are produced. These data include Collection 5 and some earlier data from Collection 3 & 4 such as Aqua/Terra Atmosphere Level 2 & 3 products. New Collection 6 MODIS Aqua Level 1 and Level 2 Atmosphere products are available while all Terra and rest of Aqua products will be included soon. LAADS also provide access to MODIS Airborne Simulator (MAS) data (via FTP only; not searchable), NPP VIIRS Level 1, Level 2, and Level 3 products, and ENVISAT MERIS Level 1B Full Resolution (FR) and Reduced Resolution (RR) data sets from European Space Agency (ESA).".
