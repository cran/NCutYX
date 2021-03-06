% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/NCutYX.R
\name{ncut}
\alias{ncut}
\title{Cluster the Columns of Y into K Groups Using the NCut Graph Measure.}
\usage{
ncut(Y, K = 2, B = 30, N = 500, dist = "correlation", scale = TRUE,
  q = 0.1, sigma = 1)
}
\arguments{
\item{Y}{is a n x p matrix of p variables and n observations. The p columns of
Y will be clustered into K groups using NCut.}

\item{K}{is the number of clusters.}

\item{B}{is the number of iterations.}

\item{N}{is the number of samples per iterations.}

\item{dist}{is the type of distance metric for the construction of the similarity matrix.
Options are 'gaussian', 'euclidean' and 'correlation', the latter being the default.}

\item{scale}{equals TRUE if data Y is to be scaled with mean 0 and variance 1.}

\item{q}{is the quantile used for the top results at each iterations.}

\item{sigma}{is the bandwidth parameter when the dist metric chosen is 'gaussian' (default=0.1).}
}
\value{
A list with the following components:
\describe{
\item{quantile}{a vector of length \code{N} which contains the quantiles
\code{q} at each iteration of the optimization algorithm.}
\item{cluster}{a matrix representing the clustering result of dimension \code{p} times
\code{K}, where \code{p} is the number of columns of \code{Y}.}
\item{ncut}{the NCut measure for the cluster result.}
}
}
\description{
Builds a similarity matrix for the columns of Y and clusters them into
K groups based on the NCut graph measure. Correlation, Euclidean and Gaussian distances can be used
to construct the similarity matrix.
}
\details{
The algorithm minimizes the NCut through the cross entropy method.
The edges of the graph correspond to the entries of a similarity matrix constructed based on a
correlation, euclidean or gaussian distance metric.
The clusters correspond to partitions that minimize this NCut objective function.
}
\examples{
# This sets up the initial parameters for the simulation.
library(MASS)
n=100 # Sample size
B=30 # Number of iterations in the simulated annealing algorithm.
p=50 # Number of columns of Y.

S=matrix(0.2,p,p)
S[1:(p/2),(p/2+1):p]=0
S[(p/2+1):p,1:(p/2)]=0
S=S-diag(diag(S))+diag(p)
mu=rep(0,p)

W0=matrix(1,p,p)
W0[1:(p/2),1:(p/2)]=0
W0[(p/2+1):p,(p/2+1):p]=0
Denum=sum(W0)

Y=mvrnorm(n, mu, S)
# NCut
Res=ncut(Y,
K=2,
B=30,
N=1000,
dist='correlation',
scale=TRUE,
q=0.2,
sigma=0.1)
Cx=Res[[2]]
f11=matrix(Cx[,1],p,1)
f12=matrix(Cx[,2],p,1)

errorL=sum((f11\%*\%t(f11))*W0)/Denum+sum((f12\%*\%t(f12))*W0)/Denum
# This is the true error of the clustering solution.
errorL
}
\references{
Von Luxburg, Ulrike. "A tutorial on spectral clustering."
Statistics and computing 17.4 (2007): 395-416.

Kroese, D. P., Rubinstein, R. Y., Cohen, I., Porotsky, S., & Taimre, T. (2013).
"Cross-entropy method."
In Encyclopedia of Operations Research and Management Science (pp. 326-333). Springer US.
}
\author{
Sebastian Jose Teran Hidalgo. Maintainer: Sebastian Jose Teran Hidalgo
\url{sebastianteranhidalgo@gmail.com}.
}
