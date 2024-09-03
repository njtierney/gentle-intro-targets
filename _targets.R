library(tidyverse)
library(palmerpenguins)
library(visdat)
library(colorspace)
library(broom)
library(targets)
library(tarchetypes)

tar_source()

list(

  tar_target(penguins_modelling,
             prepare_penguins()),

  tar_target(penguins_vismiss, vis_miss(penguins)),

  tar_target(plot_bills,
             gg_bills(penguins_modelling)),

  tar_target(penguins_glm, fit_glm(penguins_modelling)),

  tar_target(augmented_penguins,
             augment(penguins_glm, type.predict = "response")),

  tar_quarto(scratch, path = "eda/scratch.qmd"),

  tar_target(penguins_prediction_grid,
             prediction_grid(
               penguins_glm,
               penguins_modelling,
               grid_size = 100
               )
             ),

  tar_target(plot_prediction_grid,
             gg_prediction_grid(penguins_prediction_grid))


)
