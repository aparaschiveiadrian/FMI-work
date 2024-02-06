# EX 1 a)
import math
def divizori(*numere):
    d = {}
    for numar in numere:
        L = []
        x = int(numar)
        if x % 2 == 0:
            L.append(2)
            while x % 2 ==0:
                x = x // 2
        for i in range(3, int(math.sqrt(x))+1, 2):
            if x % i == 0:
                L.append(i)
            while x % i == 0:
                x = x // i
        d[numar] = L
    return d
print(divizori(50,21))
# Ex 1 b)
litere_10 = [chr(i) for i in range(97,107)]
print(litere_10)
# Ex 1 c)
O(log(3,n))
# Ex 2
#L = [1,2,7,-2,9,-7,-8,-4,9,10,5]
# n = 11
def programare_dinamica(L):
    ind_s_maxim = ind_f_maxim = 0
    pos_s = pos_f = 0
    for i in range(1,len(L)):
        if L[i] >= L[i-1]:
            pos_f = i
        elif L[i] < L[i-1]:
            pos_f = i-1
            if (ind_s_maxim + ind_f_maxim) < (pos_s + pos_f):
                ind_s_maxim = pos_s
                ind_f_maxim = pos_f
            pos_s = i
    if (ind_s_maxim + ind_f_maxim) < (pos_s + pos_f):
        ind_s_maxim = pos_s
        ind_f_maxim = pos_f
    return L[ind_s_maxim:ind_f_maxim+1]
print(programare_dinamica([1,2,-1,5,6,7,8]))
#complexitatea este liniara, adica O(n)

# Ex 3
def bkt(pas):
    global arr, n
    for i in range(1, n+1):
        arr[pas] = i
        if arr[pas] not in arr[:pas]:
            if pas == n:
                print(*arr[1:])
            else:
                bkt(pas+1)

n = int(input())
arr = [0] * (n+1)
bkt(1)
