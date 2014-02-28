"""
The script below shows that Python does not support tail call optimization.
"""
from memory_profiler import profile


def fact(n):
    if n == 0:
        return 1
    else:
        return n * fact(n - 1)


def fact_tail(n, a=1):
    if n == 0:
        return a
    else:
        return fact_tail(n - 1, n * a)


def fact_loop(n, a=1):
    while True:
        if n == 0:
            return a
        n, a = n - 1, n * a


@profile
def main(n):
    #a = [fact_tail(i) for i in xrange(n)]
    b = [fact(i) for i in xrange(n)]
    #c = [fact_loop(i) for i in xrange(n)]

if __name__ == '__main__':
    main(500)
