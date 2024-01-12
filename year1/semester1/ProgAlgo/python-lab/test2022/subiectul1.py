#Subiectul 1
#a
def citire_liste(fisier_input):
    L = []
    with open(fisier_input) as file:
        n = file.readline()
        n = int(n)
        input = file.readlines()
        for i in range(n):
            l = []
            L.append(l)
        for line in input:
            line = line.split()
            x = int(line[0])
            y = int(line[1])
            L[y].append(x)
    return L
#b
def prelucrare_liste(lista, x):
    for sublista in lista:
        while x in sublista:
            sublista.remove(x)
    for sublista in lista:
        if(len(sublista) <=1):
            lista.remove(sublista)
    return lista
#c
lista_citita = citire_liste("liste.in")
lista_prelucrata = prelucrare_liste(lista_citita, 0)
for sublista in lista_prelucrata:
    for elem in sublista:
        print(elem, end = " ")
    print()
#d
k = int(input("K:"))
multime = set()
g = open("divizori.out" , "w")
for sublista in lista_citita:
    for elem in sublista:
        count = 0
        for i in range (1,elem+1):
            if (elem%i) == 0:
                count+=1
        if count == k:
            multime.add(elem)
multime = sorted(multime, reverse=True)
for elem in multime:
    g.write(str(elem) + "\n")
g.close()
