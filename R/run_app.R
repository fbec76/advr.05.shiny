#' Run the Shiny application
#' @param ... passed to shiny::runApp (e.g., host, port, launch.browser)
#' @export
run_app <- function(...) {
  app_dir <- system.file("app", package = "advr.05.shiny")
  if (app_dir == "") stop("Could not find app directory. Try reinstalling `advr.05.shiny`.", call. = FALSE)
  shiny::runApp(appDir = app_dir, ...)
}