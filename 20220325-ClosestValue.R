# Data Interview Qs 
# 3/25/2022

#### prompt ----

# Suppose you are given a list of Q 1D points. 
# Write code to return the value in Q that is the closest to value j. 
# If two values are equally close to j, return the smaller value. 

#### solution ----

# define the function
ReturnClosestValue <- function(Q, j){
  
  # excpetion handling
  if (!is.atomic(Q) & !is.numeric(Q)) stop('Q must be a vector of numbers')
  if (!is.numeric(j)) stop('j must be a number')
  
  # vector of absolute value of the difference between each element of Q and j
  diffs <- abs(Q - j)
  
  # value(s) of Q that has/have the minimum absolute difference from j
  closest_vals <- Q[which(diffs == min(diffs))]
  
  # return the smallest of those values if there are multiple
  return(min(closest_vals))
  
}

# vector of numbers Q and value j
Q <- c(1, -1, -5, 2, 4, -2, 1)
j <- 3

ReturnClosestValue(Q, j)
