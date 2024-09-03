#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param penguins_modelling
#' @return
#' @author njtierney
#' @export
fit_glm <- function(penguins_modelling) {

  glm(
    formula = is_female ~ bill_length_mm + bill_depth_mm,
    # so we do logistic regression
    family = stats::binomial,
    data = penguins_modelling
  )

}
