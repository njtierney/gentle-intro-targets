library(tidyverse)
library(palmerpenguins)
library(visdat)

penguins
View(penguins)

vis_dat(penguins)
vis_miss(penguins)

library(colorspace)
ggplot(penguins,
       aes(x = bill_depth_mm,
           y = bill_length_mm,
           colour = sex)) +
  geom_point() +
  scale_colour_discrete_qualitative() +
  facet_wrap(~species)

# prepare data for modelling
penguins_modelling <- penguins |>
  drop_na() |>
  mutate(
    is_female = if_else(sex == "female",
                        true = 1,
                        false = 0),
    .after = island
  )

penguins_modelling

penguins_glm <- glm(
  formula = is_female ~ bill_depth_mm + bill_length_mm,
  data = penguins_modelling,
  family = stats::binomial
)

penguins_glm

library(broom)
penguins_glm_augment <- augment(penguins_glm, type.predict = "response")

ggplot(penguins_glm_augment,
       aes(x = .resid)) +
  geom_histogram(binwidth = 0.25,
                 colour = "white")

ggplot(penguins_glm_augment,
       aes(x = bill_depth_mm,
           y = .fitted)) +
  geom_point()

ggplot(penguins_glm_augment,
       aes(x = bill_length_mm,
           y = .fitted)) +
  geom_point()

ggplot(penguins_glm_augment,
       aes(x = bill_length_mm,
           y = .resid)) +
  geom_point()

ggplot(penguins_glm_augment,
       aes(x = bill_depth_mm,
           y = .resid)) +
  geom_point()


ggplot(penguins_glm_augment,
       aes(x = bill_depth_mm,
           y = bill_length_mm,
           fill = .fitted)) +
  geom_tile()

penguin_grid <- expand_grid(
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
)

penguin_grid_predictions <- penguin_grid |>
  mutate(
    .fitted = predict(penguins_glm, newdata = penguin_grid, type = "response"),
    .before = everything()
  )

penguin_grid_predictions

ggplot(penguin_grid_predictions,
       aes(x = bill_length_mm,
           y = bill_depth_mm,
           fill = .fitted)) +
  geom_tile() +
  scale_fill_continuous_sequential(
    limits = c(0,1),
    name = "Pr(Female)"
  ) +
  coord_equal()
