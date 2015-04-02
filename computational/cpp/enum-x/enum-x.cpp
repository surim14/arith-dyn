#include <iostream>
#include <cstdlib>
#include <time.h>

#include "fmpqxx.h"
#include "fmpzxx.h"
#include "ulong_extras.h"

using namespace flint;

/* constant coefficients that will appear later */

fmpqxx c1(1, 1u);
fmpqxx c5(5, 1u);
fmpqxx c6(6, 1u);
fmpqxx c8(8, 1u);
fmpqxx c10(10, 1u);
fmpqxx c15(15, 1u);
fmpqxx c20(20, 1u);
fmpqxx c22(22, 1u);
fmpqxx c40(40, 1u);
fmpqxx c66(66, 1u);
fmpqxx c80(80, 1u);
fmpqxx c88(88, 1u);
fmpqxx c132(132, 1u);

/**
 * For a, b, and d rational, f(a + b sqrt(d)) will be written in the form
 *
 *     rational_part + irrational_part * sqrt(d)
 *
 * to facilitate taking the norm in the quadratic extension Q(sqrt(d)) to Q.
 *
 * The polynomial expressions are taken from mma/enum-x.m.
 */
inline fmpqxx rational_part(fmpqxx a, fmpqxx b, fmpqxx d)
{
    return fmpqxx(pow(d,3) * pow(b,6) +                                 \
                                                                        \
                  pow(d,2) * (c22 * pow(b,4) + c40 * a * pow(b,4) +     \
                              c15 * pow(a,2) * pow(b,4)) +              \
                                                                        \
                  d * (c5 * pow(b,2) + c66 * a *pow(b,2) +              \
                       c132 * pow(a,2) * pow(b,2) +                     \
                       c80 * pow(a,3) * pow(b,2) +                      \
                       c15 * pow(a,4) * pow(b,2)) +                     \
                                                                        \
                  (c1 + c6 * a + c5 * pow(a,2) + c22 * pow(a,3) +       \
                   c22 * pow(a,4) + c8 * pow(a,5) + pow(a,6)));
}

inline fmpqxx irrational_part(fmpqxx a, fmpqxx b, fmpqxx d)
{
    return fmpqxx(pow(d,2) * (c8 * pow(b,5) + c6 * a * pow(b,5)) +      \
                                                                        \
                  d * (c22 * pow(b,3) + c88 * a * pow(b,3) +            \
                       c80 * pow(a,2) * pow(b,3) +                      \
                       c20 * pow(a,3) * pow(b,3)) +                     \
                                                                        \
                  (c6 * b + c10 * a * b + c66 * pow(a,2) * b +          \
                   c88 * pow(a,3) * b + c40 * pow(a,4) * b +            \
                   c6 * pow(a,5) * b));
}

inline bool is_perfect_square(fmpzxx n)
{
    // if negative, not square
    if (n < 0) {
        return false;
    }
    fmpzxx sqrtn(sqrt(n));
    return (sqrtn * sqrtn == n);
}

inline void test_x(fmpqxx d, slong p1, ulong q1, slong p2, ulong q2)
{
    // x = r1 + r2 sqrt(d), where r1 = p1/q1, r2 = p2/q2
    fmpqxx r1(p1, q1);
    fmpqxx r2(p2, q2);

    // f(x) = fx1 + fx2 sqrt(d)
    fmpqxx fx1(rational_part(r1, r2, d));
    fmpqxx fx2(irrational_part(r1, r2, d));

    // test if the norm of f(x) is a square in Q
    fmpqxx norm(fx1 * fx1 - d * fx2 * fx2);
    fmpzxx norm_num(norm.num());
    fmpzxx norm_den(norm.den());
    if (! is_perfect_square(norm_num) || ! is_perfect_square(norm_den)) {
        return; // not square, do nothing
    }

    // print d, p1, q1, p2, q2 to stdout (separated by blanks); stdout
    // will be piped to enum-x-definitive.sage for the definitive test
    std::cout << d << " " << p1 << " " << q1 << " " << p2 << " " << q2
              << std::endl;
}

int main(int argc, const char *argv[]) {
    if (argc != 3) {
        std::cerr << "error: wrong number of arguments" << std::endl;
        std::cerr << "expecting two arguments: "
                  << "d_max_height and pq_max_height" << std::endl;
        exit(1);
    }
    slong d_max_height = atoi(argv[1]);
    slong pq_max_height = atoi(argv[2]);
    ulong upq_max_height = pq_max_height;

    // enumerate x = p1/q1 + p2/q2 sqrt(d)

    time_t start_time = time(NULL);
    time_t last_status_update_time = start_time;

    for (slong d = -d_max_height; d <= d_max_height; ++d) {
        if (d == 0 || d == 1 || ! n_is_squarefree(d)) continue;
        fmpqxx d_rational(d, 1u); // convert d to fmpqxx

        for (slong p1 = -pq_max_height; p1 <= pq_max_height; ++p1) {
            for (ulong q1 = 1; q1 <= upq_max_height; ++q1) {
                if (n_gcd_full(abs(p1), q1) > 1) continue;
                for (slong p2 = -pq_max_height; p2 <= pq_max_height; ++p2) {
                    if (p2 == 0) continue;
                    for (ulong q2 = 1; q2 <= upq_max_height; ++q2) {
                        if (n_gcd_full(abs(p2), q2) > 1) continue;
                        test_x(d_rational, p1, q1, p2, q2);
                    }
                }
            }
        }

        if (difftime(time(NULL), last_status_update_time) >= 60) {
            std::cerr << "// " << int(difftime(time(NULL), start_time))
                      << " seconds elapsed; current d: " << d << std::endl;
            last_status_update_time = time(NULL);
        }
    }

    std::cerr << "// Total wall clock time elapsed: "
              << difftime(time(NULL), start_time) << " seconds" << std::endl;
    return 0;
}
