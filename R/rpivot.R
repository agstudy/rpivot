

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
rpivot = function(data = NULL,fields,  width = NULL, height = NULL) {

  # create a list that contains the settings
  config <- list(
    fields = fields
  )

  # pass the data and settings using 'x'
  x <- list(
    data = data,
    config = config
  )

  # create the widget
  htmlwidgets::createWidget("rpivot", x, width = width, height = height)
}




#' @export
pivotOutput <- function(outputId, width = "100%", height = "400px") {
  shinyWidgetOutput(outputId, "rpivot", width, height, package = "rpivot")
}
#' @export
renderPivot <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, sigmaOutput, env, quoted = TRUE)
}
