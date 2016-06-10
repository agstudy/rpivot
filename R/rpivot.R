

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
           displayMode =NULL,
           name ="pgridwidget",
           rows =NULL,
           columns =NULL,
           data =NULL,
           width = NULL,
           height = NULL,
           dataSettings=NULL,
           dataHeadersLocation ="columns",
           preFilters =NULL,
           toolbar =list(visible= TRUE),
           theme="green",
           update=FALSE) {

    if(missing(fields)){
      fields <- lapply(names(dataSource),function(x)list(name=x))
    }

    # create a list that contains the settings
    config <- list(
      displayMode =displayMode,
      fields = fields,
      rows = rows,
      columns=columns,
      data=data,
      dataSettings = dataSettings,
      theme= theme,
      dataHeadersLocation=dataHeadersLocation,
      preFilters=preFilters,
      toolbar= toolbar,
      grandTotal = list( rowsvisible=FALSE, columnsvisible= FALSE ),
      subTotal = list(visible=FALSE)

    )

    # pass the data and settings using 'x'
    x <- list(
      name =name,
      dataSource = dataSource,
      config = config,
      update=update
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
