#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title

#' @return
#' @author njtierney
#' @export
prepare_penguins <- function() {

  penguins |>
    drop_na() |>
    mutate(
      is_female = if_else(sex == "female",
                          true = 1,
                          false = 0),
      .before = year
    )

}
