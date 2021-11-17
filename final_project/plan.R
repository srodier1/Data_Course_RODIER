library(tidyverse)
library(modelr)
df <- read.csv("merged_data.csv")
names(df)

#does an apple/day keep the doctor away?
  
  #what will an apple/day mean?
  #fruit consumed kgs/capita/year, cal from plnt protein, calories from animal protein, calories from fat
  
  #what does keep the doctor away mean? 
  #it can mean dalys, cancer prevalence, depressive disorders, life expectancy

  
  #I should get total cancer deaths as opposed to breaking it down to specific cancer deaths
names(df)

















mod1 <- glm(data = df,
    formula = life_expectancy ~ kg_apple_prod_capita_year*fruit_consumed_kg_pc_year*cal_frm_plnt_prot)
summary(mod1)

mod1 <- glm(data = df,
            formula = life_expectancy ~ fruit_consumed_kg_pc_year+kg_apple_prod_capita_year+cal_frm_plnt_prot)
summary(mod1)

p <- df %>%
  filter(year == 2000) %>% 
  ggplot(aes(x = cal_frm_plnt_prot, y = life_expectancy))+
  geom_point()
p

df %>%
  ggplot(aes(x = gdp_capita_year, y = life_expectancy))+
  geom_point()
modgdp_le <- glm(data = df,
                 formula = life_expectancy ~ gdp_capita_year)

summary(modgdp_le)
add_predictions(mod1, modgdp_le) %>%
  ggplot(aes(x = fruit_consumed_kg_pc_year, gdp_capita_year))+
  geom_boxplot()




library(plotly)
ggplotly(p)

library(MASS)
stepAIC(mod1)
  



