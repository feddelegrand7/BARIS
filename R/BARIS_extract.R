
#' Title
#'
#' @return
#' @export
#'
#' @examples
#' @importFrom magrittr %>%
#' @importFrom dplyr as_tibble
#' @importFrom data.table fread
#' @importFrom reader get.ext


BARIS_CSVextract <- function(resourceId) {

  if(!(is.character(resourceId))){

    stop("Please provide the id as a character element")
  }

  basic_url <- "https://www.data.gouv.fr/fr/datasets/r/"

  final_url <- paste("https://www.data.gouv.fr/api/1/datasets/", resourceId, sep = "")

  resp <- httr::GET(final_url)

  if(http_type(resp) == "csv" || http_type(resp) == "text" || http_type(resp) == "text/csv" ){

    resource <- data.table::fread(final_url, stringsAsFactors = F, sep = "auto")
    resource <- dplyr::as_tibble(resource)
    return(resource)

  } else if (http_type(resp) == "xls" || http_type(resp) == "xlsx"){


    resource <- rio::import(final_url)

  } else if (#Je dois continuer XTML et JSON)









}





