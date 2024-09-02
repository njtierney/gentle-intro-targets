#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param penguins
#' @return
#' @author njtierney
#' @export
prepare_penguins <- function(penguins) {

  penguins |>
    drop_na() |>
    mutate(
      is_female = if_else(sex == "female",
                          true = 1,
                          false = 0),
      .after = island
    )

}
