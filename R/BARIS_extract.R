
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
#' @importFrom downloader download
#' @importFrom sf read_sf
#' @importFrom XML xmlParse
#' @importFrom XML xmlToDataFrame
#' @importFrom httr BROWSE
#' @importFrom rgdal readOGR
#' @importFrom janitor clean_names



BARIS_extract <- function(resourceId, format) {


  basic_url <- "https://www.data.gouv.fr/fr/datasets/r/"

  final_url <- paste(basic_url, resourceId, sep = "")


  #### Reading CSV files ############################################################

  if(format == "csv" || format == "text" || format == "text/csv" ){

    df_csv <- data.table::fread(final_url, stringsAsFactors = F, sep = "auto", encoding = "UTF-8", showProgress = F)
    df_csv <- dplyr::as_tibble(df_csv)

    df_csv <- janitor::clean_names(df_csv)
    return(df_csv)

  #### Reading Excel files ############################################################


  } else if (format == "xls" || format == "xlsx"){


    df_xlsx <- rio::import(final_url)

    df_xlsx <- janitor::clean_names(df_xlsx)

    return(df_xlsx)

  #### Reading XML files ############################################################


  } else if (format == "xml" ){


    xml_info <- XML::xmlParse(httr::GET(final_url))

    xmldf <- XML::xmlToDataFrame(xml_info)

    xmldf <- janitor::clean_names(xmldf)

    return(xmldf)

  #### Reading SHP files ############################################################


  } else if (format == "shp" || format == "shapefile"){

    temp <- tempfile()
    temp2 <- tempfile()

    downloader::download(final_url, dest=temp, mode="wb")

    unzip(zipfile = temp, exdir = temp2)

    SHP_file <- list.files(temp2, pattern = ".shp$",full.names=TRUE)

    return(sf::read_sf(SHP_file))

    unlink(c(temp, temp2))


  #### Reading PDF files ############################################################


  } else if (format == "pdf" || format == "document"){

    httr::BROWSE(final_url)

  #### Downloading ZIP file ############################################################


  } else if (format == "zip" || format == "html.zip" ){

    httr::BROWSE(final_url)

  #### Downloading GEOJSON file #########################################################


  } else if (format == "geojson"){


    temp <- tempfile()
    temp2 <- tempfile()

    downloader::download(final_url, dest=temp, mode="wb")

    unzip(zipfile = temp, exdir = temp2)

    SHP_file <- list.files(temp2, pattern = "geojson$",full.names=TRUE)

    return(rgdal::readOGR(SHP_file, layer = "OGRGeoJSON"))

    unlink(c(temp, temp2))


  } else if(format == "json") {

    df_json <- jsonlite::fromJSON(final_url)

    df_json <- janitor::clean_names(df_json)

    return(df_json)

  } else {


    message(cat("Sorry, currently the available extraction capabilities are limited to \n
      json, csv, xls, xlsx, xml, geojson, and shp files"))


  }



}





