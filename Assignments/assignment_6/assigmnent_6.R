library(dplyr)
library(tidyverse)
library(ggplot2)
library(gganimate)
library(lubridate)
library(patchwork)

list.files("assignment_6", full.names = TRUE)
BioLog <- read.csv("assignment_6/BioLog_Plate_Data.csv")

BioLog <-BioLog %>%
  pivot_longer(cols = c("Hr_24", "Hr_48", "Hr_144"),
               names_to = "hour", 
               names_prefix = "Hr_",
               names_transform = list(hour = as.double),
               values_to = "Light_absorb")

BioLog <- BioLog %>%
  mutate(soil_or_water = case_when(Sample.ID == "Clear_Creek" ~ "water",
                                   Sample.ID == "Waste_Water" ~ "water",
                                   Sample.ID == "Soil_1" ~ "soil",
                                   Sample.ID == "Soil_2" ~ "soil",
                                   TRUE ~ as.character(Sample.ID))) 

BioLog %>%
  filter(Dilution == "0.1") %>%
  ggplot(aes(x = hour, y = Light_absorb, color = soil_or_water))+
  geom_smooth(se = FALSE) +
  facet_wrap("Substrate") +
        labs(color = "Type",
             x = "Time (hours)",
             y = "Absorbance") +
  ggtitle("Just Dilution 0.1")


BioLog <- BioLog %>%
  rename("hr" = "Time_hours")

p <- BioLog %>%
  filter(Substrate == "Itaconic Acid") %>%
  select(Sample.ID, Dilution, Substrate, hour, Rep, Light_absorb, seq_along(hour)) %>%
  group_by(Rep, Dilution, Sample.ID, hour) %>%
  summarize(mean_absorbance = mean(Light_absorb), hour, Sample.ID)%>% 
  ggplot(aes(x = hour, y = mean_absorbance, color = Sample.ID)) +
  geom_smooth(se = FALSE) +
  facet_wrap(~Dilution) 





class(BioLog$hour)
p + transition_reveal(hour)
p    
   
