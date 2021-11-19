library(tidyverse)
library(janitor)
library(dplyr)

df <- read.csv("FacultySalaries_1995.csv")

#make clean names
df$UnivName <- make_clean_names(df$UnivName)
names(df)




df <- df %>%
  rename("AvgFullProf_Salary"="AvgFullProfSalary",
         "AvgAssocProf_Salary"  ="AvgAssocProfSalary",
         "AvgAssistProf_Salary"= "AvgAssistProfSalary",
         "AvgProf_SalaryAll" ="AvgProfSalaryAll",
         "AvgFullProf_Comp"="AvgFullProfComp",
         "AvgAssocProf_Comp" ="AvgAssocProfComp",
         "AvgAssistProf_Comp"="AvgAssistProfComp",
         "AvgProf_CompAll"="AvgProfCompAll",
         "NumFullProf"="NumFullProfs",
         "NumAssocProf"="NumAssocProfs",
         "NumAssistProf"="NumAssistProfs",
         "NumInstructor"="NumInstructors")



df <-  df %>%
  pivot_longer(cols = 5:17,
               names_to = "Position",
               values_to = "Vales")


df[,6] <- as.character(df[,6])
df[,5:6] <- paste0(c(df[,5:6]), 
       sep = "_")


df <- pivot_longer(df, 
                   cols = c("AvgFullProf_Salary","AvgAssocProf_Salary",
                            "AvgAssistProf_Salary", "AvgProf_SalaryAll",
                            "AvgFullProf_Comp",  "AvgAssocProf_Comp",
                            "AvgAssistProf_Comp","AvgProf_CompAll"),
                   names_to = c("Position", "SalaryComp"),
                   names_sep = "_",
                   names_prefix = "Avg",
                  values_to = "Pay")

df <- df %>%
  pivot_wider(names_from = "SalaryComp",
              values_from = "Pay")

names(df)
df <-pivot_longer(data = df,
                cols = c("NumFullProf", "NumAssocProf",
                         "NumAssistProf","NumInstructor",
                         "NumFacultyAll"),
               names_prefix = "Num",
               names_to = "Position123",
               values_to = "Number")


               




