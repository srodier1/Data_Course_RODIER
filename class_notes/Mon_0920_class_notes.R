library(tidyverse)
library(palmerpenguins)
library (patchwork)
list.files("Data", pattern = "prac")
df1 <- read.csv("Data/practice_data_1.csv") 
df2 <- read.csv("Data/practice_data_2.csv")
df3 <- read.csv("Data/practice_data_3.csv")
df1 %>%
  ggplot(aes( x = x , y=y, z=z)

         
df2 %>%
  ggplot(aes(x=x, y=y, color =group)) +
         geom_point()+
           geom_smooth(method="lm")
summary_of_df3 <- df3 %>%
  group_by(dataset) %>%
  summarize(N=n(), 
            mean_X=mean(x),
            mean_Y=mean(y),
            stdDev_x = sd(x),  ## the summarize() function is completely different from
            stdDev_y = sd(y),   ## the summary() function. With summarize, you need to tell
            median_x = median(x),   ## it exactly what you want it to do. you manually create the columns. 
            median_y = median(y),
            correlationxy = cor(x,y))

df3 %>%
  ggplot(aes(x=x,y=y, color=dataset)) +
  geom_point()+
  facet_wrap(~dataset)
  ## '~' means as a function of..
  ## facet_wrap(~<insert a variable>)
       ## above I made my facets, the datasets and it seperated the points based off of 
        ## their value in 'dataset'

df <- (penguins)
glimpse(df)
df %>%
  filter(!is.na(sex)) %>%     ##is.na() is a function that creates a logical value from a variable in a data set. Everytime it sees NA it give it a TRUE value and will filter it. Since we put '!' we select everything that is not NA
  ggplot(aes(x=sex, y=body_mass_g, fill = species)) +   ##fill is better than color for boxplots. color just does outline color with boxplots and its not as good
         geom_boxplot() +
  facet_wrap(~island)



df %>%
  mutate( product = bill_length_mm * bill_depth_mm) %>%
  ggplot(aes(x=product, y=body_mass_g, color = species)) + 
  geom_point() +
  geom_smooth(method = "lm") ## 'lm' means linear model, giving us a straight line


p1 <- df %>%
  ggplot(aes(x=bill_length_mm, fill = species)) +  ## we can also graph distributions of values!
  geom_density(alpha = .5)  ##alpha argument allows transparency. a value of 1 is not transparent. 0 is invisible. 


p2 <- df %>%
  mutate( product = bill_length_mm * bill_depth_mm) %>%
  ggplot(aes(x=product, fill = species)) + 
  geom_density(alpha = .4) 

library(GGally)
ggpairs1 <- ggpairs(df)  ##ggpairs() shows all possible relationships. it just makes all of the graphs


df %>%
  select(species, bill_length_mm, island) %>%   ## I need to be careful with selecting certain values to select because I can see false relationships
  ggpairs()

p1 + p2 ## with the library(patchwork) it allows you to patch graphs together. 

## by Wednesday I need to play with penguins. make a bunch of different graphs. show color, shape, line type 
