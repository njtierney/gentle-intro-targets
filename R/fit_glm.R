#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param penguin_modelling
#' @return
#' @author njtierney
#' @export
fit_glm <- function(penguins_modelling) {

  fitted_model <- glm(
    is_female_numeric ~ bill_depth_mm + bill_length_mm,
    data = penguins_modelling,
    family = stats::binomial
  )

  fitted_model


}
