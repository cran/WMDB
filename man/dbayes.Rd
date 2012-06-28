\name{dbayes}
\alias{dbayes}

\title{
Using bias method to distinguish classes
}
\description{
 using bias method to distinguish classes
}
\usage{
dbayes(TrnX, TrnG, p = rep(1, length(levels(TrnG))), TstX = NULL, var.equal = FALSE)
}

\arguments{
  \item{TrnX}{
matrix or data frame of training set cases.
}
  \item{TrnG}{
vector of factors of the samples
}
  \item{p}{
vector of prior probability of samples
}
  \item{TstX}{
matrix or data frame of test set cases. A vector will be interpreted as a row vector for a single case.
}
  \item{var.equal}{
whether class have the same covariance or not
}
}
\details{
the distribution of samples shuold be normal distribution
}
\value{
result of classifications of test set will be returned. (When TstX is NULL, the function will automatically consider the user is trying to test the Discriminant Analysis Methods by weight Mahalanobis distance. Hence, a test result table and accuracy report will be shown on the R-console.)
}
\references{
Statistical modeling and R software,whose author is Yi Xue
}
\author{
Bingpei Wu
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.
X<-iris[,1:4]
G<-gl(3,50)
dbayes(X,G)

## The function is currently defined as
function (TrnX, TrnG, p = rep(1, length(levels(TrnG))), TstX = NULL, 
    var.equal = FALSE) 
{
    if (is.factor(TrnG) == FALSE) {
        mx <- nrow(TrnX)
        mg <- nrow(TrnG)
        TrnX <- rbind(TrnX, TrnG)
        TrnG <- factor(rep(1:2, c(mx, mg)))
    }
    if (is.null(TstX) == TRUE) 
        TstX <- TrnX
    if (is.vector(TstX) == TRUE) 
        TstX <- t(as.matrix(TstX))
    else if (is.matrix(TstX) != TRUE) 
        TstX <- as.matrix(TstX)
    if (is.matrix(TrnX) != TRUE) 
        TrnX <- as.matrix(TrnX)
    nx <- nrow(TstX)
    blong <- matrix(rep(0, nx), nrow = 1, dimnames = list("blong", 
        1:nx))
    g <- length(levels(TrnG))
    mu <- matrix(0, nrow = g, ncol = ncol(TrnX))
    for (i in 1:g) mu[i, ] <- colMeans(TrnX[TrnG == i, ])
    D <- matrix(0, nrow = g, ncol = nx)
    if (var.equal == TRUE || var.equal == T) {
        for (i in 1:g) {
            d2 <- mahalanobis(TstX, mu[i, ], var(TrnX))
            D[i, ] <- d2 - 2 * log(p[i])
        }
    }
    else {
        for (i in 1:g) {
            S <- var(TrnX[TrnG == i, ])
            d2 <- mahalanobis(TstX, mu[i, ], S)
            D[i, ] <- d2 - 2 * log(p[i]) - log(det(S))
        }
    }
    for (j in 1:nx) {
        dmin <- Inf
        for (i in 1:g) if (D[i, j] < dmin) {
            dmin <- D[i, j]
            blong[j] <- i
        }
    }
    print(blong)
    print("num of wrong judgement")
    print(which(blong != TrnG))
    print("samples divided to")
    print(blong[which(blong != TrnG)])
    print("samples actually belongs to")
    print(TrnG[which(blong != TrnG)])
    print("percent of right judgement")
    print(1 - length(which(blong != TrnG))/length(blong))
  }
}
