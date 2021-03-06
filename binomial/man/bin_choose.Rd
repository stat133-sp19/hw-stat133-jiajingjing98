% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bin.R
\name{bin_choose}
\alias{bin_choose}
\title{bin_choose method}
\usage{
bin_choose(n, k)
}
\arguments{
\item{n}{number of trials}

\item{k}{number of sucesses}
}
\value{
the number of combinations in which k successes can occur in n trials
}
\description{
calculates the number of combinations in which k successes can occur in n trials
}
\examples{

# number of combinations of 2 successes out of 4 trials
bin_choose(4, 2)

#number of combinations of 1,2,3 successes respectively out of 6 trials
bin_choose(6, 1:3)

}
