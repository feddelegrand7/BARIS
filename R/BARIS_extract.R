
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




BARIS_extract <- function(resourceId, format) {


  basic_url <- "https://www.data.gouv.fr/fr/datasets/r/"

  final_url <- paste(basic_url, resourceId, sep = "")


  #### Reading CSV files ############################################################

  if(format == "csv" || format == "text" || format == "text/csv" ){

    resource <- data.table::fread(final_url, stringsAsFactors = F, sep = "auto")
    resource <- dplyr::as_tibble(resource)
    return(resource)

  #### Reading Excel files ############################################################


  } else if (format == "xls" || format == "xlsx"){


    resource <- rio::import(final_url)

    return(resource)

  #### Reading XML files ############################################################


  } else if (format == "xml" ){


    xml_info <- XML::xmlParse(httr::GET(final_url))

    xmldf <- XML::xmlToDataFrame(xml_info)

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


  } else if (format == "pdf"){

    httr::BROWSE(final_url)

  #### Downloading ZIP file ############################################################


  } else if (format == "zip"){

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


  } else {

    return("go ahead continue")
  }











}





