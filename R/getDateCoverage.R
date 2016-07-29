#' Range of dates covered by the given product in the given collection.
#'
#' @param collection character, collection name as given by laads_collections()
#' @param product character, product name as given by laads_products()
#'
#' @return A data.frame (tibble)
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
  laads_check(temp)

  # done!
  laads_parse(temp)
}
