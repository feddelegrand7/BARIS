#' Title
#'
#' @param id
#'
#' @return
#' @export
#'
#' @examples
#' @importFrom dplyr as_tibble
#'
BARIS_resources <- function(id) {


  basic_url <- "https://www.data.gouv.fr/api/1/datasets/"

  final_url <- paste("https://www.data.gouv.fr/api/1/datasets/", id, "/", sep = "")

  # set memoise cache fct
  mem_fromJSON <- BARIS_set_fromJSON()

  df <- mem_fromJSON(final_url)

  df <- df$resources[, c("id", "title",'format', 'published', 'url', 'description')]

  df <- as_tibble(df)

  return(df)
}



