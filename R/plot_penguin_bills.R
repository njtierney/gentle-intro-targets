#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param penguins_modelling
#' @return
#' @author njtierney
#' @export
plot_penguin_bills <- function(penguins_modelling) {

  ggplot(penguins_modelling,
         aes(x = bill_length_mm,
             y = bill_depth_mm,
             colour = sex)) +
    geom_point() +
    scale_colour_discrete_qualitative() +
    facet_wrap(~species)

}
