## this is where we extract relevant grobs from a ggplot2 legend
## and store its mapping to maintain a link between data and glyph


#' Extract legend grobs
#'
#' @param p ggplot
#' @return list with mapping metadata
#' @export
extract_legend_grobs <- function(p){

  gb <- ggplot_build(p)
  g <- ggplot_gtable(gb)
  mapping <- gb$plot$mapping
  legend <- gtable_filter(g, "guide")
  gl <- legend[["grobs"]][[1]][["grobs"]]

  one_guide <- function(gl){
    keys <- which(grepl("key", gl$layout$name) & !grepl("-bg", gl$layout$name))
    gl$grobs[keys]
  }

  list(grobs = lapply(gl, one_guide), mapping = mapping)
}
