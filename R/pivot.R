

rpivot = function(data = NULL, width = NULL, height = NULL) {
  htmlwidgets::createWidget(
    'rpivot',
    structure(
      list(),
      orbDataSource = data
    ),
    width = width, height = height,
    sizingPolicy = htmlwidgets::sizingPolicy(
      defaultWidth = '100%',
      defaultHeight = 600,
      browser.fill = TRUE
    )
  )
}


rpivotConfig <- function(pivot) {
  if (is.null(pivot$x$config))
    pivot$x$config <- list()


  pivot
}
