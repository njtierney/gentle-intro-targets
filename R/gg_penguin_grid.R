#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param penguin_grid_pred
#' @return
#' @author njtierney
#' @export
gg_penguin_grid <- function(penguin_grid_pred) {

  ggplot(penguin_grid_pred,
         aes(x = bill_length_mm,
             y = bill_depth_mm,
             fill = .fitted)) +
    geom_tile() +
    scale_fill_continuous_sequential(
      limits = c(0,1),
      name = "Pr(Female)"
    ) +
    coord_equal()

}
