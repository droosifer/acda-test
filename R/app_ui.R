#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic 
    titlePanel("Shiny Session Info"),
    fluidPage(
      sidebarLayout(
        sidebarPanel(
          h3("An Example App for Exploring Shiny"),
          p("If you encounter any issues with this application, please submit bugs to ", a("GitHub", href = "https://github.com/colearendt/shiny-session-info")),
          p("Use the listviewers to the right for exploring Shiny session state"),
          br(),
          h4("Important Notes"),
          p("This app has shown fragility with a large number of groups. If you see errors and have a large number of groups, please refresh")
        ),
        
        mainPanel(
          h2("session$clientData"),
          listviewer::jsoneditOutput("clientdataText"),
          h2("session"),
          listviewer::jsoneditOutput("sessionInfo"),
          h2("UI req object"),
          listviewer::jsonedit(
            safe_list(request)
            , mode = 'view'
            , modes = list('view')
          )
        )
      )
      
    )
    
    )
}

#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
 
  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'GolemTest'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
  )
}

