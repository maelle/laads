#' Range of dates covered by the given product in the given collection.
#'
#' @param collection character, collection name as given by laads_collections()
#' @param product character, product name as given by laads_products()
#'
#' @return A data.frame (tibble) with POSIXct start and end of the data collection.
#'
#' @details The range does not account for gaps in the data collection.
#' @export
#'
#' @examples
#' \dontrun{
#' laads_data_coverage(collection = "5", product = "MCD15A2")
#' }
laads_data_coverage <- function(collection = "5", product = "MCD15A2"){
  temp <- laads_get(name_service = "getDateCoverage",
                    query_par = list(collection = collection,
                                     product = product))

  # check message
  output <- laads_check(temp)

  # done!
  output <- laads_parse(temp)
  output <- strsplit(output$value, " ")[[1]]

  output <- data.frame(start = lubridate::ymd_hms(paste0(output[2], output[3])),
                        end = lubridate::ymd_hms(paste0(output[5], output[6])))

  return(tibble::as_tibble(output))
}
