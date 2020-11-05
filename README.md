
<!-- README.md is generated from README.Rmd. Please edit that file -->

# BARIS <a><img src='man/figures/hex.png' align="right" height="200" /></a>

<!-- badges: start -->

[![CRAN\_Status\_Badge](https://www.r-pkg.org/badges/version/BARIS)](https://cran.r-project.org/package=BARIS)
[![CRAN\_time\_from\_release](https://www.r-pkg.org/badges/ago/BARIS)](https://cran.r-project.org/package=BARIS)
[![CRAN\_latest\_release\_date](https://www.r-pkg.org/badges/last-release/BARIS)](https://cran.r-project.org/package=BARIS)
[![metacran
downloads](https://cranlogs.r-pkg.org/badges/BARIS)](https://cran.r-project.org/package=BARIS)
[![metacran
downloads](https://cranlogs.r-pkg.org/badges/grand-total/BARIS)](https://cran.r-project.org/package=BARIS)
[![license](https://img.shields.io/github/license/mashape/apistatus.svg)](https://choosealicense.com/licenses/mit/)
[![R
badge](https://img.shields.io/badge/Build%20with-♥%20and%20R-blue)](https://github.com/feddelegrand7/BARIS)
<!-- badges: end -->

With **BARIS** you can exploit the [French Official Open Data
Portal](https://www.data.gouv.fr/fr/) API directly from R. The package
offers several capabilities, from listing the available data sets to
extracting the needed resources. Nevertheless, there are many features
offered by the API (e.g. uploading a data set, removing a resource …
among others) that are not covered within the **BARIS** package which
instead focus on the data extraction aspect of the API. The good news is
that the user doesn’t need an API key or any credential to run the
available functions provided by **BARIS**. Finally, in order to fully
apprehend the package, a distinction has to be made. The data.gouv API
provides several **data sets which contain one or many data frames.**
The unique identifier (ID) of a data set has this form :
**53699934a3a729239d2051a1** while the ID of an individual data frame or
resource has this form: **59ea7bba-f38a-4d75-b85f-2d1955050e53**.

## Installation

You can install the BARIS package from
[CRAN](https://cran.r-project.org/) with:

``` r

install.packages("BARIS")
```

You can also install the development version from
[GitHub](https://github.com/) with:

``` r

devtools::install_github("feddelegrand7/BARIS")
```

## BARIS\_home()

Using the function `BARIS_home()` you can list the displayed datasets
within the [home page of the data.gouv
website](https://www.data.gouv.fr/fr/). The function doesn’t take any
argument. It will return a data frame with many useful information about
the data set.

``` r
library(BARIS)

BARIS_home()
#> # A tibble: 12 x 13
#>    id    title organization page  views frequency temporal_cov_st~
#>    <chr> <chr> <chr>        <chr> <chr> <chr>     <chr>           
#>  1 5eeb~ Répe~ France comp~ http~ 0     weekly    <NA>            
#>  2 5efa~ Muni~ Ministère d~ http~ 0     punctual  <NA>            
#>  3 5eda~ Elec~ Ministère d~ http~ 0     unknown   <NA>            
#>  4 5ee9~ Indi~ Ministère d~ http~ 1     weekly    <NA>            
#>  5 5e7e~ Donn~ Santé publi~ http~ 119   daily     <NA>            
#>  6 5eb2~ Site~ Ministère d~ http~ 1     hourly    <NA>            
#>  7 5ecf~ Base~ ADEME        http~ 0     unknown   <NA>            
#>  8 5ee2~ Diag~ ADEME        http~ 0     unknown   <NA>            
#>  9 5e9d~ SINO~ ADEME        http~ 0     unknown   <NA>            
#> 10 5ee4~ Aide~ Unions de R~ http~ 0     unknown   <NA>            
#> 11 5ec3~ Mesu~ Unions de R~ http~ 0     unknown   <NA>            
#> 12 5e9d~ Donn~ Etalab       http~ 1     daily     2020-12-31      
#> # ... with 6 more variables: temporal_cov_end <chr>, created_at <chr>,
#> #   last_modified <chr>, last_update <chr>, archived <chr>, deleted <chr>
```

The data is quite condensed so you should use the `View()` or
`DT::datatable()` functions.

## BARIS\_search()

The `BARIS_search()` function allows you to search for a specific data
set. Suppose we’re curious about the city of Marseille.

``` r

BARIS_search(query = "Marseille", n_pages = 20)
#> # A tibble: 20 x 11
#>    id    title organization page  views frequency created_at last_modified
#>    <chr> <chr> <chr>        <chr> <chr> <chr>     <chr>      <chr>        
#>  1 5369~ Traf~ Ministère d~ http~ 0     annual    2013-07-0~ 2016-03-04T0~
#>  2 5f03~ Coll~ Ville de Ma~ http~ 0     unknown   2017-03-2~ 2019-05-09T0~
#>  3 5369~ Déco~ OpenStreetM~ http~ 28    annual    2013-11-1~ 2020-01-02T1~
#>  4 5e5a~ Cave~ <NA>         http~ 0     irregular 2020-02-2~ 2020-03-01T1~
#>  5 5ceb~ Mars~ Ville de Ma~ http~ 0     unknown   2012-12-0~ 2019-05-09T0~
#>  6 5ceb~ Mars~ Ville de Ma~ http~ 0     unknown   2015-07-1~ 2019-05-09T0~
#>  7 5ceb~ Mars~ Ville de Ma~ http~ 0     unknown   2012-12-2~ 2019-11-15T0~
#>  8 5ceb~ Mars~ Ville de Ma~ http~ 0     unknown   2012-12-0~ 2019-05-09T0~
#>  9 5ceb~ Mars~ Ville de Ma~ http~ 0     unknown   2017-07-2~ 2019-05-09T0~
#> 10 5dd7~ Quar~ Datactivist  http~ 0     unknown   2019-11-2~ 2019-11-22T1~
#> 11 5878~ Arro~ NosDonnées.~ http~ 0     unknown   2014-03-0~ 2017-07-10T0~
#> 12 5878~ Quar~ NosDonnées.~ http~ 0     unknown   2016-03-3~ 2017-07-10T0~
#> 13 5ceb~ Mars~ Ville de Ma~ http~ 0     unknown   2013-10-2~ 2020-06-29T0~
#> 14 5e87~ Mars~ Ville de Ma~ http~ 0     unknown   2020-04-0~ 2020-04-03T0~
#> 15 5ceb~ Mars~ Ville de Ma~ http~ 0     unknown   2011-06-1~ 2019-05-09T0~
#> 16 5ceb~ Mars~ Ville de Ma~ http~ 0     unknown   2012-12-0~ 2018-08-22T0~
#> 17 5ceb~ Mars~ Ville de Ma~ http~ 0     unknown   2012-12-0~ 2019-05-09T0~
#> 18 5ceb~ Mars~ Ville de Ma~ http~ 0     unknown   2012-11-2~ 2019-05-09T0~
#> 19 5ceb~ Mars~ Ville de Ma~ http~ 0     unknown   2011-06-1~ 2019-05-09T0~
#> 20 5ceb~ Mars~ Ville de Ma~ http~ 0     unknown   2014-05-0~ 2019-05-09T0~
#> # ... with 3 more variables: last_update <chr>, archived <chr>, deleted <chr>
```

The **n\_page** argument is used to specify the number of pages to
search for according to the pagination system of the API, by default its
value is equal to 20. Now, in order to choose a dataset, let’s have a
look at two columns, the ID and the title of each dataset.

``` r

Marseille_data <- BARIS_search(query = "Marseille", n_pages = 20)

Marseille_data[, c("id", "title")]
#> # A tibble: 20 x 2
#>    id                     title                                                 
#>    <chr>                  <chr>                                                 
#>  1 5369a248a3a729239d206~ Trafic aéroport Marseille-Provence : passagers et mou~
#>  2 5f031bed84d60df5d5d05~ Collections du Musée ZIEM                             
#>  3 53699233a3a729239d203~ Découpage administratif communal français issu d'Open~
#>  4 5e5a7bc2634f413b2369e~ Caves à bière                                         
#>  5 5cebfa8506e3e77ffdb31~ Marseille - Cimetières                                
#>  6 5cebfa8706e3e77c78b31~ Marseille - Crèches                                   
#>  7 5cebfa869ce2e76116c3a~ Marseille - Délibérations                             
#>  8 5cebfa839ce2e76116c3a~ Marseille - Élus                                      
#>  9 5cebfa869ce2e764aac3a~ Marseille - Subventions                               
#> 10 5dd7a9a78b4c41277a7fb~ Quartiers de Marseille                                
#> 11 5878ee29a3a7291485cac~ Arrondissements de Marseille                          
#> 12 5878ee75a3a7291484cac~ Quartiers de Marseille                                
#> 13 5cebfa8306e3e77ffdb31~ Marseille - Monuments historiques                     
#> 14 5e87cef997cf8d9b8cd10~ Marseille - COVID19 - crèches ouvertes                
#> 15 5cebfa8306e3e77c78b31~ Marseille - Écoles élémentaires                       
#> 16 5cebfa869ce2e764aac3a~ Marseille - Lieux culturels                           
#> 17 5cebfa869ce2e76116c3a~ Marseille - Équipements sociaux                       
#> 18 5cebfa839ce2e76116c3a~ Marseille - Wifi public                               
#> 19 5cebfa849ce2e764aac3a~ Marseille - Écoles maternelles                        
#> 20 5cebfa8706e3e77ffdb31~ Marseille - Élections législatives
```

Suppose we’re interested in the dataset entitled **Marseille - Monuments
historiques** with its corresponding ID: **5cebfa8306e3e77ffdb31ef5**
and we want to know more about this data. In this case, the
`BARIS_explain()` function can be useful.

## BARIS\_explain()

`BARIS_explain()` returns a description of a dataset. It has one
argument which is the ID of the dataset of interest.

``` r

BARIS_explain("5cebfa8306e3e77ffdb31ef5")
#> [1] "Monuments historiques situés sur le territoire de Marseille, avec adresse, numéro de base Mérimée (base de données du Ministère de la Culture recensant les monuments historiques de toute la France) et points de géolocalisation"
```

The description is in French but even non-French speakers can use this
function in conjunction with a translation tool, for the example the
[googleLanguageR
package](https://CRAN.R-project.org/package=googleLanguageR).

## BARIS\_resources()

As mentioned previously, each data set contains one or several data
frames or as the API call them **resources**. The `BARIS_resources()`
function allows you to list all the available resources within a
determined data set.

``` r

BARIS_resources("5cebfa8306e3e77ffdb31ef5") # The "Marseille - Monuments historiques" ID
#> # A tibble: 2 x 6
#>   id         title       format published   url             description         
#>   <chr>      <chr>       <chr>  <chr>       <chr>           <chr>               
#> 1 59ea7bba-~ MARSEILLE_~ csv    2019-05-27~ https://trouve~ Monuments historiqu~
#> 2 6328f8b3-~ Plan des M~ pdf    2019-05-27~ https://trouve~ Edition Janvier 2013
```

Many useful information related to the resource are provided: The id,
the title, the format, the date of publication, the url of the resource,
and a description.

## BARIS\_extract()

The `BARIS_extract()` function allows you to extract the needed resource
into your R session. You have to specify the id of the resource and its
format. Currently, “only” theses formats are supported: json, csv, xls,
xlsx, xml, geojson and shp, nevertheless you can always rely on the url
of the resource to download whatever you need.

As an example, let us extract the above listed csv file:
*MARSEILLE\_MONUMENTS\_HISTORIQUES\_2018.csv*:

``` r

BARIS_extract(resourceId = "59ea7bba-f38a-4d75-b85f-2d1955050e53", format = "csv")
#> # A tibble: 80 x 10
#>    n_base_merimee date_de_protect~ denomination adresse code_postal
#>    <chr>          <chr>            <chr>        <chr>         <int>
#>  1 PA00081336     Classement : li~ Ancienne ég~ "/"           13002
#>  2 PA00081340     Classement: 13/~ Eglise Sain~ "Espla~       13002
#>  3 PA00081331     Classement: 29/~ Chapelle et~ "2, Ru~       13002
#>  4 PA00081344     Classement: 16/~ Fort Saint-~ ""            13002
#>  5 PA00081325     Inscription : 2~ Les deux bâ~ "Quai ~       13002
#>  6 PA00081334     Inscription : 0~ Clocher des~ "Monté~       13002
#>  7 PA00081348     Classement: 12/~ Hôtel Davie~ "Place~       13002
#>  8 PA00081363     Classement: 02/~ Maison dite~ "27, G~       13002
#>  9 PA00081349     Inscription : 1~ Hôtel-Dieu-~ "6, Pl~       13002
#> 10 PA00081354     Classement: 30/~ Hôtel de Vi~ "Quai ~       13002
#> # ... with 70 more rows, and 5 more variables: proprietaire_du_monument <chr>,
#> #   epoque_de_construction <chr>, date_de_construction <chr>, longitude <dbl>,
#> #   latitude <dbl>
```

# BARIS Addin

BARIS comes with an integrated Addin that generates a Shiny widget
allowing the user to interact with the package in an interactive manner.

# Citation

If you use the BARIS package for your work, research or teaching, I’d
appreciate if you could cite it as follows:

Mohamed El Fodil Ihaddaden (2020). BARIS: Access and Import Data from
the French Open Data Portal. R package version 1.1.1.
<https://CRAN.R-project.org/package=BARIS>

A BibTeX entry for LaTeX users is

@Manual{, title = {BARIS: Access and Import Data from the French Open
Data Portal}, author = {Mohamed El Fodil Ihaddaden}, year = {2020}, note
= {R package version 1.1.1}, url =
{<https://CRAN.R-project.org/package=BARIS>}, }

## Code of Conduct

Please note that the BARIS project is released with a [Contributor Code
of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
Finally, I appreciate any feedback, feel free to reach out at
[moh\_fodil](https://twitter.com/moh_fodil) or open an issue on
[Github](https://github.com/feddelegrand7/BARIS/issues).
