source("packages.R")

tar_source()

list(

  tar_target(penguins_vismiss,
             vis_miss(penguins)),

  tar_target(penguins_modelling,
             prepare_penguins()),

  tar_target(eda_bills,
             plot_bills(penguins_modelling)),

  tar_target(penguin_glm,
             fit_glm(penguins_modelling)),

  tar_target(penguin_glm_augment,
             augment(penguin_glm, type.predict = "response")),

  tar_target(penguin_grid,
             create_grid(penguins_modelling)),

  tar_target(penguin_grid_pred,
             add_predictions(penguin_grid, penguin_glm)),

  tar_target(plot_penguin_grid,
             gg_penguin_grid(penguin_grid_pred)),

  tar_quarto(explore, "doc/explore.qmd")

)
