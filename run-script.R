# What are we doing?

# Three goals for today

## 1. Understand some inherent problems with managing data analyses
## 2. To convince you that {targets} is worth learning to solve some of these problems
## 3. Use {targets} after these 42 minutes.

## Let's do some data analysis!
library(tidyverse)
library(palmerpenguins)
library(visdat)

## Explore the data
vis_dat(penguins)
vis_miss(penguins)

ggplot(penguins,
       aes(x = bill_length_mm,
           y = bill_depth_mm,
           colour = sex)) +
  geom_point() +
  facet_wrap(~species) +
  scale_colour_brewer(palette = "Dark2")

## Fit a model
## Prepare the data
penguins_modelling <- penguins |>
  # remove missing value records
  drop_na() |>
  mutate(
    # code the sex as per a Bernoulli distribution
    is_female_numeric = if_else(sex == "female", 1, 0),
    .after = island
  )

# model exploration
fitted_model <- glm(
  is_female_numeric ~ bill_depth_mm + bill_length_mm,
  data = penguins_modelling,
  family = stats::binomial
)

fitted_model
summary(fitted_model)

library(broom)
fitted_model_aug <- augment(fitted_model, type.predict = "response")
fitted_model_aug

ggplot(fitted_model_aug,
       aes(x = bill_depth_mm,
           y = .fitted)) +
  geom_point()

ggplot(fitted_model_aug,
       aes(x = bill_length_mm,
           y = .fitted)) +
  geom_point()

ggplot(fitted_model_aug,
       aes(x = bill_length_mm,
           y = bill_depth_mm,
           fill = .fitted)) +
  geom_raster()

prediction_grid <- expand_grid(
  bill_depth_mm = seq(
    min(penguins_modelling$bill_depth_mm),
    max(penguins_modelling$bill_depth_mm),
    length.out = 50
  ),
  bill_length_mm = seq(
    min(penguins_modelling$bill_length_mm),
    max(penguins_modelling$bill_length_mm),
    length.out = 50
  )
) |>
  mutate(
    .fitted = predict(fitted_model,
                      newdata = prediction_grid,
                      type = "response"),
    .before = everything()
  )

ggplot(prediction_grid,
       aes(x = bill_length_mm,
           y = bill_depth_mm,
           fill = .fitted)) +
  geom_raster() +
  colorspace::scale_fill_continuous_sequential(
    limits = c(0, 1),
    name = "Pr(Female)"
  ) +
  coord_equal()

# Questions to audience
## What problems might come up in this data analysis?
## What should we do from here?
## Problems with putting this into a quarto/rmd document

# Some key tooling to demonstrate
## Using tflow
## Functions with fnmate
## Writing from top down
## How to load individual targets
  ## Using keyboard shortcuts
## How to load packages/dependencies
##
