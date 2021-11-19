library(tidyverse)
library(dplyr)
library(palmerpenguins)
df <- penguins
df %>%
  mutate(body_mass_kg_rounded = round(body_mass_g/1000,0),
         body_mass_kg = body_mass_g/1000) %>%
  select(body_mass_g, body_mass_kg_rounded, sex, body_mass_kg) %>%  #case_when is good for making Numeric stuff into a new column that is categorical
  mutate(chonky = case_when(body_mass_g > 4500 ~ "chonky", 
                                 TRUE ~ "not chonky")) %>%
           select(chonky,body_mass_g, everything()) %>%
  arrange(chonky, desc(body_mass_g)) %>%
  ggplot(aes(x =chonky, y = body_mass_g, color = sex)) +
    geom_point()

# look into ggplotly          
  