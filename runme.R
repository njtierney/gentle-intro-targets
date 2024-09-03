library(tidyverse)
library(palmerpenguins)
library(visdat)
library(colorspace)

penguins

penguins_modelling <- penguins |>
  mutate(
    is_female = if_else(sex == "female",
                        true = 1,
                        false = 0)
  )

vis_miss(penguins_modelling)

ggplot(penguins_modelling,
       aes(x = bill_length_mm,
           y = bill_depth_mm,
           colour = sex)) +
  geom_point() +
  facet_wrap(~species) +
  scale_colour_discrete_qualitative(
    na.value = "black"
  )

penguins_glm <- glm(
  formula = sex ~ bill_length_mm + bill_depth_mm,
  family = stats::binomial,
  data = penguins_modelling
)

penguins_glm

summary(predict(penguins_glm, type = "response"))

library(broom)
augmented_penguins <- augment(penguins_glm, type.predict = "response")

ggplot(augmented_penguins,
       aes(x = sex,
           y = .fitted)) +
  geom_boxplot()
