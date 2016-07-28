import matplotlib.pyplot as plt
import operator
from sympy import *
from __future__ import division
from sympy import *
x, y, z, t, a, a2, residue, residue2 = symbols('x y z t a a2 residue residue2')
k, m, n = symbols('k m n', integer=True)
f, g, h = symbols('f g h', cls=Function)
asym_f, asym_g, asym_h = symbols('asym_f asym_g asym_h', cls=Function)


### using FS-book and http://ac.cs.princeton.edu/lectures/lectures13/AC04-Poles.pdf#62

### Theorem 1 --- multivariate TODO
### Corollary 1. ---  Bell A000110
### Corollary 2. --- Entire function, saddle-point method TODO


### Theorem 2. --- multivariate TODO
### Corollary 3. --- A000111

### Corollary 4.
f = - cos(z)**2 * z  +  cos(z)**2  +  sin(z) * cos(z)  +  2*sin(z)*z  +  cos(z) - 2*sin(z)  + 2*z - 2
g = cos(z)**3
h = f/g

## calculate some coefficients
NUMBER_OF_COEFFS = 20
coeffs = Poly(series(h,n = NUMBER_OF_COEFFS)).coeffs()
## reverse the list
coeffs.reverse()
## and remove first coefficient 1 that corresponds to O(n**k)
coeffs.pop(0)
factorials = list(map (factorial, range(2, NUMBER_OF_COEFFS)))
coeffs = list(map (operator.mul, coeffs, factorials ))

## Poles are pi/2 + pi*k for any k in Z
## dominant pole a
a = pi / 2
## TODO: What about another pole with the same absolute value -pi/2 ?
## order of pole is m=3, so
m = 3
residue = (-1)**m * m * f.subs(z, a) / diff(g, z, m).subs(z,a)
a2 = pi/2 - 2 * pi
residue2 = (-1)**m * m * f.subs(z, a2) / diff(g, z, m).subs(z,a2)
## residue2 == 0 , so

residue = limit(h * (a2 - z)**3, z, a2)
asym_h = factorial(n) * (
    (1/a)**n * n**(m-1) * residue / a**m
#  + (1/a2)**n * n**(m-1) * residue2 / a2**m 
)
  

## new we calculate approximation to coefficients ...
asymtotics = list(map(lambda nn: round(asym_h.subs(n, nn).evalf()), range(2, NUMBER_OF_COEFFS) ))

## and compare them with real values
errors = list(map(operator.sub, coeffs, asymtotics))
plt.plot(errors); plt.show()
relative_errors = list(map (operator.truediv, errors, coeffs ))
relative_errors = list(map (lambda x : x.evalf(), relative_errors))
plt.plot(relative_errors); plt.show()

### Theorem 3. --- multivariate TODO
### Corollary 5. --- A131178
### Corollary 6. --- TODO
