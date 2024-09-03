#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param penguins_glm
#' @param penguins_modelling
#' @return
#' @author njtierney
#' @export
prediction_grid <- function(penguins_glm, penguins_modelling,
                            grid_size = 25) {

  # create the grid
  data_grid <- expand_grid(
    bill_depth_mm = seq(
      min(penguins_modelling$bill_depth_mm),
      max(penguins_modelling$bill_depth_mm),
      length.out = grid_size
  ),
  bill_length_mm = seq(
    min(penguins_modelling$bill_length_mm),
    max(penguins_modelling$bill_length_mm),
    length.out = grid_size
  )
  )

  data_grid |>
    mutate(
      .fitted = predict(object = penguins_glm,
                        newdata = data_grid,
                        type = "response")
    )

}
