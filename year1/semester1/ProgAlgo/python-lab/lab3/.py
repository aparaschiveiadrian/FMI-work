#LIST COMPREHENSIONS
#a
L = [chr(x) for x in range(ord('a'),ord('z')+1)]
print(L)
#b
n = int(input("n="))
L = [x if x % 2 != 0 else -x for x in range (1, n+1)]
print(L)
#c
n = int(input("n="))
L = [x  for x in range (1, n+1) if x % 2 != 0]
print(L)
#d
L = [int(x) for x in input().split()]
L1= [L[x] for x in range(0,len(L),2)]
print(L1)
#e
L = [int(x) for x in input().split()]
L1 = [L[x] for x in range(len(L)) if x%2==L[x]%2]
print(L1)
#f
L = [int(x) for x in input().split()]
t = [(L[x],L[x+1]) for x in range(len(L)-1)]
print(t)
