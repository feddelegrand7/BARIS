BARIS_search <- function(query) {

  base_url <- "https://www.data.gouv.fr/api/1/datasets/?q="

  search <- query

  complement <- "&page=0&page_size=100"

  final_url <- paste(base_url, search, complement, sep = "")

  # set memoise cache fct
  mem_fromJSON <- BARIS_set_fromJSON()

  df_info <- mem_fromJSON(final_url)

  return(df_info)
}

