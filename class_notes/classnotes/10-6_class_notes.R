library(dplyr)
set.seed(123)  #I don't understand 
male <- rnorm(100,3, .05) #rnorm creates a random set of numbers that fit within a normal distrubution OR bell curve
#rnorn( num of values, mean, st. dev)
hist(male)
female <- rnorm(100,3.1,.5)
hist(female)

df <- data.frame(male,female) ##data.frame creates a new data from from existing vectors. 
                                #
df <- df %>%    #in order to overwrite original data frame, resave it as itself
  pivot_longer(c("male", "female"), names_to = "sex", values_to = "GPA") 

?t.test  ## determines if the results are statistically significant
#t.test(numeric vector, another numeric vector(optional))
t.test(male, female)
# the smaller the p-value means how likely that your results are not a freak accident. 
#the lower the p value, the more likely that it is close to the actual TRUTH
#p value of .05 is 5% chance that we are seeing a pattern that doesn't exist. 
#p value is the chance that we are seeing a tiger that isn't there
?glm

mod <- glm(formula = GPA ~ sex + major,   #gpa ~ sex = is gpa a function of sex? will sex or major have some influence/predicting power on gpa?
    data = df)%>%
summary(mod)
#what does GLM - generalized linear model - tell us?
#deviance residual = it made another histogram that showed each values deviation from the mean
#this tells us the spread of our data
#intercept - is the average GPA of everyone regardless of sex


mod.aov <- aov(formula = GPA ~ sex + major,   #gpa ~ sex = is gpa a function of sex? will sex or major have some influence/predicting power on gpa?
               data = df)
  summary(mod.aov)
  df$major <- c(rep("science",100), rep("art",100))

df %>%
  group_by(sex)%>%
  summarize(meanGPA = mean(GPA))%>%
  ggplot(aes(x = sex, y =meanGPA)) +
  geom_bar(stat = "identity")
## these plots don't show that our data is statistically significant, so now we actually need to do stats


#What if i want to figure out how much predicting power a variable(sex) has on our result(GPA)?
#r^2 value and AIC value (smaller is better)


iris <- iris

  glm(data = iris, formula = Sepal.Length ~ Sepal.Width + Petal.Length + Petal.Width + Species)%>%
    summary()
