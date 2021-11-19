#11/3

#making functions

library(tidyverse)
mpg

myfunction <- function(x){
  y<- as.character(x)
  return(y)
}

myfunction(mpg$displ)

apply(mpg, 2, myfunction)

#make every numeric column in mpg divide all values by 2
library(tidyverse)
mpg

div2 <- function(x){
  return(x/2)
}
mpg %>%
  mutate_if(is.numeric,div2)
#mutate_if ONLY USES COLUMNS
#mutate_if(data, true/false, function)

#OR

div_by_2 <- function(x){
  if(is.numeric(x)){
    y <- x/2
  }else{
    y=x
    return(y)
  }
  }
  }
}
library(purrr)

df <- read_csv("../../../Data_Course/Data/data-shell/names/timepoint_001/price_adjustment_001.csv")
 df %>%
  mutate(FirstName = str_split(ClientName, " ") %>% map_chr(1),
  LastName = str_split(ClientName, " ") %>% map_chr(2),
 FormattedName = paste0(LastName,", ", FirstName))
  




