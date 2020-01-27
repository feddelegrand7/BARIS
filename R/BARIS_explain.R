
#' Title
#'
#' @return
#' @export
#'
#' @examples
#' @importFrom magrittr %>%
#' @importFrom dplyr as_tibble
#' @importFrom stringr str_replace_all
#' @importFrom stringr str_trim


BARIS_explain <- function(datasetId) {

  if(!(is.character(datasetId))){

    stop("Please provide the id as a character element")
  }

  basic_url <- "https://www.data.gouv.fr/api/1/datasets/"

  final_url <- paste("https://www.data.gouv.fr/api/1/datasets/", datasetId, "/", sep = "")

  # set memoise cache fct
  mem_fromJSON <- BARIS_set_fromJSON()

  df_explain <- mem_fromJSON(final_url)

  Encoding(df_explain$description) <- "UTF-8"

  df_explain$description <- df_explain$description %>%
    str_replace_all(c("\n" = " ","\r" = " ", "&#x27;" = "'")) %>%
    str_trim()


  return(df_explain$description)
}





