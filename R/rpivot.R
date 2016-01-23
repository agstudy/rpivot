

#' Create orb pivot widget
#'
#' This function creates an orb widget using \pkg{htmlwidgets}. The
#' widget can be rendered on HTML pages generated from R Markdown, Shiny, or
#' other applications.
#'

#' @param dataSource a data object (currently supported objects are matrices, data
#'   frames, and data.table
#' @param width the width of the pivot
#' @param height the height of the pivot
#' @return A HTML widget object).
#' @examples inst/examples/pivot.R
#' @export
#'
rpivot <-
  function(dataSource,
           fields ,
           rows =NULL,
           columns =NULL,
           data =NULL,
           width = NULL,
           height = NULL) {

    # create a list that contains the settings
    config <- list(
      fields = fields,
      rows = rows,
      columns=columns,
      data=data
    )

    # pass the data and settings using 'x'
    x <- list(
      dataSource = dataSource,
      config = config
    )
    attr(x, 'TOJSON_ARGS') <- list(dataframe = "rows")
    # create the widget
    htmlwidgets::createWidget("rpivot", x, width = width, height = height)
  }




#' @export
#' @import htmlwidgets
pivotOutput <- function(outputId, width = "100%", height = "400px") {
  shinyWidgetOutput(outputId, "rpivot", width, height, package = "rpivot")
}
#' @export
#' @import htmlwidgets
renderPivot <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, pivotOutput, env, quoted = TRUE)
}
