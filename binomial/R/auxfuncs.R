
# computes expected value of a binomial variable
aux_mean <- function(trials, prob) {
  return(trials*prob)
}

# computes variance of a binomial variable
aux_variance <- function(trials, prob) {
  return(trials*prob*(1-prob))
}

# computes the most likely value of a binomial variable
aux_mode <- function(trials, prob) {
  r <- trials*prob+prob
  if (r %% 1 == 0) {
    return(c(r-1, r))
  }
  return(floor(r))
}

# computes expected value of a binomial variable
aux_skewness <- function(trials, prob) {
  return((1-2*prob)/(sqrt(trials*prob*(1-prob))))
}

# computes kurtosis of a binomial variable
aux_kurtosis <- function(trials, prob) {
  return((1-6*prob*(1-prob))/(trials*prob*(1-prob)))
}
