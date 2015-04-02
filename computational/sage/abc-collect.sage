#!/usr/bin/env sage
a,b,c = QQ['a,b,c'].gens()
lambda1 = 110-325*a+452*a^2-271*a^3+74*a^4-8*a^5-452*b+542*a*b-222*a^2*b+32*a^3*b+74*b^2-24*a*b^2+96*c-380*a*c+416*a^2*c-184*a^3*c+40*a^4*c-4*a^5*c-416*b*c+368*a*b*c-120*a^2*b*c+16*a^3*b*c+40*b^2*c-12*a*b^2*c-144*a*c^2+96*a^2*c^2-16*a^3*c^2-96*b*c^2+32*a*b*c^2
lambda0 = 64-325*b+452*a*b-271*a^2*b+74*a^3*b-8*a^4*b+271*b^2-148*a*b^2+24*a^2*b^2-8*b^3+36*c-380*b*c+416*a*b*c-184*a^2*b*c+40*a^3*b*c-4*a^4*b*c+184*b^2*c-80*a*b^2*c+12*a^2*b^2*c-4*b^3*c-144*b*c^2+96*a*b*c^2-16*a^2*b*c^2+16*b^2*c^2
print 'lambda1:'
print 'c^2: ' + latex(lambda1.coefficient({c:2}).factor())
print 'c^1: ' + latex(lambda1.coefficient({c:1}).factor())
print 'c^0: ' + latex(lambda1.coefficient({c:0}).factor())
print 'lambda0:'
print 'c^2: ' + latex(lambda0.coefficient({c:2}).factor())
print 'c^1: ' + latex(lambda0.coefficient({c:1}).factor())
print 'c^0: ' + latex(lambda0.coefficient({c:0}).factor())
