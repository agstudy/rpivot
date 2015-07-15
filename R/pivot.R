

#' Create orb pivot widget
#'
#' This function creates an orb widget using \pkg{htmlwidgets}. The
#' widget can be rendered on HTML pages generated from R Markdown, Shiny, or
#' other applications.
#'

#' @param data a data object (currently supported objects are matrices, data
#'   frames, and data.table
#' @param width the width of the pivot
#' @param height the height of the pivot
#' @return A HTML widget object).
#' @examples inst/examples/pivot.R
#' @export
#'
rpivot = function(data = NULL, width = NULL, height = NULL) {
  htmlwidgets::createWidget(
    'rpivot',
    structure(
      list(),
      dataSource = data
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
