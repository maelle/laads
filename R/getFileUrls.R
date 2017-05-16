#' Returns the data file FTP URLs for the given file IDs.
#'
#' @param file_ids file IDs for the data files, either a single one or a vector of IDs. For getting IDs see \code{laads_search_files}.
#'
#' @details Not all files are available online.
#' See \code{laads_order_files()} for ordering files that cannot be downloaded directly,
#' and the "online" column of \code{laads_order_files()} to know which ones are available online.
#'
#' @return  A data.frame (tibble) with two columns, "file_id" and "file_url.
#' @export
#'
#' @examples \dontrun{
#' laads_file_urls(file_ids = c("299343600", "299344827"))
#' }
laads_file_urls <- function(file_ids = "299343600"){

  output <- NULL

  # not too many IDs at once
  request <- split(file_ids, ceiling(seq_along(file_ids)/100))

  for(i in 1:length(request)) {

    temp <- laads_get(name_service = "getFileUrls",
                      query_par = list(fileIds = gsub(" ", "", toString(request[[i]]))))

    # check message
    laads_check(temp)

    # done!
    output <- laads_parse(temp)

    output <- dplyr::mutate_(output, file_id =  ~file_ids)
    if(nrow(output) == 1){
      output <- dplyr::rename_(output, .dots= list(file_url = lazyeval::interp(~value)))
    }
    else{
      output <- dplyr::rename_(output, .dots= list(file_url = lazyeval::interp(~V1)))
    }
  }


  output <- dplyr::select_(output, .dots = list(quote(file_id), quote(file_url)))

  return(output)
}
