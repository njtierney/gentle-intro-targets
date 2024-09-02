#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param prediction_grid
#' @return
#' @author njtierney
#' @export
gg_prediction_grid <- function(prediction_grid) {

  ggplot(prediction_grid,
         aes(x = bill_length_mm,
             y = bill_depth_mm,
             fill = .fitted)) +
    geom_raster() +
    colorspace::scale_fill_continuous_sequential(
      limits = c(0, 1),
      name = "Pr(Female)"
    ) +
    coord_equal()


}
