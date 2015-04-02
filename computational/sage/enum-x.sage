#!/usr/bin/env sage

import time

# Define max heights to enumerate to for x = p1/q1 + p2/q2 sqrt(d),
# where the max height of d is defined as d_max_height, and for a
# given d, the max height of p1, p2, q1, and q2 is defined as
# pq_max_height.
#
# These two parameters can and should be customized.
d_max_height=100;
pq_max_height=10;

# C_0(5) is birationally equivalent to y^2 = f(x), where f(x) is
def f(x):
    return x^6 + 8 * x^5 + 22 * x^4 + 22 * x^3 + 5 * x^2 + 6 * x + 1

# For a, b, and d rational, f(a + b sqrt(d)) will be written in the
# form
#
#    rational_part + irrational_part * sqrt(d)
#
# to facilitate taking the norm in the quadratic extension Q(sqrt(d))
# to Q.
#
# The polynomial expressions are copied over from mma/enum-x.m.
def rational_part(a, b, d):
    return (b^6) * d^3 + \
        (22*b^4+40*a*b^4+15*a^2*b^4) * d^2 + \
        (5*b^2+66*a*b^2+132*a^2*b^2+80*a^3*b^2+15*a^4*b^2) * d + \
        (1+6*a+5*a^2+22*a^3+22*a^4+8*a^5+a^6)

def irrational_part(a, b, d):
    return (8*b^5+6*a*b^5) * d^2 + \
        (22*b^3+88*a*b^3+80*a^2*b^3+20*a^3*b^3) * d + \
        (6*b+10*a*b+66*a^2*b+88*a^3*b+40*a^4*b+6*a^5*b)

# c is given in terms of x and y as follows
def g(x):
    return 8*x^6+74*x^5+271*x^4+452*x^3+325*x^2+110*x+64

def P0(x):
    return -x^6-10*x^5-46*x^4-104*x^3-95*x^2-24*x-9

def P1(x):
    return x^3+6*x^2+3*x-9

def c(x, y):
    return g(x)/(2 * (P0(x) - P1(x) * y))

# Test if a + b sqrt(d) is a square in Q(sqrt(d)).
def is_square_in_qsqrtd(a, b, d):
    norm = a^2 - b^2 * d
    if not sqrt(norm) in QQ:
        return False
    # the first test has been passed, run the definitive test
    # construct the quadratic extension Q(sqrt(d)) to Q
    s = var('s')
    K.<sqrtd> = QQ.extension(s^2 - d)
    # construct the polynomial ring Q(sqrt(d))[t]
    R.<t> = K['t']
    # try to factor t^2 - (a + b sqrtd) in the polynomial ring
    return len(factor(t^2 - a - b*sqrtd)) > 1;

# Enumerate x = p1/q1 + p2/q2 sqrt (d).
start_time = time.time()
last_status_update_time = start_time
for d in range(-d_max_height, d_max_height+1):
    if d == 0 or d == 1 or d != squarefree_part(d):
        continue

    for p1 in range(-pq_max_height, pq_max_height+1):
        for q1 in range(1, pq_max_height+1):
            if gcd(p1, q1) > 1:
                continue
            for p2 in range(-pq_max_height, pq_max_height+1):
                # skip p2 = 0, i.e., rational x
                if p2 == 0:
                    continue
                for q2 in range(1, pq_max_height+1):
                    if gcd(p2, q2) > 1:
                        continue
                    r1 = ZZ(p1)/ZZ(q1)
                    r2 = ZZ(p2)/ZZ(q2)
                    # calculate the rational and irrational parts of
                    # f(x)
                    fx1 = rational_part(r1, r2, d)
                    fx2 = irrational_part(r1, r2, d)
                    if (is_square_in_qsqrtd(fx1, fx2, d)):
                        # Construct the extension and calculate within
                        # the extension, since AFAIK Sage is very bad
                        # at simplifying nested radicals.
                        s = var('s')
                        K.<sqrtd> = QQ.extension(s^2 - d)
                        R.<t> = K['t']
                        x = r1 + r2 * sqrtd
                        fx = fx1 + fx2 * sqrtd
                        sqrtfx = sqrt(fx)
                        print 'd = ' + str(d) + ', ' + \
                            'x = ' + str(x) + ', ' + \
                            'y = ' + str(sqrtfx) + ', ' + \
                            'c = ' + str(c(x, sqrtfx))
                        print 'd = ' + str(d) + ', ' + \
                            'x = ' + str(x) + ', ' + \
                            'y = ' + str(-sqrtfx) + ', ' + \
                            'c = ' + str(c(x, -sqrtfx))

    if time.time() - last_status_update_time >= 60:
        print '// ' + str(floor(time.time() - start_time)) + \
            ' seconds elapsed; current d: ' + str(d) + ';'
        last_status_update_time = time.time()

print '// Total wall clock time elapsed: ' + \
    str(time.time() - start_time) + 'seconds'
