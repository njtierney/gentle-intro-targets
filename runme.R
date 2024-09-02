library(tidyverse)
library(palmerpenguins)
library(visdat)
library(colorspace)

penguins

vis_miss(penguins)

ggplot(penguins,
       aes(x = bill_length_mm,
           y = bill_depth_mm,
           colour = sex)) +
  geom_point() +
  scale_colour_discrete_qualitative() +
  facet_wrap(~species)

penguin_glm <- glm(
  formula = sex ~ bill_length_mm + bill_depth_mm,
  # a logistic regression
  family = stats::binomial,
  data = penguins_modelling
)

library(broom)

penguin_glm_augment <- augment(penguin_glm, type.predict = "response")

ggplot(penguin_glm_augment,
       aes(x = sex,
           y = .fitted)) +
  geom_boxplot()
