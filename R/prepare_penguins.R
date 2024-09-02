#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title

#' @return
#' @author njtierney
#' @export
prepare_penguins <- function() {

  penguins_modelling <- penguins |>
    # remove missing value records
    drop_na() |>
    mutate(
      # code the sex as per a Bernoulli distribution
      is_female_numeric = if_else(sex == "female", 1, 0),
      .after = island
    )

  penguins_modelling

}
