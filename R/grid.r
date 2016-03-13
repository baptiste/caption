inwidth <- function(x, margin=unit(1,"mm")) {
  if(inherits(x, "text"))
    convertWidth(grobWidth(x)+margin, "in", valueOnly = TRUE) else
      convertWidth(unit(1,"line")+margin, "in", valueOnly = TRUE)
}

#' Caption rendering with grid graphics
#'
#' @param ... grobs
#' @param width width of the caption as absolute grid unit
#' @return grob
#' @export
captionGrob <- function(..., width = unit(4, "in")){
  
  maxw <- convertWidth(width, "in", valueOnly = TRUE)
  lg <- list(...)
  lw <- lapply(lg, inwidth)
  stopifnot(all(lw < maxw))
  
  # find breaks
  cw <- cumsum(lw)
  bks <- which(c(0, diff(cw %% maxw))  < 0 )
  # list of lines
  tg <- list()
  starts <- c(1, bks)
  ends <- c(bks -1, length(lg))
  
  for(line in seq_along(starts)){
    ids <- seq(starts[line], ends[line])
    sumw <- do.call(sum,lw[ids])
    neww <- maxw - sumw # missing width to fill
    filler <- rectGrob(gp=gpar(col=NA, fill=NA), 
                       width=unit(neww, "in"), 
                       height=unit(1, "line"))
    grobs <- c(lg[ids], list(filler))
    
    # store current line
    tg[[line]] <- arrangeGrob(grobs=grobs, nrow = 1, 
                              widths = unit(c(lw[ids], neww), "in"))
    
  }
  
  # arrange all lines in one column
  arrangeGrob(grobs=tg, ncol=1,
               heights = unit(rep(1, length(tg)), "line"))
  
 
}

