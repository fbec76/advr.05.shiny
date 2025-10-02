datasets <- list(
  "Finnish municipalities, from 2010" = "fi-8",
  "Swiss municipalities, from 2010" = "ch-8",
  "Norwegian municipalities, from 2006" = "no-7",
  "Norwegian counties, from 1919" = "no-4",
  "Danish municipalities, from 1970" = "dk-7",
  "Swedish municipalities, from 1974" = "se-7",
  "Swedish counties, from 1968" = "se-4",
  "US states" = "us-4",
  "Municipalities of Greenland since the home rule" = "gl-7",
  "Countries of the world" = "world-2"
)
ui <- shiny::fluidPage(
  shiny::titlePanel("Thenmap Historical Boundaries Viewer"),
  shiny::sidebarLayout(
    shiny::sidebarPanel(
      shiny::selectInput("region", "Dataset:",
                         choices = datasets,
                         selected = datasets[[length(datasets)]]),
      shiny::dateInput("date", "Date:", value = as.Date("2025-01-01"))
    ),
    shiny::mainPanel(
      leaflet::leafletOutput("map")
    )
  )
)

server <- function(input, output, session) {

  output$map <- leaflet::renderLeaflet({
    leaflet::leaflet() %>% leaflet::addTiles()
  })

  shiny::observeEvent(list(input$region, input$date), ignoreInit = FALSE, {
    req(input$region, input$date)

    geo_data <- tryCatch({
      advr.05::tnm_geo(dataset = input$region,
                       date = input$date,
                       geo_type = "geojson")
    }, error = function(e) {
      shiny::showNotification(paste("Error fetching data:", e$message), type = "error")
      NULL
    })
    if (is.null(geo_data)) return()

    gd <- sf::st_transform(geo_data, 4326)  # ensure WGS84

    p <- leaflet::leafletProxy("map") %>% leaflet::clearGroup("geo")

    # Choose appropriate layer based on geometry
    gtypes <- unique(sf::st_geometry_type(gd, by_geometry = TRUE))
    if (any(grepl("POINT", gtypes))) {
      p <- p %>% leaflet::addCircleMarkers(data = gd, group = "geo", radius = 4)
    } else if (any(grepl("LINE", gtypes))) {
      p <- p %>% leaflet::addPolylines(data = gd, group = "geo", weight = 2)
    } else {
      p <- p %>% leaflet::addPolygons(data = gd, group = "geo", weight = 1, fillOpacity = 0.4)
    }

    bb <- sf::st_bbox(gd)

    coords <- unname(as.numeric(bb[c("xmin", "ymin", "xmax", "ymax")]))

    leaflet::leafletProxy("map") %>%
      leaflet::fitBounds(lng1 = coords[1], lat1 = coords[2],
                         lng2 = coords[3], lat2 = coords[4])
  })
}

shiny::shinyApp(ui = ui, server = server)


