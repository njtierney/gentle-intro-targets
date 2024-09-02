
# A gentle guide to using the {targets} package for analytic pipelines

<!-- badges: start -->
<!-- badges: end -->

# Abstract

Data analysis is an iterative process. Data cleaning, exploratory data analysis (EDA), and model fitting are rarely run without a hitch from start to finish. Each step takes time, and often requires revisiting earlier steps to correct for newly discovered problems. For example, in performing EDA, you can unearth a text issue that requires revisiting data cleaning. When you are finally done with the analysis, you will need to reproduce it to check it all works as expected.

To reproduce the analysis, there is a temptation to run the code again from the top, which may take a long time. You can save time by saving model outputs, but if you make a change to an earlier data cleaning step, you’ll need to update everything that depends on that. You can write code to manage these dependencies, but this is a hard problem. Fortunately, "pipeline tools" are an existing approach to manage these dependencies. They take care of the details of watching which files and relevant code changes, and only run the necessary parts. The {targets} R package is one popular pipeline approach, providing extensive documentation and user support. However, it presents a different coding practice that might not be familiar.  

In this interactive walkthrough, I will gently introduce the ideas behind {targets}, and will live code a data analysis using {targets} from scratch, warts and all. I encourage questions throughout the live coding walkthrough, so you can understand the process and see how this could benefit your own work.

I have three goals in this walkthrough:

1. To convince you {targets} is worth learning, and that you can use it
2. For you to be able to start using {targets} after 45 minutes
3. For you to feel more confident writing functions

# Prerequisites

> Describe the required skills or knowledge for an attendee to engage with your submission.
Have you considered how accessible your session will be to a diverse conference audience (attendees comprise people from academia, industry, charity and government, from beginners to experts)? 
For accepted submissions, these details will appear in the programme.


To get the most out of this walkthrough, users should have experience with the R programming language, and packages like quarto, rmarkdown, the tidyverse tools, and some experience writing R functions.

# Outcomes
> How will your attendees benefit from your session? What are the expected outcomes?
For accepted submissions, these details will appear in the programme.

After attending this session you will have an overview of how to use pipeline tools like {targets} in your data analysis. You will understand how to write functions that work in a pipeline, and also understand how to approach problems in a pipeline by debugging. 

# Accessibility

> Please comment on how you will ensure your content is accessible, which may include referring to relevant sections of the conference’s accessibility guidance, as well as any other considerations such as considered the contract of colours, and the shape and size of graphics and fonts. You can also use automated accessibility checking tools to help.

I will ensure content is accessible by using large legible fonts, as well as only using colour scales that are suitable for people with colour vision deficiencies. Any slides presented will be served using HTML, which is more accessible than PDF slides, and images will have alternative text. My slides will be served online through github, where the code to produce the slides can be downloaded and reproduced. Slides will be under a CC-BY 4 License, and will have my contact information on them. The code produced during the live coding will be preserved on github, where successive changes will be logged as separate git commits. This will help capture the process of the live coding so it can be understood later by those who could not attend.

# Delivery Plan for a Hybrid Audience

> How will you ensure that both remote and in-person participants have a comparable experience? Is there anything that might pose a challenge to streaming your proposal? 
We appreciate that you may not have fully-formed answers to these questions at this stage, but your responses will enable the organisers to support you in delivering a successful presentation.

The talk materials will be linked during the presentation, so users can view the material later and locally if they want to follow along. In the case that there are issues with presenting online these materials mean that people following along online can at least see the slides and notes. The code produced during the live coding will be preserved on github, where successive changes will be logged as separate git commits. This will help capture the process of the live coding so it can be understood later by those who could not attend.
