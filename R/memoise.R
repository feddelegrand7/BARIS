

#' Title
#'
#' @param cache_folder
#'
#' @return
#' @export
#'
#'
#'
#' @examples
#' @importFrom jsonlite fromJSON
#' @importFrom memoise memoise
#' @importFrom memoise cache_filesystem
BARIS_set_fromJSON <- function(cache_folder = tempdir()) {

  mem_fromJSON <- memoise::memoise(jsonlite::fromJSON,
    cache = memoise::cache_filesystem(cache_folder))

  return(mem_fromJSON)

}
