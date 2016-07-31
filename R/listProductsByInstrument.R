#' Available product groups for a given instrument
#'
#' @param instrument character, the instrument short name as given by \code{laads_satellite_instruments()}.
#' @param group character, the group short name as given by \code{laads_product_groups()}.
#'
#' @return A data.frame (tibble) with the Name and Description of available products
#' @export
#'
#' @examples
#' \dontrun{
#' laads_products_instrument(instrument = "AM1M", group = "LL3L4_A")
#' }
laads_products_instrument <- function(instrument = "AM1M",
                                 group = NULL){

  laads_query_check(query_par = list(instrument = instrument,
                                     group = group))

  temp <- laads_get(name_service = "listProductsByInstrument",
                    query_par = list(instrument = instrument,
                                     group = group))

  # check message
  laads_check(temp)

  # done!
  output <- laads_parse(temp)
  dplyr::rename_(output, .dots= list(Name = lazyeval::interp(~V1)))
}
