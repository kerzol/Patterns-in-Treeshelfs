from sympy import *
from __future__ import division
from sympy import *
x, y, z, t = symbols('x y z t')
k, m, n = symbols('k m n', integer=True)
f, g, h = symbols('f g h', cls=Function)




A  = 1 + ( 1 + sin(x) ) * sin(x) / (cos(x)**2)
series(A, n = 14)
simplify (A - 1 - integrate(A) - integrate( A * integrate(A)  )  ) ### ?? why not zero?
simplify ( diff(diff(A)/A) - A ) # 0, 0 c'est bien!
simplify(expand( diff(diff(A)) * A - diff(A)**2 - A**3 )) # 0, 0 c'est bien!



B  = (2*(exp(sqrt(2)*x)-1)) / ((2+sqrt(2))-(2-sqrt(2))*exp(sqrt(2)*x))
simplify (B - 2 *integrate(B) - integrate( integrate (diff(B)*B) ))
simplify(diff(diff(B)) - 2* diff(B) - diff(B) * B) # 0, 0 c'est bien!

