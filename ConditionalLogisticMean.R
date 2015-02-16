# Fast calculation of the marginal mean of a conditional logistic model
# Need to quickly perform the integration of (1+Exp(-(a+bx)))^(-1)Phi(x) over the reals
# where Phi is the standard normal pdf

# Implementation: expand (1+Exp(-(a+bx)))^(-1) into a Taylor series c_ix^i. Odd raw moments
# of a standard normal variable are zero, and the ith even moment evaluates to (i-1)!!. 
# Constants c_i can be evaluated numerically or by recursion.

# Taylor coefficients are found analytically by noticing that 
# 1=(1+Exp(-(a+bx)))(1+Exp(-(a+bx)))^(-1)=(Sum a_ix^1)*(Sum b_ix^i). 
# We can then solve for these coefficients by noticing that the Taylor 
# expansion of 1 is just itself, and then matching terms.

library(microbenchmark)

naiveCLM <- function ( delta, sigma )
{
  
  integrand <-  function(x)
  {
    (1+exp(-(delta+sigma*x)))^(-1)*(sqrt(2*pi))^(-1)*exp(-x^2/2)
  }
  
  result <-integrate(integrand, -Inf, Inf)
  return(result)
}

# Randomly select two values for benchmarking
testdelta <- runif( 1, -100, 100 )
testsigma <- runif( 1, -100, 100 )
microbenchmark( naiveCLM( testdelta, testsigma), times=1000)

# Microbenchmarking results
# Unit: microseconds
# expr                            min      lq     mean    median    uq     max    neval
# naiveCLM(testdelta, testsigma) 135.241 139.165 149.8196 141.58 147.013 1409.754  1000
# While this function is fairly fast, evaluation of a polynomial is much faster.

