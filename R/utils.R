# status check
laads_check <- function(req) {
  if (req$status_code < 400) return(TRUE)

  if (identical(req, "")) {
    stop("No output to parse",
         call. = FALSE)
    Sys.sleep(10)
    return(FALSE)
  }

  stop("HTTP failure: ", req$status_code, "\n", content(req)$detail, call. = FALSE)
}


# URL for access to the services
laads_url <- function() {
  "http://modwebsrv.modaps.eosdis.nasa.gov/axis2/services/MODAPSservices/"
}

laads_get <- function(name_service, query_par){
  httr::GET(url = paste0(laads_url(), name_service),
            query = query_par)
}

laads_parse <- function(req){
  text <- httr::content(req, as = "text")
  text <- xml2::read_xml(text)
  # somehow sometimes with bind_rows I get an error
  # "not compatible with STRSXP"
  text <- do.call(rbind,as_list(text))
  text <- tibble::as_tibble(apply(text, 2, unlist))
  return(text)
}
