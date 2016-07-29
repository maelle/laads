#' Available collections for a given product.
#'
#' @param product character, the product short name as given by \code{laads_products()}.
#'
#' @return A data.frame (tibble) with the Name and Description of available collections
#' @export
#'
#' @examples
#' \dontrun{
#' laads_collections()
#' }
laads_collections <- function(product = "MCD15A2"){

  laads_query_check(query_par = list(product = product))

  temp <- laads_get(name_service = "getCollections",
                    query_par = list(product = product))

  # check message
  laads_check(temp)

  # done!
  laads_parse(temp)
}
