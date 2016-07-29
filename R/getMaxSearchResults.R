#' Maximum number of file IDs that will be returned from a search.
#'
#' @return A numeric
#' @export
#'
#' @examples
#' \dontrun{
#' laads_max_search_results()
#' }
laads_max_search_results <- function(){
  temp <- laads_get(name_service = "getMaxSearchResults",
                    query_par = NULL)

  # check message
  laads_check(temp)

  # done!
  as.numeric(laads_parse(temp)$value)
}
