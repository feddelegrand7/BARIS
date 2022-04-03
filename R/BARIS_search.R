#' Searching for a data set
#'
#' @description This function searches specific data sets through the data.gouv API according to the pattern provided into the query argument.
#'
#'
#' @param query a character string defining the research.
#' @param page_number numeric value denoting which page to search for, defaults to 1
#' @param page_size numeric value, for a specific page (see \code{page_number}), how
#' many results do you want to query. Defaults to 20
#' @return a character string
#' @examples \donttest{
#'
#' BARIS_search("Marseille")}
#' @export
#' @importFrom dplyr as_tibble
#' @importFrom stringr str_replace_all
#' @importFrom stringi stri_trans_general


BARIS_search <- function(query, page_number = 1, page_size = 20) {

  base_url <- "https://www.data.gouv.fr/api/1/datasets/?q="

  search <- query

  search <- str_replace_all(search, c(" " = "%20", "  " = "%20"))

  search <- stri_trans_general(search, id = "Latin-ASCII")

  complement <- glue::glue("&page={page_number}&page_size={page_size}")

  final_url <- paste0(base_url, search, complement)

  response_status <- is_response_successfull(final_url)

  if (!response_status) {
    return(NULL)
  }

  # set memoise cache fct
  mem_fromJSON <- BARIS_set_fromJSON()

  df_info <- mem_fromJSON(final_url)

  df_info <- df_info$data

  if (is.null(df_info) || length(df_info) == 0) {
    message("No data found for the requested search,
            returning NULL")
    return(NULL)
  }

  id                 <- df_info$id

  title              <- df_info$title

  frequency          <- df_info$frequency

  created_at         <- df_info$created_at

  last_modified      <- df_info$last_modified

  last_update        <- df_info$last_update

  archived           <- df_info$archived

  deleted            <- df_info$deleted

  views              <- df_info$metrics[[4]]

  organization       <- df_info$organization[[6]]

  page               <- df_info$page

  df_info2 <- cbind(
    id,
    title,
    organization,
    page,
    views,
    frequency,
    created_at,
    last_modified,
    last_update,
    archived,
    deleted

  )

  df_info2 <- as_tibble(df_info2)

  return(df_info2)

}

