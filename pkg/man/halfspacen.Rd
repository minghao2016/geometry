% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/halfspacen.R
\name{halfspacen}
\alias{halfspacen}
\title{Compute halfspace intersection about a point}
\usage{
halfspacen(p, fp, options = "Tv")
}
\arguments{
\item{p}{An \eqn{M}-by-\eqn{N+1} matrix. Each row of \code{p}
represents a halfspace by a \eqn{N}-dimensional normal to a
hyperplane and the offset of the hyperplane.}

\item{fp}{A \dQuote{feasible} point that is within the space
contained within all the halfspaces.}

\item{options}{String containing extra options, separated by
spaces, for the underlying Qhull command; see Qhull
documentation at \url{../doc/qhull/html/qhalf.html}.}
}
\value{
A \eqn{N}-column matrix containing the intersection
  points of the hyperplanes \url{../doc/qhull/html/qhalf.html}.
}
\description{
Compute halfspace intersection about a point
}
\note{
\code{halfspacen} was introduced in geometry 0.4.0, and is
  still under development. It is worth checking results for
  unexpected behaviour.
}
\examples{
p <- rbox(0, C=0.5)  # Generate points on a unit cube centered around the origin
ch <- convhulln(p, "n") # Generate convex hull, including normals to facets, with "n" option
# Intersections of half planes
# These points should be the same as the orginal points
pn <- halfspacen(ch$normals, c(0, 0, 0)) 

}
\references{
\cite{Barber, C.B., Dobkin, D.P., and Huhdanpaa, H.T.,
  \dQuote{The Quickhull algorithm for convex hulls,} \emph{ACM
  Trans. on Mathematical Software,} Dec 1996.}

\url{http://www.qhull.org}
}
\seealso{
\code{\link{convhulln}}
}
\author{
David Sterratt
}
