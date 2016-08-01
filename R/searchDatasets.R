#' Returns a list of products matching the supplied keywords.
#'
#' @param keywords A vector of keywords (character).
#'
#' @details The keywords are OR'd, and will match product shortname, longname, and name of any SDS's contained in the product.
#' @return A data.frame (tibble) with time of update, author name and email,
#'  title of the product (which helps knowing what's inside),
#' start and end time of the product, and the product name.
#' @export
#'
#' @examples \dontrun{
#' laads_search_datasets(keywords = c("AOD", "MODIS"))
#' }
laads_search_datasets <- function(keywords = c("AOD", "MODIS")){
  temp <- laads_get(name_service = "searchDatasets",
                    query_par = list(pattern = gsub("\\,", "", toString(keywords))))

  # check message
  laads_check(temp)

  # done!
  output <- laads_parse_datasets(temp)
  output
}


laads_parse_datasets <- function(req){
  text <- httr::content(req, as = "text")
  text <- xml2::read_xml(text)
  # somehow sometimes with bind_rows I get an error
  # "not compatible with STRSXP"
  text <- xml2::as_list(text)
  text <- lapply(text, unlist)
  text <- do.call(rbind, text)
  text <- tibble::as_tibble(apply(text, 2, unlist))
  text <- text[6:nrow(text),]
  text <- dplyr::mutate_(text, updated = lazyeval::interp(~suppressWarnings(lubridate::parse_date_time(updated,
                                                             orders = "abdhmsy", tz = "GMT"))))
  text <- dplyr::mutate_(text, end = lazyeval::interp(~suppressWarnings(lubridate::ymd_hms(end))))
  text <- dplyr::mutate_(text, start = lazyeval::interp(~suppressWarnings(lubridate::ymd_hms(start))))
  text <- dplyr::mutate_(text, product = lazyeval::interp(~gsub("Dataset:", "", summary)))
  text <- dplyr::select_(text, quote(-summary), quote(-id))

  return(text)
}
