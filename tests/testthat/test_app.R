library(shiny)

test_that("Shiny app can be built", {
  source("../../app.R", local = TRUE)
  expect_true(exists("ui"))
  expect_true(exists("server"))
  app <- shinyApp(ui = ui, server = server)
  expect_s3_class(app, "shiny.appobj")
})
