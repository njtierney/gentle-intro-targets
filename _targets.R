library(tidyverse)
library(targets)
library(visdat)
library(palmerpenguins)
library(conflicted)
library(colorspace)
library(broom)
conflicts_prefer(
  dplyr::filter
)

tar_source()

list(
  tar_target(eda_vismiss,
             vis_miss(penguins)),
  tar_target(penguins_modelling,
             prepare_penguins(penguins)),
  tar_target(eda_bills_by_sex_species,
             plot_penguin_bills(penguins_modelling)),
  tar_target(penguins_glm,
             penguins_fit(penguins_modelling)),
  tar_target(penguins_augment,
             augment(penguins_glm,
                     data = penguins_modelling,
                     type.predict = "response")),
  tar_target(eda_fitted,
             plot_fitted(penguins_augment)),
  tar_target(eda_resid,
             plot_resid(penguins_augment)),
  tar_target(penguins_grid,
             create_grid(penguins_modelling)),
  tar_target(penguins_grid_preds,
             add_predictions(penguins_grid, penguins_glm)),
  tar_target(eda_fitted_grid,
             plot_grid(penguins_grid_preds))
)

# scratchpad function
# stolen from https://milesmcbain.github.io/ssa_targets_workshop/targets_plan.html
# credit to Gabor Csardi and Miles McBain
