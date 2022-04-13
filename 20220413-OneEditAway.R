# DataInterviewQs 
# 4/13/2022

#### prompt ----

# Write a function to return a boolean that indicates if two strings are one edit away from being identical. 
# The function should take in 2 strings and return a boolean. 
# The definition of an "edit" is as follows:
  # Insert one character
  # Remove one character
  # Replace one character

# A few examples of inputs and the function result are listed below.

# OneEditAway("pea", "peas") = True
# OneEditAway("pea", "fleas") = False
# OneEditAway("pea", "lea") = True
# OneEditAway("pea", "seas") = False

#### solution ---- 

library(vecsets)

# define the function
OneEditAway <- function(a, b){
  
  # convert inputs to character and lower case
  a <- tolower(as.character(a))
  b <- tolower(as.character(b))
  
  # vectors of individual characters in each input string
  a_chars <- unlist(strsplit(a, split = ''))
  b_chars <- unlist(strsplit(b, split = ''))
  
  # vectors of characters in a but not b, and in b but not a
  # using vecsets::vsetdiff() over base setdiff() because the former preserves non-unique elements
  a_not_b <- vsetdiff(a_chars, b_chars)
  b_not_a <- vsetdiff(b_chars, a_chars)
  
  # if there is one or less element in a not b AND one or less element in b not a, a and b are one edit away so we return TRUE, o.w. we return FALSE
  if (length(a_not_b) <= 1 & length(b_not_a) <= 1){
    return(TRUE)
  } else {
    return(FALSE)
  }
  
}

# test the function
OneEditAway('pea', 'peas')  # TRUE
OneEditAway('pea', 'fleas') # FALSE
OneEditAway('pea', 'lea')   # TRUE
OneEditAway('pea', 'seas')  # FALSE


