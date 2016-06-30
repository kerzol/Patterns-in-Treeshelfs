from sympy import *
from __future__ import division
from sympy import *
x, y, z, t = symbols('x y z t')
k, m, n = symbols('k m n', integer=True)
f, g, h = symbols('f g h', cls=Function)


def my_integral (f):
  return integrate(f,(x,0,t)).subs(t,x)

### example from flajolet
### increasing binary trees, n!
I = 1/(1-x)
series(I,n=14)
simplify (diff(I) - I**2)            # 0, 0 c'est bien!
simplify (I - 1 - my_integral(I**2)) # 0, 0 c'est bien aussi!



A  = 1 + ( 1 + sin(x) ) * sin(x) / (cos(x)**2)
series(A, n = 14)
simplify (A - 1 - my_integral(A) - my_integral( A * my_integral(A)  )) # 0
simplify ( diff(diff(A)/A) - A )                                       # 0
simplify(expand( diff(diff(A)) * A - diff(A)**2 - A**3 ))              # 0



B  = (2*(exp(sqrt(2)*x)-1)) / ((2+sqrt(2))-(2-sqrt(2))*exp(sqrt(2)*x))   
series(B, n = 14)                                                             # 0
simplify (B - x - 2 *my_integral(B) - my_integral( my_integral (diff(B)*B) )) # 0
simplify(diff(diff(B)) - 2* diff(B) - diff(B) * B)                            # 0

