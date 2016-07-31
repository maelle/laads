# status check
laads_check <- function(req) {
  if (req$status_code < 400) return(TRUE)

  if (identical(req, "")) {
    stop("No output to parse",
         call. = FALSE)
    Sys.sleep(10)
    return(FALSE)
  }

  stop("HTTP failure: ", req$status_code, "\n", httr::content(req)$detail, call. = FALSE)
}


# URL for access to the services
laads_url <- function() {
  "http://modwebsrv.modaps.eosdis.nasa.gov/axis2/services/MODAPSservices/"
}

# check arguments
laads_query_check <- function(query_par){
  if(!is.null(query_par$product)){
    if(!(query_par$product %in% laads_products()$Name)){
      stop(call. = FALSE,
           paste0(query_par$product, " is not a product name for LAADS. See existing Names in laads_products()"))
    }
  }

  if(!is.null(query_par$instrument)){
    if(!(query_par$instrument %in% laads_satellite_instruments()$Name)){
      stop(call. = FALSE,
           paste0(query_par$instrument, " is not an instrument name for LAADS. See existing Names in laads_satellite_instruments()"))
    }
  }
}

# get
laads_get <- function(name_service, query_par){
  httr::GET(url = paste0(laads_url(), name_service),
            query = query_par)
}

# parse
laads_parse <- function(req){
  text <- httr::content(req, as = "text")
  text <- xml2::read_xml(text)
  # somehow sometimes with bind_rows I get an error
  # "not compatible with STRSXP"
  text <- do.call(rbind, xml2::as_list(text))

  if(nrow(text) == 1 & ncol(text) == 2){
    text <- tibble::tibble_(list(Name = lazyeval::interp(~as.character(text[1,1][[1]][[1]])),
                           Description = lazyeval::interp(~as.character(text[1,2][[1]][[1]]))))

  }else{
    text <- tibble::as_tibble(apply(text, 2, unlist))
  }

  return(text)
}


