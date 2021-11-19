install.packages("easystats", repos = "https://easystats.r-universe.dev")
install.packages("modelr")

library(tidyverse)
library(modelr)
library(easystats)

mpg %>%
  glimpse()
#there is an outcome and there is predictors. 

mod1 <- glm(data = mpg,     # this data set is taking audi as a baseline because it starts with an 'a'
    formula = hwy ~ manufacturer +  displ)
mod1 
mod2 <- glm(data = mpg,     
            formula = hwy ~ manufacturer *  displ)  #has a * instead of plus
mod2    # '*' looks at the interaction of the two variables. Can chevy make a different mpg car with similar sized displ

mpg %>%
  gather_predictions(mod1,mod2) %>%
  ggplot(aes(x = displ, y = pred, color = manufacturer)) +
  geom_smooth( method = "lm", se = FALSE) +
  facet_wrap(~model)
# this graph is a visual representation of the difference between '+' and '*' in formula
# '*' allows slope to be different

performance::model_performance(mod1)
performance::model_performance(mod2)
#RMSE is how far actual hwy is from predicted hwy based off of our variables. good model has lower RMSE
# percent variation that our variables used explain. How much better our model is at predicting than just the average. good model has higher R


sink("../Data_Course_RODIER/report_mod1") #creates a file and says everything below i want in that file
report(mod1)
sink(NULL) # this says STOP to above sink()


library(broom)
df <- tidy(mod1)
df %>%
  glimpse()

df <- df %>%
  filter(p.value < 0.05) %>%
  mutate(term = str_remove_all(term, "manufacturer"))
#ctrl alt b reruns everything above
#str_remove_all(from what column?, "what do you want to take out")

mpg %>%
  glimpse()
mod3 <- glm(data = mpg,
            hwy ~ trans:displ*cyl )
summary(mod3)
tidy(mod3)
performance::model_performance(mod3)
library(MASS)

mod4 <- glm( data = mpg,
             formula = hwy ~ manufacturer * cyl * displ)
library(MASS)
stepAIC(mod4)

model_performance(mod4)

mpg %>%
  gather_predictions(mod1,mod2,mod3,mod4) %>%
  ggplot(aes(x = displ, y = pred, color = manufacturer)) +
  geom_smooth( method = "lm", se = FALSE) +
  facet_wrap(~model)
