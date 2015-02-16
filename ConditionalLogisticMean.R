# Fast calculation of the marginal mean of a conditional logistic model
# Need to quickly perform the integration of (1+Exp(-(a+bx)))^(-1)Phi(x) over the reals
# where Phi is the standard normal pdf

# Implementation: expand (1+Exp(-(a+bx)))^(-1) into a Taylor series c_ix^i. Odd raw moments
# of a standard normal variable are zero, and the ith even moment evaluates to (i-1)!!. 
# Constants c_i can be evaluated numerically or by recursion.