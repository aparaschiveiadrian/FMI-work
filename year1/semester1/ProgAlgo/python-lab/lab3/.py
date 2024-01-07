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
#g
def matrice(n):
    L = [
        [ f"{i}*{j}={i*j}" for j in range(1,n+1)]
        for i in range(1, n+1)
        ]
    return L
n = int(input())
result = matrice(n)
for row in result:
    print (*row)
#h
s = input("string=")  #abcde
L = [(s[i:] + s[:i]) for i in range(len(s))] #abcde bcdea cdeab deabc eabcd
print(L)
#i
def genereaza(n):
    L = [
        [int(j) for i in range (j)]
        for j in range (0,n)
    ]
    return L
n = int(input())
result = genereaza(n)
for row in result:
    print(row)
  # Sortari liste
  #a
  L = [x for x in input().split()]
L.sort(key=lambda x:int(x))
print (L)
#c
L = [x for x in input().split()]
L.sort(key=lambda x:len(str(abs(int(x)))))
print (L)
#d
L = [int(x) for x in input().split()]
L.sort(key=lambda x:len(set(str(x))))
print (L)
#e
numere = [123, 45, 789, 321, 56, 1000]

numere_sortate = sorted(numere, key=lambda x: (len(str(x)), x))
print(numere_sortate)
# OPERATII CU LISTE
#a
l1 = [1, 2, 3, 4, 5]
l2 = [10, 20, 30, 40, 50]

l1[1::2] = l2[1::2]
print(l1)
#b
numere = [1, 3, 5, 0, 2, 4, 6, 0, 8, 9]

index_1 = numere.index(0)  # Găsește indexul primului zero
index_2 = numere.index(0, index_1 + 1)  # Găsește indexul celui de-al doilea zero

numere = numere[:index_1] + numere[index_2+1:]  # Creează o nouă listă fără subsecvența delimitată de zerouri
print(numere)
#c
numere = [0, 2, 0, 4, 0, 6, 8, 0, 10, 0]

while 0 in numere:
    numere.remove(0)

print(numere)
#d
l = [int(x) for x in input().split()]
k = int(input())
suma= sum(l[:k])
pos1= 0
pos2=k
for i in range(1,len(l)-k):
    if sum(l[i:]+l[:k]) < suma:
        suma = sum(l[i:]+l[:k])
        pos1= i
        pos2 = i+k
print(l[:pos1]+l[pos2:])
#e
l= [1,2, 2,3,4,5,6,7,8,9]
s = set(l)
print(*s)
#f
lista = [1, -2, 3, -4, 5, -6]

index = 0
while index < len(lista):
    if lista[index] < 0:
        lista.insert(index + 1, 0)
        index += 2  # Trecem peste elementul negativ și zero-ul inserat
    else:
        index += 1

print(lista)
#SORTARI
#1
propozitie = input("Propozitie:").split()
L = [x for x in propozitie if len(x)>=2]
L.sort(key=lambda x: len(x))
print(L)
#2
def suma_cifrelor(x):
    suma = 0
    while(x):
        suma = suma + x%10
        x//=10
    return suma
L = [11,45,20,810,179,81,1000]
L.sort(key=lambda x:(suma_cifrelor(x),-x))
print(L)
#3
#a
n = int(input())
L=[]
for i in range(1,n+1):
    s=input().split()
    w = [int(x) for x in s[3::]]
    g = [s[0],s[1],int(s[2])]
    g.append(w)
    L.append(g)
print(L)

#b
