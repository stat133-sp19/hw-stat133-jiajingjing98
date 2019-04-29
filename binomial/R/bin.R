
#   Build and Reload Package:  'Cmd + Shift + B'
#   Check Package:             'Cmd + Shift + E'
#   Test Package:              'Cmd + Shift + T'

#' @title bin_choose method
#' @description calculates the number of combinations in which k successes can occur in n trials
#' @param n number of trials
#' @param k number of sucesses
#' @return the number of combinations in which k successes can occur in n trials
#' @export
#' @examples
#'
#' # number of combinations of 2 successes out of 4 trials
#' bin_choose(4, 2)
#'
#' #number of combinations of 1,2,3 successes respectively out of 6 trials
#' bin_choose(6, 1:3)
#'
bin_choose <- function(n, k) {
  if (sum(k>n) != 0) {
    stop("k cannot be greater than n")
  }
  return(factorial(n)/(factorial(k)*factorial(n-k)))
}


#' @title bin_probability method
#' @description calculates the probability of getting given number of successes out of given trials with given probability
#' @param success number of sucesses
#' @param trials number of trials
#' @param prob probability of success
#' @return the probability of getting given number of successes out of given trials with given probability
#' @export
#' @examples
#'
#' # probability of getting 2 successes in 5 trials with prob success of 0.5
#' bin_probability(2, 5, 0.5)
#'
#' # probability of getting 1,2,3 successes in 6 trials respectively with prob success of 0.25
#' bin_probability(1:3, 6, 0.25)
#'
bin_probability <- function(success, trials, prob) {
  check_trials(trials)
  check_prob(prob)
  check_success(success = success, trials = trials)

  return(bin_choose(trials, success) * (prob^success) * ((1-prob)^(trials-success)))
}


#' @title bin_distribution method
#' @description calculates binomial probability distribution
#' @param trials number of trials
#' @param prob probability of success
#' @return binomial probability distribution of given trials with given probability of success
#' @export
#' @examples
#'
#' # binomial probability distribution of heads out of five fair coin toss
#' bin_distribution(5, 0.5)
#'
#' # binomial probability distribution of heads out of ten loaded coin toss with 25% chance of heads
#' bin_distribution(10, 0.25)
#'
bin_distribution <- function(trials, prob) {
  success <- 0:trials
  probability <- bin_probability(success, trials, prob)
  bin_dis <- data.frame(success=success, probability=probability)
  class(bin_dis) <- c('bindis', 'data.frame')
  return(bin_dis)
}

#' @export
plot.bindis <- function(bin_dis) {
  barplot(bin_dis$probability, names=bin_dis$success, xlab="successes", ylab="probability")
}


#' @title bin_cumulation method
#' @description calculates binomial cumulative distribution
#' @param trials number of trials
#' @param prob probability of success
#' @return binomial cumulative distribution of given trials with given probability of success
#' @export
#' @examples
#'
#' # binomial cumulative distribution of heads out of five fair coin toss
#' bin_cumulative(5, 0.5)
#'
#' # binomial cumulative distribution of heads out of ten loaded coin toss with 25% chance of heads
#' bin_cumulative(10, 0.25)
#'
bin_cumulative <- function(trials, prob) {
  bin_dis <- bin_distribution(trials, prob)
  cumulative <- rep(0, length(trials)+1)
  for (i in 1:length(bin_dis$probability)) {
    v <- 0
    for (j in 1:i) {
      v <- v + bin_dis$probability[j]
    }
    cumulative[i] = v
  }
  bin_cum <- data.frame(success=bin_dis$success, probability=bin_dis$probability, cumulative=cumulative)
  class(bin_cum) <- c("bincum", "data.frame")
  return(bin_cum)
}

#' @export
plot.bincum <- function(bin_cum) {
  plot(bin_cum$success, bin_cum$cumulative, type="o", xlab="successes", ylab="probability")
}



#' @title bin_var
#' @description creates a binary variable (binvar) object
#' @param trials number of trials
#' @param prob probability of success
#' @return a binvar object
#' @export
#' @examples
#'
#' # a binary variable of tossing a fair coin five times to get heads
#' bin_variable(5, 0.5)
#'
#' # a binary variable of tossing a loaded coin with 25% chance of heads ten times to get heads
#' bin_cumulative(10, 0.25)
#'
bin_variable <- function(trials, prob) {
  check_trials(trials)
  check_prob(prob)

  b <- list(trials=trials, prob=prob)
  class(b) <- "binvar"
  return(b)
}

#' @export
print.binvar <- function(bin_var) {
  cat("\"Binomial variable\"\n\nParameters\n")
  cat("- number of trials: ", bin_var$trials, "\n")
  cat("- prob of successs: ", bin_var$prob)
}

#' @export
summary.binvar <- function(bin_var) {
  cat("\"Binomial variable\"\n\nParameters\n")
  cat("- number of trials: ", bin_var$trials, "\n")
  cat("- prob of successs: ", bin_var$prob)
  cat("\n\n")
  cat("Measures\n")
  cat("- mean    : ", aux_mean(bin_var$trials, bin_var$prob), "\n")
  cat("- variance: ", aux_variance(bin_var$trials, bin_var$prob), "\n")
  cat("- mode    : ", aux_mode(bin_var$trials, bin_var$prob), "\n")
  cat("- skewness: ", aux_skewness(bin_var$trials, bin_var$prob), "\n")
  cat("- kurtosis: ", aux_kurtosis(bin_var$trials, bin_var$prob), "\n")
}

#' @title bin_mean method
#' @description calculates the mean of a binomial variable
#' @param trials number of trials
#' @param prob probability of success
#' @return the mean of a binomial variable
#' @export
#' @examples
#'
#' # expected number of heads of tossing a fair coin 10 times
#' bin_mean(10, 0.5)
#'
bin_mean <- function(trials, prob) { return(aux_mean(trials, prob)) }


#' @title bin_variance method
#' @description calculates the variance of a binomial variable
#' @param trials number of trials
#' @param prob probability of success
#' @return the variance of a binomial variable
#' @export
#' @examples
#'
#' # variance of heads of tossing a fair coin 10 times
#' bin_variance(10, 0.5)
#'
bin_variance <- function(trials, prob) { return(aux_variance(trials, prob)) }

#' @title bin_mode method
#' @description calculates the mode of a binomial variable
#' @param trials number of trials
#' @param prob probability of success
#' @return the mode of a binomial variable
#' @export
#' @examples
#'
#' # most likely number of heads of tossing a fair coin 10 times
#' bin_mean(10, 0.5)
#'
bin_mode <- function(trials, prob) { return(aux_mode(trials, prob)) }

#' @title bin_skewness method
#' @description calculates the skewness of a binomial variable
#' @param trials number of trials
#' @param prob probability of success
#' @return the skewness of a binomial variable
#' @export
#' @examples
#'
#' # skewness of the number of heads got from tossing a fair coin 10 times
#' bin_mean(10, 0.5)
#'
bin_skewness <- function(trials, prob) { return(aux_skewness(trials, prob)) }

#' @title bin_kurtosis method
#' @description calculates the kurtosis of a binomial variable
#' @param trials number of trials
#' @param prob probability of success
#' @return the kurtosis of a binomial variable
#' @export
#' @examples
#'
#' # kurtosis of the number of heads got from tossing a fair coin 10 times
#' bin_mean(10, 0.5)
#'
bin_kurtosis <- function(trials, prob) { return(aux_kurtosis(trials, prob)) }
