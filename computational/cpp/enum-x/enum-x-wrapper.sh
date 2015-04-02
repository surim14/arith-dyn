#!/bin/bash

########## begin customization ##########

# We will enumerate x = p1/q1 + p2/q2 sqrt(d).
# d_max_height is the max height to enumerate d to.
d_max_height=100
# For each d, pq_max_height is the max height to enumerate p1, q1, p2, q2 to.
pq_max_height=30

########## end customization ##########

# compile C++ program
if ! make >make.log 2>&1; then
    echo "error: make returned with nonzero exit status"
    echo "see make.log for details" >&2
    exit 1
fi

./enum-x ${d_max_height} ${pq_max_height} | ./enum-x-definitive.sage
