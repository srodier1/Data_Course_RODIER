#str_split("//.") This function will split a vector based on a period followed by a space.
#str_split". ") This will split a vector based on any space. "." means one of anything that follows. 
#So the "//" means take whatever follows literally

fruits <- c(
  "apples and oranges and pears and bananas",
  "pineapples and mangos and guavas")
str_split(fruits, " and ", n = 4)


df %>% 
  str_split