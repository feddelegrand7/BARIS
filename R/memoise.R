
is_response_successfull <- function(url) {

  response <- httr::HEAD(
    url = url
  )

  there_is_an_error <- httr::http_error(response)

  if (there_is_an_error) {

    message <- httr::http_status(response)
    message <- message$message

    message(
      glue::glue(
        "Something went wrong, here the response message:
      <<< {message} >>>

      returning NULL
      "
      )
    )
    return(FALSE)
  }

  return(TRUE)

}


#' Sets memoise cache function
#'
#' Uses the memoise package to set a cache function for jsonlite::fromJSON
#' The choice of the cache folder defines where to save the local files. If not set, will use tempdir()
#'
#' @param cache_folder The local folder where to save files
#'
#' @return A memoised function
#'
#' @examples \dontrun{
#' mem_fromJSON <- BARIS_set_fromJSON()
#' }
#' @export
#' @importFrom memoise memoise
#' @importFrom memoise cache_filesystem
#' @importFrom jsonlite fromJSON


BARIS_set_fromJSON <- function(cache_folder = tempdir()) {

  mem_fromJSON <- memoise::memoise(jsonlite::fromJSON,
    cache = memoise::cache_filesystem(cache_folder))

  return(mem_fromJSON)

}
