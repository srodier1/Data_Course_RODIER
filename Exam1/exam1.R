library(tidyverse)
library(dplyr)
library(ggplot2)
library(patchwork)
df <- read.csv("BIOL3100_Exams/Exam_1/cleaned_covid_data.csv")
 df[grepl("^A", df$Province_State),] ##grepl() is a good way to search for a pattern. 
"A-states" <- df %>%                #grepl(pattern= "what you're looking for", x = dataset)
  filter(Province_State %in% c("Alabama", "Arkansas", "Arizona", "Alaska"))

`A-states` %>%
  mutate(nw = floor(Active)/ 1000) %>%
  ggplot(aes(x=Last_Update, y = nw)) +
  geom_point() +
  geom_smooth(se = FALSE )+
  facet_wrap(~Province_State, scales = "free")+
  labs(x="Time",
       y="Active Cases",
       title = "Active Cases (2020-2021)")  +
  theme_minimal()

## I really think this looks better for scale sake ####
AK <- `A-states` %>%
  filter(Province_State == "Alaska") %>%
  mutate(nw = floor(Active)/ 1000) %>%
  ggplot(aes(x=Last_Update, y = nw)) +
  geom_point() +
  geom_smooth(method ="loess" )+
  labs(x="Time",
       y="Active Cases(in thousands)",
       title = "Active Cases in Alaska (2020-2021)")  +
  theme_minimal()

 AZ <- `A-states` %>%
  filter(Province_State == "Arizona") %>%
  mutate(zona = floor(Active)/ 1000) %>%
  ggplot(aes(x=Last_Update, y = zona)) +
  geom_point() +
  geom_smooth(method ="loess" )+
  labs(x="Time",
       y="Active Cases (in thousands)",
       title = "Active Cases in Arizona(2020-2021)")  +
  theme_minimal()
 AR <- `A-states` %>%
   filter(Province_State == "Arkansas") %>%
   mutate(ark = floor(Active)/ 1000) %>%
   ggplot(aes(x=Last_Update, y = ark)) +
   geom_point() +
   geom_smooth(method ="loess" )+
   labs(x="Time",
        y="Active Cases(in thousands)",
        title = "Active Cases in Arkansas(2020-2021)")  +
   theme_minimal()
 
 AL <- `A-states` %>%
   filter(Province_State == "Alabama") %>%
   mutate(bama = floor(Active)/ 1000) %>%
   ggplot(aes(x=Last_Update, y = bama)) +
   geom_point() +
   geom_smooth(method ="loess")+
   labs(x="Time",
        y="Active Cases(in thousands)",
        title = "Active Cases in Alabama(2020-2021)")  +
   theme_minimal()

 (AZ | AK)/(AR | AL) #this is better than 'facet_wrap' because it shows the scale better. Or I just don't know how to use theme well enough
####
 
state_max_fatality_rate <-  `A-states` %>%
   group_by(Province_State)%>%
   summarize(max(Case_Fatality_Ratio, na.rm = TRUE))%>%
  rename(max_cfr = "max(Case_Fatality_Ratio, na.rm = TRUE)")%>%
   print()





state_max_fatality_rate %>%
  arrange(desc(Province_State[1:4]),.by_group = TRUE)%>%
  ggplot(aes(x = Province_State, y = max_cfr))+
  geom_col()
 ## next exam I' m going to record the issues that I run into so that I can really learn from them. 