#' server 
#'
#' @description A utils function
#'
#' @return The return value, if any, from executing the utility.
#'
#' @noRd
#' 
#' 
#' 
safe_list <- function(.list) {
  tryCatch({
    obj <- as.list(.list)
    obj <- lapply(obj, function(x){
      if (is.character(x) && nchar(x) > 300) {
        return(
          paste0(
            substr(x, 1, pmin(nchar(x), 300)),
            "... [[ truncated for space ]]"
          )
        )
      } else {
        return(x)
      }
    })
  }, error = function(e) {
    message(e)
    obj <- list(
      "ERROR",
      e,
      "Please refresh the page to see if the error persists",
      "If so, submit an issue here:",
      "https://github.com/colearendt/shiny-session-info"
    )
  })
  
  return(obj)
}