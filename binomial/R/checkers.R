# checks if input prob is a valid probability
check_prob <- function(prob) {
  if (length(prob) != 1) {
    stop('invalid prob length')
  }
  if ( (0 <= prob & prob <= 1) ==TRUE ) {
    return(TRUE)
  } else {
    stop('invalid prob value')
  }
}


# checks if input trials is valid
check_trials <- function(trials) {
  if (trials %% 1 == 0 && trials >= 0) {
    return(TRUE)
  } else {
    stop('invalid trial value')
  }
}

# checks if success is valid
check_success <- function(success, trials) {
  check_trials(trials)
  for (i in success) {
    if (i < 0 || i %% 1 != 0) {
      stop('invalid success value')
    }
    if (i > trials) {
      stop('success cannot be greater than trials')
    }
  }
  return(TRUE)
}
