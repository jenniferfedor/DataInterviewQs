# Data Interview Qs 
# 3/2/2022

#### prompt ----

# You are given a list of numbers J and a single number p. For example, J = [4, 4, 4, 9, 10, 11, 12] and p = 3.
# Write a function to return the minimum and maximum averages of the sequences of p numbers in the list J.

#### solution ----

# define the function to calculate moving averages of a list of numbers and return the min and max values
return_min_max_avg <- function(J, p){
  
  # exception handling:
  if (p %% 1 != 0) stop('p must be an integer')
  if (!is.atomic(J) & !is.numeric(J)) stop('J must be a vector of numbers')
  if (length(J) < p) stop('J must have p or more elements')
  
  # empty vector in which to store the average of each sequence
  avgs <- c()
  
  # create each sequence of length p beginning with first element of J (indexing starts at 1), up to element J-p (to ensure the final sequence is of length p)
  # then and calculate the sequence's average and store it
  for (i in 1:length(J) - p) {
    seq <- J[i:i+p-1]
    avg <- round(mean(seq), 2)
    avgs[i] <- avg 
  }
  
  # return the min and max sequence average values
  return(c(min(avgs), max(avgs)))
  
}

# array of numbers, J
J <- c(4, 4, 4, 9, 10, 11, 12)

# length of sequences, p
p <- 3

return_min_max_avg(J, p)
