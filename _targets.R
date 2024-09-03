library(tidyverse)
library(palmerpenguins)
library(visdat)
library(colorspace)
library(broom)
library(targets)
library(tarchetypes)

tar_source()

tar_option_set(
  workspace_on_error = TRUE
)

list(

  tar_file(new_penguins,
           "data/penguins-modelling.csv"),

  tar_target(some_penguins, read_csv(new_penguins)),

  tar_target(penguins_modelling,
             prepare_penguins(penguins)),

  tar_target(penguins_vismiss, vis_miss(penguins_modelling)),

  tar_target(plot_bills,
             gg_bills(penguins_modelling)),

  tar_target(penguins_glm,
             fit_glm(penguins_modelling)),

  tar_target(augmented_penguins,
             augment(penguins_glm, type.predict = "response")),

  tar_quarto(explore, "eda/explore.qmd")

)
