BARIS_ui <- function() {


  ui <- miniUI::miniPage(shiny::tags$style(".fa-lemon {color:gold}"),
                         shiny::tags$style("body{background-color:#111111 ; color:#F4F4F6"),




    miniUI::miniTabstripPanel(
    # home tab ----------------------------------------------------------------

    miniUI::miniTabPanel(
      "Home",
      icon = shiny::icon("lemon"),
      miniUI::gadgetTitleBar(
        "Home data.gouv",
        right = miniUI::miniTitleBarButton("done", "Get", primary = T),
        left = miniUI::miniTitleBarButton("cancel", "Cancel", primary = T)
      ),

      miniUI::miniContentPanel(

        shiny::p("Click on Get to display data.gouv.fr home page data sets"),

        shiny::tableOutput(outputId = "home")

        )

    ),


    # searching tab -----------------------------------------------------------



    miniUI::miniTabPanel(
      "Searching",
      miniUI::gadgetTitleBar(
        "Searching",
        right = miniUI::miniTitleBarButton("done1", "Get", primary = T),
        left = miniUI::miniTitleBarButton("cancel1", "Cancel", primary = T)
      ),
      miniUI::miniContentPanel(
        shiny::p("Queries must be written in French, don't forget to click on Get"),
        shiny::textInput(inputId = "search_input", label = "What are you looking for ? "),
        shiny::tableOutput(outputId = "search_output")

      )
    ),


    # description tab ---------------------------------------------------------

    miniUI::miniTabPanel(
      "Description",
      miniUI::gadgetTitleBar(
        "Description",
        right = miniUI::miniTitleBarButton("done2", "Get", primary = T),
        left = miniUI::miniTitleBarButton("cancel2", "Cancel", primary = T)
      ),
      miniUI::miniContentPanel(
        shiny::p("Paste the ID of the data set to get a description, click on Get"),
        shiny::textInput(inputId = "description_input", label = "The ID of a Data Set"),
        shiny::textOutput(outputId = "description_output")

      )
    ),




    # resource tab ------------------------------------------------------------

    miniUI::miniTabPanel(
      "Resources",
      miniUI::gadgetTitleBar(
        "Resources",
        right = miniUI::miniTitleBarButton("done3", "Get", primary = T),
        left = miniUI::miniTitleBarButton("cancel3", "Cancel", primary = T)
      ),
      miniUI::miniContentPanel(
        shiny::p("Paste the ID of the data set to list the resources contained in it"),
        shiny::textInput(inputId = "resource_input", label = "The ID of a Data Set"),
        shiny::tableOutput(outputId = "resource_output")

      )
    ),




    # extract tab -------------------------------------------------------------


    miniUI::miniTabPanel(
      "Extract",
      miniUI::gadgetTitleBar(
        "Extracting",
        right = miniUI::miniTitleBarButton("done4", "Get", primary = T),
        left = miniUI::miniTitleBarButton("cancel4", "Cancel", primary = T)
      ),
      miniUI::miniContentPanel(
        shiny::textInput(inputId = "resource_id", label = "The ID the resource"),
        shiny::textInput(inputId = "resource_format", label = "The format of the resource (in lower case)"),
        shiny::textInput(inputId = "resource_name", label = "Give it a name"),

        shiny::p("Run the following code in your R session"),

        shiny::verbatimTextOutput(outputId = "extract_output", placeholder = T)

      )
    )

  ))


  # server ------------------------------------------------------------------



  server <- function(input, output) {
    # home output -------------------------------------------------------------

    shiny::observeEvent(input$done, {
      output$home <- shiny::renderTable(BARIS::BARIS_home())



    })



    # search output -----------------------------------------------------------


    toListen <- shiny::reactive({
      input$done1
    })

    shiny::observeEvent(toListen(), {
      output$search_output <- shiny::renderTable(BARIS::BARIS_search(query = input$search_input))



    })



    # description output ------------------------------------------------------

    description <- shiny::reactive({
      input$done2
    })

    shiny::observeEvent(description(), {
      output$description_output <- shiny::renderPrint(BARIS::BARIS_explain(datasetId = input$description_input))



    })




    # resource output ---------------------------------------------------------

    resource <- shiny::reactive({
      input$done3
    })


    shiny::observeEvent(resource(), {
      output$resource_output <- shiny::renderTable(BARIS::BARIS_resources(datasetId = input$resource_input))



    })



    # extract output ----------------------------------------------------------


    extract <- shiny::reactive({
      input$done4
    })


    shiny::observeEvent(extract(), {

      output$extract_output <- shiny::renderText(

        paste(input$resource_name, " <- ", "BARIS_extract(", "'",input$resource_id,"'" , " , ","'",input$resource_format,"'", " )", sep = "")

      )



    })





    # cancel ------------------------------------------------------------------



    shiny::observeEvent(input$cancel, {
      shiny::stopApp(stop(""), call = FALSE)


    })


    shiny::observeEvent(input$cancel1, {
      shiny::stopApp(stop(""), call = FALSE)


    })


    shiny::observeEvent(input$cancel2, {
      shiny::stopApp(stop(""), call = FALSE)


    })


    shiny::observeEvent(input$cancel3, {
      shiny::stopApp(stop(""), call = FALSE)


    })

    shiny::observeEvent(input$cancel4, {
      shiny::stopApp(stop(""), call = FALSE)


    })

  }

shiny::runGadget(ui, server, viewer = shiny::paneViewer())


}



