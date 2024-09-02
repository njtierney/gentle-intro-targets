#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param penguins_modelling
#' @return
#' @author njtierney
#' @export
create_grid <- function(penguins_modelling) {

  expand_grid(
    bill_length_mm = seq(
      min(penguins_modelling$bill_length_mm),
      max(penguins_modelling$bill_length_mm),
      length.out = 50
    ),
    bill_depth_mm = seq(
      min(penguins_modelling$bill_depth_mm),
      max(penguins_modelling$bill_depth_mm),
      length.out = 50
    )
  )

}
