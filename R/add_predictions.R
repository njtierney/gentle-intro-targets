#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param penguin_grid
#' @param penguin_glm
#' @return
#' @author njtierney
#' @export
add_predictions <- function(penguin_grid, penguin_glm) {

  penguin_grid |>
    mutate(
      .fitted = predict(penguin_glm,
                        newdata = penguin_grid,
                        type = "response")
    )

}
