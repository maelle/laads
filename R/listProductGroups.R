#' Available product groups for a given instrument
#'
#' @param instrument character, the instrument short name as given by \code{laads_satellite_instruments()}.
#'
#' @return A data.frame (tibble) with the Name and Description of available product groups
#' @export
#'
#' @examples
#' \dontrun{
#' laads_product_groups()
#' }
laads_product_groups <- function(instrument = "AM1M"){

  laads_query_check(query_par = list(instrument = instrument))

  temp <- laads_get(name_service = "listProductGroups",
                    query_par = list(instrument = instrument))

  # check message
  laads_check(temp)

  # done!
  output <- laads_parse(temp)
  dplyr::rename(output, Name = V1, Description = V2)
}
