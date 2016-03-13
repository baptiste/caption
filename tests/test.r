library(grid)
library(gridExtra)
library(ggplot2)
library(gtable)

p <- ggplot(ToothGrowth, aes(len, dose, shape=supp, colour=factor(dose))) + geom_point() +
  theme(legend.position="bottom",
        legend.background=element_rect(colour="black"))

g <- extract_legend_grobs(p)

grid.arrange(grobs=unlist(g$grobs, recursive=FALSE))

tg <- lapply(c("Figure 1. Those points I'm making",
               "are important, ", "nonetheless", "and", "have value too", "I believe."),
             textGrob)
pGrob <- function(fill, size=1, ...){
  rectGrob(..., width=unit(size,"line"), height=unit(size,"line"), gp=gpar(fill=fill))
}

pg <- mapply(pGrob, fill=1:5, size=0.5, SIMPLIFY = FALSE)

bg <- interleave_grobs(tg, unlist(g$grobs, recursive=FALSE))

test <- captionGrob(lg=bg, width = unit(3, "in"))
grid.newpage()
grid.arrange(p+theme(legend.position="none"), test, ncol=1)
