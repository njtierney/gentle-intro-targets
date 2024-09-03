#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param penguins_prediction_grid
#' @return
#' @author njtierney
#' @export
gg_prediction_grid <- function(penguins_prediction_grid) {

  ggplot(penguins_prediction_grid,
         aes(x = bill_depth_mm,
             y = bill_length_mm,
             fill = .fitted)) +
    geom_tile() +
    scale_fill_continuous_sequential()

}
