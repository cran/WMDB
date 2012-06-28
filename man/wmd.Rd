\name{wmd}
\alias{wmd}
\title{
Discriminant Analysis Methods by Weight Mahalanobis Distance
}
\description{
using Weight Mahalanobis Distance to Discriminant Analysis and return a result table and accuracy report
}
\usage{
wmd(TrnX, TrnG, Tweight = NULL, TstX = NULL, var.equal = F)
}
\arguments{
  \item{TrnX}{
matrix or data frame of training set cases.
}
  \item{TrnG}{
vector of factors of the samples
}
  \item{Tweight}{
matrix or dataframe of the weight of the parameters,if you do not define the weight,the corresponding percent contributions of the parameters based on the principal component analysis scheme will be used instead 
}
  \item{TstX}{
matrix or data frame of test set cases. A vector will be interpreted as a row vector for a single case.
}
  \item{var.equal}{
whether class have the same covariance or not
}
}
\details{the function of wmd apply two methods,one is normal discriminant analysis and at this time Tweight should be given like diag(rep(w,n)),which w is the weight of each parameter.if Tweight is not given,the the corresponding percent contributions of the parameters based on the principal component analysis scheme will be used instead.
}
\value{
result of classifications of test set will be returned. (When TstX is NULL, the function will automatically consider the user is trying to test the Discriminant Analysis Methods by weight Mahalanobis distance. Hence, a test result table and accuracy report will be shown on the R-console.)
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
##do not define the weight
X=iris[,1:4]
G=gl(3,50)
wmd(X,G)
##define the weight
X=iris[,1:4]
G=gl(3,50)
wmd(X,G,diag(rep(0.25,4)))

## The function is currently defined as
function (TrnX, TrnG, Tweight = NULL, TstX = NULL, var.equal = F) 
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
    if (is.null(Tweight) == TRUE) 
        Tweight = cor(TstX)
    nx <- nrow(TstX)
    blong <- matrix(rep(0, nx), nrow = 1, dimnames = list("blong", 
        1:nx))
    g <- length(levels(TrnG))
    mu <- matrix(0, nrow = g, ncol = ncol(TrnX))
    for (i in 1:g) mu[i, ] <- colMeans(TrnX[TrnG == i, ])
    D <- matrix(0, nrow = g, ncol = nx)
    if (var.equal == TRUE || var.equal == T) {
        for (i in 1:g) D[i, ] <- mahalanobis2(TstX, mu[i, ], 
            var(TrnX), Tweight)
    }
    else {
        for (i in 1:g) D[i, ] <- mahalanobis2(TstX, mu[i, ], 
            var(TrnX[TrnG == i, ]), Tweight)
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

