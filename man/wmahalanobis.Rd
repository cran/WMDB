\name{wmahalanobis}
\alias{wmahalanobis}
\title{
Compute weighted Mahalanobis distance 
}
\description{
compute weighted Mahalanobis distance between two samples 
}
\usage{
wmahalanobis(x, center, cov, weight)
}

\arguments{
  \item{x}{
vector or matrix of data with, say, p columns.

}
  \item{center}{
mean vector of the distribution or second data vector of length p
}
  \item{cov}{
covariance matrix (p x p) of the distribution
}
  \item{weight}{
the weight of the parameters
}
}
\details{
the weight of parameters is defined by users;if you do not define the weight,the corresponding percent contributions of the parameters
based on the principal component analysis scheme will be used instead 
}
\value{
weighted Mahalanobis distance will be returned
}
\references{
passage: "APPLICATION OF WEIGHTED MAHALANOBIS DISTANCE DISCRIMINANT ANALYSIS METHOD TO CLASSIFICATION OF ROCK MASS QUALITY",whose author is YAO Yinpei 
}
\author{
Bingpei Wu
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.
x=iris[1:50,1:4]
center=colMeans(x)
cov=var(x)
weight=diag(rep(0.25,4))
wmahalanobis(x,center,cov,weight)

## The function is currently defined as
function (x, center, cov, weight) 
{
    if (is.vector(x)) 
        x = matrix(x, ncol = length(x))
    else x=as.matrix(x)
    x <- sweep(x, 2, center)
    cov <- weight \%*\% solve(cov)
    retval <- diag(x \%*\% cov \%*\% t(x))
    retval
  }
}

