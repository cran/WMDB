\name{WMDB-package}
\alias{WMDB-package}
\alias{WMDB}
\docType{package}
\title{
Discriminant Analysis Methods by Weight Mahalanobis Distance and bayes
}
\description{
Distance discriminant analysis method is one of classification methods according to multiindex performance parameters.However,the traditional Mahalanobis distance discriminant method treats with the importance of all parameters equally,and exaggerates the role of parameters which changes a little.The weighted Mahalanobis distance is used in discriminant analysis method to distinguish the importance of each parameter.In the concrete application,firstly based on the principal component analysis scheme,a new group of parameters and their corresponding percent contributions of the parameters are calculated ,and the weighted matrix is regarded as the diagonal matrix of the contributions rates.Setting data to standardization,then the weighted Mahalanobis distance can be calculated.Besides the methods metioned above,bayes method is also given.
}
\details{
\tabular{ll}{
Package: \tab WMD\cr
Type: \tab Package\cr
Version: \tab 1.0\cr
Date: \tab 2012-06-28\cr
License: \tab GPL (>= 2)\cr
}
}
\author{
Bingpei Wu
Maintainer:Bingpei Wu<jianpeizhon@126.com> 
}
\references{
Statistical modeling and R software,whose author is Yi Xue
}

\keyword{ weighted Mahalanobis distance method,distance discriminant analysis }

\examples{
##all parameters equal
X=iris[,1:4]
G=gl(3,50)
wmd(X,G,diag(rep(0.25,4)))
##not all parameters equal
X=iris[,1:4]
G=gl(3,50)
wmd(X,G)
##using bias method to distinguish classes
X<-iris[,1:4]
G<-gl(3,50)
dbayes(X,G)
}
