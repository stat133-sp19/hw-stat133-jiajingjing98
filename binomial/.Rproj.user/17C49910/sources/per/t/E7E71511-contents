
context("Check checker functions")

test_that("check check_prob", {
          expect_error(check_prob(-0.1))
          expect_error(check_prob(5))
          expect_error(check_prob(2:10))
          expect_true(check_prob(1))
          expect_true(check_prob(0.5))
          })

test_that("check check_trials", {
          expect_error(check_trials(-0.1))
          expect_error(check_trials(1.4))
          expect_true(check_trials(10))
          expect_true(check_trials(1:5))
          })

test_that("check check_success", {
          expect_error(check_success(-1:1, 2))
          expect_error(check_success(1:6, 2))
          expect_true(check_success(2, 6))
          expect_true(check_success(1:3, 5))
          })

context("Check summary measures functions")

test_that("check aux_mean", {
          expect_equal(3, aux_mean(10, 0.3))
          expect_equal(7.5, aux_mean(15, 0.5))
          expect_equal(10, aux_mean(10, 1))
          })

test_that("check aux_variance", {
          expect_equal(2.1, aux_variance(10, 0.3))
          expect_equal(3.75, aux_variance(15, 0.5))
          expect_equal(0, aux_variance(10, 1))
          })

test_that("check aux_mode", {
          expect_equal(3, aux_mode(10, 0.3))
          expect_equal(c(2,3), aux_mode(5, 0.5))
          expect_equal(9, aux_mode(15, 0.6))
          })

test_that("check aux_skewness", {
          expect_equal((1-2*0.3)/sqrt(10*0.3*0.7), aux_skewness(10, 0.3))
          expect_equal((1-2*0.5)/sqrt(5*0.5*0.5), aux_skewness(5, 0.5))
          expect_equal((1-2*0.75)/sqrt(25*0.75*0.25), aux_skewness(25, 0.75))
          })

test_that("check kurtosis", {
          expect_equal((1-6*0.3*0.7)/(10*0.3*0.7), aux_kurtosis(10, 0.3))
          expect_equal((1-6*0.5*0.5)/(5*0.5*0.5), aux_kurtosis(5, 0.5))
          expect_equal((1-6*0.4*0.6)/(25*0.4*0.6), aux_kurtosis(25, 0.4))
          })

context("Check binomial functions")


test_that("check bin_choose", {
          expect_error(bin_choose(1, 6))
          expect_error(bin_choose(1:5,2))
          expect_equal(10, bin_choose(5,2))
          expect_equal(c(5, 10, 10), bin_choose(5, 1:3))
          })

test_that("check bin_probability", {
          expect_error(bin_probability(success=5, trials=-1, prob=0.1))
          expect_error(bin_probability(success=5, trials=10, prob=1.2))
          expect_error(bin_probability(success=5, trials=2, prob=0.1))
          expect_equal(0.3125, bin_probability(success=2, trials=5, prob=0.5))
          expect_equal(c(0.4096, 0.4096, 0.1536, 0.0256), bin_probability(success=0:3, trials=4, prob=0.2))
          })


standard_answer <- function(trials, prob, cumu) {
  success <- 0:trials
  probability <- dbinom(success, trials, prob)
  a <- data.frame(success = success, probability = probability)
  class(a) <- c('bindis', 'data.frame')
  if (cumu) {
    cumulative <- pbinom(success, trials, prob)
    a <- data.frame(success = success, probability = probability, cumulative = cumulative)
    class(a) <- c("bincum", "data.frame")
  }
  return(a)
}


test_that("check bin_distribution", {
          expect_equal(standard_answer(10, 0.5, FALSE), bin_distribution(10, 0.5))
          expect_equal(standard_answer(20, 0.25, FALSE), bin_distribution(20, 0.25))
          expect_error(bin_distribution(-1, 0.5, FALSE))
          expect_error(bin_distribution(10, 1.1, FALSE))
  })


test_that("check bin_cumulative", {
          expect_equal(standard_answer(10, 0.5, TRUE), bin_cumulative(10, 0.5))
          expect_equal(standard_answer(20, 0.25, TRUE), bin_cumulative(20, 0.25))
          expect_error(bin_distribution(-1, 0.5, TRUE))
          expect_error(bin_distribution(10, 1.1, TRUE))
  })


