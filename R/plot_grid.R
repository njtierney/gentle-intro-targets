#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param penguins_grid_preds
#' @return
#' @author njtierney
#' @export
plot_grid <- function(penguins_grid_preds) {

  ggplot(penguins_grid_preds,
         aes(x = bill_length_mm,
             y = bill_depth_mm,
             fill = .fitted)) +
    geom_tile() +
    scale_fill_continuous_sequential(
      limits = c(0, 1),
      name = "Pr(Female)"
    ) +
    coord_fixed()

}
