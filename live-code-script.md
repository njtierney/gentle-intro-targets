Process: remember to add commits for each phase, to log the process

Phase 1

- load packages
- explore penguins
- explore missing data
- plot bill length
- "What questions do you have?"

```r
library(tidyverse)
library(palmerpenguins)
library(visdat)

penguins

vis_miss(penguins)

ggplot(penguins,
       aes(x = bill_length_mm,
           y = bill_depth_mm,
           colour = sex)) +
  geom_point()
```

Next phase

- add colorspace package
- plot new colours
- add `na.value`
- add facetting
- "What questions do you have?"

```r
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
  scale_colour_discrete_qualitative(
    na.value = "black"
  ) +
  facet_wrap(~species)

```

Phase 3: model fitting

- simple model
- logistic regression
- use `sex` variable
	- Ah! But `sex` is male/female, which is which?
- use predict to check
	- values are on wrong scale
	- use `type = "response"`
- use broom to add residuals etc
- use ggplot to explore sex vs .fitted
	- use geom_point()
	- then use geom_boxplot()
- Ah, but in the paper they actually have female values as 1, males as 0, so let's do that
- "What questions do you have?"

```r
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
  scale_colour_discrete_qualitative(
    na.value = "black"
  ) +
  facet_wrap(~species)

penguins_glm <- glm(
  formula = sex ~ bill_length_mm + bill_depth_mm,
  # so we do logistic regression
  family = stats::binomial,
  data = penguins
)

summary(predict(penguins_glm, type = "response"))

library(broom)
augmented_penguins <- augment(penguins_glm, type.predict = "response")

ggplot(augmented_penguins,
       aes(x = sex,
           y = .fitted)) +
  geom_boxplot()


```

Phase 4

- So now we need to update our data, I can do that here in place.
- But then I also want to repeat this code
- So I think I'll update this
- add `is_female`
	- demo using .before/.after
- "What questions do you have?"

```r
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
  scale_colour_discrete_qualitative(
    na.value = "black"
  ) +
  facet_wrap(~species)

penguins_glm <- glm(
  formula = sex ~ bill_length_mm + bill_depth_mm,
  # so we do logistic regression
  family = stats::binomial,
  data = penguins
)

summary(predict(penguins_glm, type = "response"))

library(broom)
augmented_penguins <- augment(penguins_glm, type.predict = "response")

ggplot(augmented_penguins,
       aes(x = sex,
           y = .fitted)) +
  geom_boxplot()

penguins_modelling <- penguins |>
  mutate(
    is_female = if_else(sex == "female",
                        true = 1,
                        false = 0),
    .before = year
  )

```

Phase 5
- Move penguins up to the top
- rename / update data downstream
- ...now we need to run it all again to make sure it's updated?
- make sure to update `is_female` variable in the code
- "What questions do you have?"

```r
library(tidyverse)
library(palmerpenguins)
library(visdat)
library(colorspace)

penguins

penguins_modelling <- penguins |>
  mutate(
    is_female = if_else(sex == "female",
                        true = 1,
                        false = 0),
    .before = year
  )

vis_miss(penguins)

ggplot(penguins_modelling,
       aes(x = bill_length_mm,
           y = bill_depth_mm,
           colour = sex)) +
  geom_point() +
  scale_colour_discrete_qualitative(
    na.value = "black"
  ) +
  facet_wrap(~species)

penguins_glm <- glm(
  formula = is_female ~ bill_length_mm + bill_depth_mm,
  # so we do logistic regression
  family = stats::binomial,
  data = penguins_modelling
)

summary(predict(penguins_glm, type = "response"))

library(broom)
augmented_penguins <- augment(penguins_glm, type.predict = "response")

ggplot(augmented_penguins,
       aes(x = factor(is_female),
           y = .fitted)) +
  geom_boxplot()

```

Phase 6: Change this to targets

- Introduce targets as a way to help manage tracking dependencies etc
- let's start!
1. Rename file `_targets`
2. make a `list()`
3. move `library` calls to the top
4. wrap things in `tar_target`
5. add commas
"What questions do you have?"

```r
library(tidyverse)
library(palmerpenguins)
library(visdat)
library(colorspace)
library(broom)
library(targets)

list(

  tar_target(penguins_modelling,
             penguins |>
               mutate(
                 is_female = if_else(sex == "female",
                                     true = 1,
                                     false = 0),
                 .before = year
               )),

  tar_target(penguins_vismiss, vis_miss(penguins)),

  tar_target(plot_bills,
             ggplot(penguins_modelling,
                    aes(x = bill_length_mm,
                        y = bill_depth_mm,
                        colour = sex)) +
               geom_point() +
               scale_colour_discrete_qualitative(
                 na.value = "black"
               ) +
               facet_wrap(~species)
  ),

  tar_target(penguins_glm,
             glm(
               formula = is_female ~ bill_length_mm + bill_depth_mm,
               # so we do logistic regression
               family = stats::binomial,
               data = penguins_modelling
             )),

  tar_target(augmented_penguins,
             augment(penguins_glm, type.predict = "response"))

)

```

Phase 7: using tar_load and tar_read to understand what the workflow is

- using tar_visnetwork
- using tar_make() - do it twice to demonstrate the timing
- Using tar_load() and tar_read()
- Using keyboard shortcuts to make and load individual targets
- Demonstrate the targets becoming inactive/invalid - due to changes in the code.
- "What questions do you have?"

```r
# code stays the same, this is a part about exploring/interacting with targets
# make
```

Phase 8: improving abstraction

- Using {fnmate}
- Using the same function arguments as what is used inside
- run `tar_make()`
- get a failure because we need to source all the R functions

```r
library(tidyverse)
library(palmerpenguins)
library(visdat)
library(colorspace)
library(broom)
library(targets)

list(

  tar_target(penguins_modelling,
             prepare_penguins()),

  tar_target(penguins_vismiss, vis_miss(penguins)),

  tar_target(plot_bills,
             gg_bills(penguins_modelling)),

  tar_target(penguins_glm, fit_glm(penguins_modelling))),

  tar_target(augmented_penguins,
             augment(penguins_glm, type.predict = "response"))

)

```

Phase 9:  introduce creating a quarto document as a scratchpad

- `tar_source()`
- Introduce `tarchetypes`
- Add `tar_quarto()`
- Add quarto document
- Introduce using `tar_load()` inside  a quarto document

```r
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

  tar_quarto(scratch, path = "eda/scratch.qmd")

)

```

The quarto document

````quarto
---
title: "scratch"
format: html
---

```{r}
library(targets)
tar_load(
  c(
    penguins_modelling,
    penguins_glm,
    augmented_penguins
  )
)
```
````

Phase 10: Explore the models and inspire creating a grid of predictions

````quarto

# Explore models

```{r}
ggplot(augmented_penguins,
       aes(x = bill_length_mm,
           y = .fitted)) +
  geom_point()

ggplot(augmented_penguins,
       aes(x = bill_length_mm,
           y = bill_depth_mm,
           colour = .fitted)) +
  geom_point()
```

Can we make this a grid?...

````

Phase 11: Making a grid of values

* demonstrate `expand_grid`
* demonstrate an issue with finding NA values!
* Update `penguins_modelling` with `drop_na`

```r
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
               penguins_modelling
               )
             )

)

```

prediction_grid.R

```r
#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param penguins_glm
#' @param penguins_modelling
#' @return
#' @author njtierney
#' @export
prediction_grid <- function(penguins_glm, penguins_modelling) {

  # create the grid
  data_grid <- expand_grid(
    bill_depth_mm = seq(
      min(penguins_modelling$bill_depth_mm),
      max(penguins_modelling$bill_depth_mm),
      length.out = 25
  ),
  bill_length_mm = seq(
    min(penguins_modelling$bill_length_mm),
    max(penguins_modelling$bill_length_mm),
    length.out = 25
  )
  )

  data_grid |>
    mutate(
      .fitted = predict(object = penguins_glm,
                        newdata = data_grid,
                        type = "response")
    )

}

```

Phase 12: Plotting the values

- make the plot in the quarto document
- move the plot to a function
- consider adding / changing the parameter for the plot grid size

```r
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

```

prediction grid

```r
#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param penguins_glm
#' @param penguins_modelling
#' @return
#' @author njtierney
#' @export
prediction_grid <- function(penguins_glm, penguins_modelling,
                            grid_size = 25) {

  # create the grid
  data_grid <- expand_grid(
    bill_depth_mm = seq(
      min(penguins_modelling$bill_depth_mm),
      max(penguins_modelling$bill_depth_mm),
      length.out = grid_size
  ),
  bill_length_mm = seq(
    min(penguins_modelling$bill_length_mm),
    max(penguins_modelling$bill_length_mm),
    length.out = grid_size
  )
  )

  data_grid |>
    mutate(
      .fitted = predict(object = penguins_glm,
                        newdata = data_grid,
                        type = "response")
    )

}

```
