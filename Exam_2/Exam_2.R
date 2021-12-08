library(dplyr)
library(ggplot2)
library(tidyverse)
library(zoo)
options(scipen = 999)

#I.      Load the landdata-states.csv file into R
#Re-create the graph shown in "fig1.png"
#Export it to your Exam_2 folder as LASTNAME_Fig_1.jpg (note, that's a jpg, not a png)
#To change the y-axis values to plain numeric, add options(scipen = 999) to your script

land_data <- read.csv("landdata-states.csv")

ggplot(land_data, aes(x = Date, y = Land.Value, color = region)) + 
  geom_smooth() +
  xlab(element_text("Year"))+
  ylab(element_text("Land Value(USD)"))
  
#II.    What is "NA Region???"
#Write some code to show which state(s) are found in the "NA" region

filter(land_data, is.na(land_data$region))

#III.    The rest of the test uses another data set. The unicef-u5mr.csv data. 
#Get it loaded and take a look.
#It's not exactly tidy. You had better tidy it!

unicef <- read.csv("unicef-u5mr.csv" )
unicef <- unicef %>%
  pivot_longer(cols = starts_with("U5MR."),  names_prefix = "U5MR.",
                 names_to = "Year", names_transform = list(Year = as.integer),
               values_to = "U5MR")

#IV.     Re-create the graph shown in fig2.png
#Export it to your Exam_2 folder as LASTNAME_Fig_2.jpg (note, that's a jpg, not a png)

unicef %>% 
  ggplot(aes(x = Year, y = U5MR, color = Continent )) +
  geom_point(size = 2)+
  ylab(element_text("Mortality Rate")) +
  theme(panel.grid.major = element_blank())



#IV.     Re-create the graph shown in fig3.png
#Note: This is a line graph of average mortality rate over time for each continent 
#(i.e., all countries in each continent, yearly average), this is NOT a geom_smooth() 
#Export it to your Exam_2 folder as LASTNAME_Fig_3.jpg (note, that's a jpg, not a png)

unicef %>%
  group_by(Continent, Year) %>%
  na.omit() %>%
  summarize("mean_mortality"= mean(U5MR)) %>%
  ggplot( aes(x = Year, y = mean_mortality, color = Continent)) +
  geom_line(size = 3) +
  ylab( element_text("Mean Mortality Rate (deaths per 1000 live births)"))  

#V.      Re-create the graph shown in fig4.png
#Note: The y-axis shows proportions, not raw numbers
#This is a scatterplot, faceted by region
#Export it to your Exam_2 folder as LASTNAME_Fig_3.jpg (note, that's a jpg, not a png)
unicef %>%
  mutate("proportion" = U5MR / 1000) %>%
  ggplot(aes(x = Year, y = proportion ))+
  geom_point(colour = "blue") +
  facet_wrap(~Region)+
  ylab("Mortality Rate")

