library(shiny)
library(leaflet)
library(advr.05)

datasets <- list(
  "World nations (world-2)" = "world-2",
  "Swedish municipalities (se-8)" = "se-8",
  "Swedish counties (se-6)" = "se-6",
  "Swedish historical counties (se-7)" = "se-7",
  "Norwegian municipalities (no-8)" = "no-8",
  "Norwegian counties (no-6)" = "no-6",
  "Danish municipalities (dk-8)" = "dk-8",
  "Danish counties (dk-6)" = "dk-6",
  "Finnish municipalities (fi-8)" = "fi-8",
  "Finnish counties (fi-6)" = "fi-6",
  "German states (de-4)" = "de-4",
  "French departments (fr-4)" = "fr-4",
  "UK counties (gb-4)" = "gb-4"
  # Add more if the API expands
)

ui <- fluidPage(
  titlePanel("Thenmap Historical Boundaries Viewer"),
  sidebarLayout(
    sidebarPanel(
      selectInput("region", "Select Dataset:", choices = datasets),
      dateInput("date", "Select Date:", value = "1900-01-01")
    ),
    mainPanel(
      leafletOutput("map")
    )
  )
)

server <- function(input, output, session) {
  output$map <- renderLeaflet({
    req(input$region, input$date)

    geo_data <- tryCatch({
      tnm_geo(dataset = input$region,
              date = input$date,
              geo_type = "geojson")
    }, error = function(e) {
      showNotification(paste("Error fetching data:", e$message), type = "error")
      return(NULL)
    })

    if (is.null(geo_data)) return(NULL)

    leaflet() %>%
      addTiles() %>%
      addGeoJSON(geo_data)
  })
}

shinyApp(ui = ui, server = server)


