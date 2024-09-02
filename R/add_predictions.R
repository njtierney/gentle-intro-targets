#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param data_grid
#' @param fitted_glm
#' @return
#' @author njtierney
#' @export
add_predictions <- function(data_grid, fitted_glm) {

  data_grid |>
    mutate(
      .fitted = predict(fitted_glm,
                        newdata = data_grid,
                        type = "response"),
      .before = everything()
    )

}
