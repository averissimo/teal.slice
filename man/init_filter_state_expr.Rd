% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/FilterState-utils.R
\name{init_filter_state_expr}
\alias{init_filter_state_expr}
\title{Initialize a \code{FilterStateExpr} object}
\usage{
init_filter_state_expr(slice)
}
\arguments{
\item{slice}{(\code{teal_slice_expr})\cr
object created using \code{\link[=teal_slice]{teal_slice()}}. \code{teal_slice} is stored
in the class and \code{set_state} directly manipulates values within \code{teal_slice}. \code{get_state}
returns \code{teal_slice} object which can be reused in other places. Beware, that \code{teal_slice}
is a \code{reactiveValues} which means that changes in particular object are automatically
reflected in all places which refer to the same \code{teal_slice}.}
}
\value{
\code{FilterStateExpr} object
}
\description{
Initialize a \code{FilterStateExpr} object
}
\keyword{internal}
