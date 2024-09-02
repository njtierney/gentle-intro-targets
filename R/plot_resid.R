#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param penguins_augment
#' @return
#' @author njtierney
#' @export
plot_resid <- function(penguins_augment) {

  ggplot(penguins_augment,
         aes(x = bill_length_mm,
             y = .resid)) +
    geom_point()

}
