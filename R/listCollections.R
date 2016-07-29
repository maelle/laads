#' Available collections.
#'
#' @return A data.frame (tibble) with the Name and Description of available collections
#' @export
#'
#' @examples
#' \dontrun{
#' laads_collections()
#' }
laads_collections <- function(){
  temp <- laads_get(name_service = "listCollections",
                    query_par = NULL)

  # check message
  laads_check(temp)

  # done!
  output <- laads_parse(temp)
  dplyr::rename(output, Name = V1, Description = V2)
}
