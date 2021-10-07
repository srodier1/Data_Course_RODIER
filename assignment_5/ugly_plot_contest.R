library(tidyverse)
library(dplyr)
library(ggplot2)
library(ggimage)
mam <- read.csv("../Data_Course_RODIER/mammals.csv")

mam %>%
  ggplot(aes(x = species, y = total_sleep, color = predation)) +
  geom_point()+ 
  geom_smooth(method = "loess", se = TRUE) +
  geom_point(aes(y=non_dreaming)) +
  scale_y_continuous(name = "Dreaming sleep",
    sec.axis = sec_axis(trans~ ., name="Fuzziness")) +
  ggtitle("Why I'm tired in class today ")+
  theme(axis.text.x = element_text(face="bold", color="#993333", 
                                   size=7, angle=45),
        axis.text.y = element_text(face="bold", color="#993332", 
                                   size=14, angle=45),
        panel.background = element_rect(fill = "salmon2"),
        panel.grid.major.x = element_blank())
 
