#' Available products.
#'
#' @return A data.frame (tibble) with the Name,
#' Description and Default Collections of available products.
#' @export
#'
#' @examples
#' \dontrun{
#' laads_products()
#' }
laads_products <- function(){
  temp <- laads_get(name_service = "listProducts",
                    query_par = NULL)

  # check message
  laads_check(temp)

  # done!
  laads_parse(temp)
}
