#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param nameme1
#' @param nameme2
#' @param nameme3
#' @param nameme4
#' @param nameme5
#' @param nameme6
#' @param nameme7
#' @param nameme8
#' @param nameme9
#' @param nameme10
#' @return
#' @author njtierney
#' @export
ist <- function(nameme1 = tar_target(eda_vismiss, vis_miss(penguins)), nameme2
                = tar_target(penguins_modelling, prepare_penguins(penguins)),
                nameme3 = tar_target(eda_bills_by_sex_species,
                plot_penguin_bills(penguins_modelling)), nameme4 =
                tar_target(penguins_glm, penguins_fit(penguins_modelling)),
                nameme5 = tar_target(penguins_augment, augment(penguins_glm,
                data = penguins_modelling, type.predict = "response")), nameme6
                = tar_target(eda_fitted, plot_fitted(penguins_augment)),
                nameme7 = tar_target(eda_resid, plot_resid(penguins_augment)),
                nameme8 = tar_target(penguins_grid,
                create_grid(penguins_modelling)), nameme9 =
                tar_target(penguins_grid_preds, add_predictions(penguins_grid,
                penguins_modelling)), nameme10 = tar_target(eda_fitted_grid,
                plot_grid(penguins_grid))) {

  NULL

}
