import matplotlib.pyplot as plt
import operator
#from mpmath import *
from sympy import *
from __future__ import division

x, y, z, t, pole, pole2, residue, residue2 = symbols('x y z t pole pole2 residue residue2')
k, m, n = symbols('k m n', integer=True)
f, g, h = symbols('f g h', cls=Function)
asym_f, asym_g, asym_h = symbols('asym_f asym_g asym_h', cls=Function)


### using FS-book and http://ac.cs.princeton.edu/lectures/lectures13/AC04-Poles.pdf#62

### Theorem 1 --- multivariate TODO
### Corollary 1. ---  Bell A000110
### Corollary 2. --- Entire function, saddle-point method TODO

### En fait
### h1 + h2 + bell  =  n * Bell(n) + Bell(n) - Bell(n+1)

bell = exp( exp (z) - 1)
h1 = z * exp (z) * bell
h2 = exp (z) * bell


h = bell
## calculate some coefficients
NUMBER_OF_COEFFS = 7
coeffs = Poly(series(h,n = NUMBER_OF_COEFFS)).coeffs()
## reverse the list
coeffs.reverse()
## and remove first coefficient 1 that corresponds to O(n**k)
coeffs.pop(0)
## also remove the second coefficient that corresponds to 1 (empty object) in this case
coeffs.pop(0)
factorials = list(map (factorial, range(1, NUMBER_OF_COEFFS)))
coeffs = list(map (operator.mul, coeffs, factorials ))

## Theorem VIII.4 from Flajolet-Sedgewick "Analytic Combinatorics" book
## Sometimes we can solve the saddle-point equation
# quation = z * simplify(diff(h)/h) - n
# saddle = solve(quation, z) [0]
## sometimes we cannot, in this case we use other methods...
saddle = LambertW (n)
b = z ** 2  * diff (diff (log (h))) + z * diff (log (h))

asym_h = factorial(n) * (
  h.subs (z, saddle) /
  (saddle ** n * sqrt(2 * pi * b.subs(z, saddle) ) )
)

## new we calculate approximation to coefficients ...
asymtotics = list(map(lambda nn: round(asym_h.subs(n, nn).evalf()), range(1, NUMBER_OF_COEFFS) ))

## and compare them with real values
ratios = list(map( lambda x: x.evalf(), list(map(operator.truediv, coeffs, asymtotics))))
plt.plot(ratios); plt.show()






### Theorem 2. --- multivariate TODO
### Corollary 3. --- A000111
### Corollary 4.
f = - cos(z)**2 * z  +  cos(z)**2  +  sin(z) * cos(z)  +  2*sin(z)*z  +  cos(z) - 2*sin(z)  + 2*z - 2
g = cos(z)**3
## f = -(sin(z)-z* cos(z)+cos(z)-1)
## g = (sin(z)-1)**2
h = f/g

## calculate some coefficients
NUMBER_OF_COEFFS = 30
coeffs = Poly(series(h,n = NUMBER_OF_COEFFS)).coeffs()
## reverse the list
coeffs.reverse()
## and remove first coefficient 1 that corresponds to O(n**k)
coeffs.pop(0)
## start from 2 because series starts from z**2
factorials = list(map (factorial, range(2, NUMBER_OF_COEFFS))) 
coeffs = list(map (operator.mul, coeffs, factorials ))

## Poles are pi/2 + pi*k for any k in Z
## dominant pole
pole = pi / 2 
## of order 3, so
m = 3
residue = (-1)**m * m * f.subs(z, pole) / diff(g, z, m).subs(z,pole)
pole2 = pi/2 - 2 * pi
residue2 = (-1)**m * m * f.subs(z, pole2) / diff(g, z, m).subs(z,pole2)
## residue2 == 0 , so

##residue = limit(h * (a - z)**3, z, a)??? FIXME!!!!1111 READ MORE ABOUT RESIDUES (m-1)! somewhere
asym_h = factorial(n) * (
    (1/pole)**n * n**(m-1) * residue / pole**m
)

## new we calculate approximation to coefficients ...
## start from 2 because series starts from z**2
asymtotics = list(map(lambda nn: round(asym_h.subs(n, nn).evalf()), range(2, NUMBER_OF_COEFFS) ))


## and compare them with real values
ratios = list(map( lambda x: x.evalf(), list(map(operator.truediv, coeffs, asymtotics))))
plt.plot(ratios); plt.show()



### Theorem 3. --- multivariate TODO
### Corollary 5. --- A131178
### Corollary 6.

f = (4*z-4)*exp(sqrt(2)*z)-(sqrt(2)-2)*exp(2*sqrt(2)*z)+2+sqrt(2)
g = ((sqrt(2)-2)*exp(sqrt(2)*z)+2+sqrt(2))**2
h = f/g

## calculate some coefficients
NUMBER_OF_COEFFS = 10
coeffs = Poly(series(h,n = NUMBER_OF_COEFFS)).coeffs()
## reverse the list
coeffs.reverse()
## and remove first coefficient 1 that corresponds to O(n**k)
coeffs.pop(0)
factorials = list(map (factorial, range(2, NUMBER_OF_COEFFS)))
## start from 2 because series starts from z**2
coeffs = list(map (operator.mul, coeffs, factorials ))


## dominant pole
pole = sqrt(2)*log(2*sqrt(2) + 3) / 2
## of order 2, so
m = 2
residue = (-1)**m * m * f.subs(z, pole) / diff(g, z, m).subs(z,pole)
residue = simplify(residue)
asym_h = factorial(n) * (
    (1/pole)**n * n**(m-1) * residue / pole**m
)

## new we calculate approximation to coefficients ...
## start from 2 because series starts from z**2
asymtotics = list(map(lambda nn: round(asym_h.subs(n, nn).evalf()), range(2, NUMBER_OF_COEFFS) ))


## and compare them with real values
ratios = list(map( lambda x: x.evalf(), list(map(operator.truediv, coeffs, asymtotics))))
plt.plot(ratios); plt.show()
