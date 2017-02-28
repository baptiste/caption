library(grid)
library(gridExtra)
library(ggplot2)
library(gtable)

p <- ggplot(ToothGrowth, aes(len, dose, shape=supp, colour=factor(dose))) + geom_point()

g <- extract_legend_grobs(p)

grid.arrange(grobs=unlist(g$grobs, recursive=FALSE),nrow=1)

tg <- lapply(c(expression(bold("Figure 1.")),"Those points","I'm making",
               "are important,", "nonetheless", "and", "have value too", ", I believe."),
             textGrob)
pGrob <- function(fill, size=1, ...){
  rectGrob(..., width=unit(size,"line"), height=unit(size,"line"), gp=gpar(fill=fill))
}

pg <- mapply(pGrob, fill=1:5, size=0.5, SIMPLIFY = FALSE)
pg <- unlist(g$grobs, recursive=FALSE)
bg <- interleave_grobs(tg, unlist(g$grobs, recursive=FALSE))
bg <- list(tg[[1]], tg[[2]], pg[[1]], pg[[2]], tg[[3]], tg[[4]],
           tg[[5]], pg[[3]], pg[[4]], tg[[6]], pg[[5]], tg[[7]])

test <- captionGrob(lg=bg, width = unit(5, "in"))
grid.newpage()
grid.arrange(p+theme(legend.position="right"), test, heights=c(5,1))
