## Load your packages, e.g. library(targets).
source("./packages.R")

## Load your R files
lapply(list.files("./R", full.names = TRUE), source)

tar_option_set(
  workspace_on_error = TRUE
)

## tar_plan supports drake-style targets and also tar_target()
tar_plan(

  # read in the data
  penguins_modelling = prepare_penguins(),

  # modelling
  fitted_glm = fit_glm(penguins_modelling),

  model_augment = augment(fitted_glm, type.predict = "response"),

  data_grid = create_data_grid(penguins_modelling),

  prediction_grid = add_predictions(data_grid, fitted_glm),

  plot_prediction_grid = gg_prediction_grid(prediction_grid),

  # report
  tar_quarto(explore, "doc/explore.qmd")

)
