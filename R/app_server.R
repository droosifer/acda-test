#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  # Your application server logic 
  clean_environ <- function(environ){
    if (is.environment(environ)) {
      lenv <- as.list(environ)
      lenv <- lenv[which(!lapply(lenv, typeof) %in% c("environment"))]
      return(lenv)
    } else {
      return(environ)
    }
  }
  
  # Store in a convenience variable
  cdata <- session$clientData
  
  
  output$sessionInfo <- listviewer::renderJsonedit({
    tryCatch({
      calt <- as.list(session)
      
      
      calt_type <- lapply(calt, typeof)
      calt_clean <- calt[which(!calt_type %in% c("closure"))]
      calt_clean <- lapply(calt_clean, clean_environ)
      calt_class <- lapply(calt_clean, class)
      calt_clean_2 <- calt_clean[which(!calt_class %in% c("reactivevalues", "shinyoutput"))]
      calt_final <- calt_clean_2
      calt_names <- names(calt_final)
      
      print(lapply(calt_final, typeof))
    },
    error = function(e) {
      message(e)
      calt_final <- list("ERROR occurred", e, "Please refresh the page")
    })
    
    listviewer::jsonedit(calt_final
             , mode = 'view'
             , modes = list('view'))
  })
  
  # Values from cdata returned as text
  output$clientdataText <- listviewer::renderJsonedit({
    listviewer::jsonedit(reactiveValuesToList(cdata), mode = 'view', modes = list('view'))
  })
}
