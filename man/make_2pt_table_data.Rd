% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/table_functions.R
\name{make_2pt_table_data}
\alias{make_2pt_table_data}
\title{Get 2pt decision probabilities}
\usage{
make_2pt_table_data(probs)
}
\arguments{
\item{probs}{A data frame consisting of one play that has had \code{add_2pt_probs()} already run on it.}
}
\value{
A table showing the probabilities associated with each possible choice.
}
\description{
Get a table with the probabilities associated with a 2-pt decision.
}
\examples{
\donttest{
play <-
  tibble::tibble(
    # things to help find the right game (use "reg" or "post")
    home_team = "GB",
    away_team = "TB",
    posteam = "GB",
    type = "post",
    season = 2020,

    # information about the situation
    qtr = 4,
    quarter_seconds_remaining = 123,
    score_differential = -2,

    home_opening_kickoff = 0,
    posteam_timeouts_remaining = 3,
    defteam_timeouts_remaining = 3
  )

probs <- nfl4th::add_2pt_probs(play)
nfl4th::make_2pt_table_data(probs)
}
}
