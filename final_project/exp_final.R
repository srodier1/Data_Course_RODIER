library(tidyverse)
library(dplyr)
library(ggplot2)
getwd()
list.files("../final_project_data", full.names = TRUE)
sex.ratio <- read.csv("../final_project_data/sex-ratio-at-birth.csv")
# The sex ratio is how many males born for 100 females born
sex.ratio %>%
  rename(num.m.per.hndrd.f = Sex.ratio.at.birth..male.births.per.female.births. )

gdp_vs_happy <- read.csv("../final_project_data/gdp-vs-happiness.csv")
glimpse(gdp_vs_happy)

gdp_vs_happy%>%
  filter()
ggplot(aes(x=Year, y = Life.satisfaction.in.Cantril.Ladder..World.Happiness.Report.2021.))+
geom_point()+
  geom_line()
geom_point(sex.ratio, mapping = aes(x = Year, y = Sex.ratio.at.birth..male.births.per.female.births.))+
  scale_y_continuous(name = "happiness", sec.axis = sec_axis( trans=~.*10, name="# of males born per 100 females born")) +
  xlim(1962,2021)

gdp_vs_happy %>%
  filter(Entity == c( "Liberia", "Mexico")) %>%
  ggplot(aes(x = Year, y = Life.satisfaction.in.Cantril.Ladder..World.Happiness.Report.2021., color = Entity))+
  geom_line() +
  xlim(2007,2021)


conflicts()
unique(gdp_vs_happy$Entity)

rlang::last_error(
)
