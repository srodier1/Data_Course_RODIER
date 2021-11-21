library(tidyverse)
library(janitor)
library(dplyr)
install.packages(broom)
update.packages(broom)
library(broom)

#I. 

df <- read.csv("FacultySalaries_1995.csv")

#make clean names
df$UnivName <- make_clean_names(df$UnivName)
names(df)

#separate into separate data.frames by col (salary)
sal <- df[,c(2,5:8)]

sal <- sal %>%  
  pivot_longer(cols = 2:5,
               names_to = c("Position"),
               values_to = "AvgSalary")

  #clean position names

sal$Position <- gsub("Avg", "", sal$Position)
sal$Position <- gsub("Salary", "", sal$Position)

#separate into separate data.frames by col (comp)
comp <- df[,c(2,9:12)]

comp <- comp %>%  
  pivot_longer(cols = 2:5,
               names_to = c("Position"),
               values_to = "AvgComp")
  #clean position names
comp$Position <- gsub("Avg", "", comp$Position)
comp$Position <- gsub("Comp", "", comp$Position)


#separate into separate data.frames by col (num)

num <- df[,c(2,13:17)]

num <- num %>%  
  pivot_longer(cols = 2:6,
               names_to = c("Position"),
               values_to = "NumberEmployed")
  #clean position names
num$Position <- gsub("Num", "", num$Position)
unique(num$Position)
num$Position <- gsub("Profs", "Prof", num$Position )
num$Position <- gsub("rs", "r", num$Position)
#separate into diff data.frames by col (everything else)

ev_else <- df[,1:4]


#pull it all together

a <- full_join(ev_else, num)
b <- full_join(a, sal)
df2 <- full_join(b,comp)

unique(df2$Position)
# II. 

#recreate fig1 <-  salary by rank (Position) facet_wrap-ed by tier
unique(df2$Tier)
df2 %>% 
  filter(Tier %in% c("I", "IIA", "IIB")) %>% 
  filter(Position %in% c("FullProf", "AssocProf", "AssistProf")) %>% 
  ggplot(aes(x = Position, y = AvgSalary, fill = Position))+
  geom_boxplot()+
  facet_wrap(~Tier)+
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

#run anova test with aov function
names(df2)
mod1 <- aov(formula = AvgSalary ~ State + Tier + Position,
    data = df2)
tab <- summary(mod1)

x <- tidy(mod1)
write.table(x, "Salary_ANOVA_Summary.txt")

#III. Tidy 

df3 <- read.csv("Juniper_Oils.csv")


names(df3)
df3 <- df3 %>% 
  select("Tree_Species","YearsSinceBurn", "alpha.pinene","para.cymene","alpha.terpineol","cedr.9.ene","alpha.cedrene",
           "beta.cedrene","cis.thujopsene","alpha.himachalene","beta.chamigrene","cuparene",
           "compound.1","alpha.chamigrene","widdrol","cedrol","beta.acorenol","alpha.acorenol",
           "gamma.eudesmol","beta.eudesmol","alpha.eudesmol","cedr.8.en.13.ol","cedr.8.en.15.ol",
           "compound.2","thujopsenal")
df3 <- df3 %>% 
  pivot_longer(cols = 3:25,
               names_to = "Chemical",
               values_to = "ChemicalConcentration")


#IV. Make a graph

df3 %>% 
  ggplot(aes(x = YearsSinceBurn, y = ChemicalConcentration))+ 
  geom_smooth()+
  facet_wrap(~Chemical,
             scales = "free")

#V. model
names(df3)
mod2 <- glm(data = df3,
    formula = ChemicalConcentration ~ Chemical*YearsSinceBurn)
summary(mod2)
sum <- broom::tidy(mod2)
sum <- sum %>% 
  filter(p.value < .05)
  
  
  
  