#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param penguins_grid
#' @param penguins_modelling
#' @return
#' @author njtierney
#' @export
add_predictions <- function(penguins_grid, penguins_glm) {

  penguins_grid |>
    mutate(
      .fitted = predict(penguins_glm,
                        newdata = penguins_grid,
                        type = "response"),
      .before = everything()
      )


}
