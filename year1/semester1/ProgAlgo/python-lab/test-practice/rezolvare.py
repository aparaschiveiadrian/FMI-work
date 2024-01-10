#Subiectul 1
# a
# Scrieti o functie citire_numere cu un parametru
# reprezentand numele unui fisier
# text care contine, pe mai multe linii,
# numere naturale despartite intre ele
# prin spatii si returneaza o lista de liste(numite subliste),
# elementele unei subliste fiind numerele de pe o linie din fisier
def citire_numere(fisier_text):
    with open(fisier_text) as f:
        subliste = []
        for line in f:
            numere = [int(x) for x in line.split()]
            subliste.append(numere)
    return subliste
nume_fisier = "input.txt"
rezultat = citire_numere(nume_fisier)
print(rezultat)

#b
#Sa se scrie o functie prelucrare_lista care primeste
#ca parametru o lista de liste pe care o modifica astfel:
#-din fiecare sublista se vor elimina aparitiile valorii minime,apoi
#-din fiecare sublista, se pastreaza doar primele m elem
#-m reprezinta lungimea minima a unei subliste
def prelucrare_lista(lista):
    minLungimeLista = len(lista[0])
    for linie in lista:
            minim = min(linie)
            while minim in linie:
                linie.remove(minim)
            minLungimeLista = min(minLungimeLista, len(linie))
    k=0
    for linie in lista:
        linieNoua = linie[:minLungimeLista]
        lista[k] = linieNoua
        k+=1
    return lista
L= [[1,2,3,1,1,1,1],[5,234,234,3, 3, 9, 6, 5, 4, 4, 4,213]]
L = prelucrare_lista(L)
print(L)
#c
#Se da fisierul "numere.in" cu urmatoarea structura:
#pe linia i se afla separate prin cate un spatiu n numere
#naturale reprezentand elementele de pe linia i a unei
# matrice, c ain exemplul de mai jos.
#sa se apeleze functia prelucrare_lista pentru matricea
#obtinuta in urma apelului functiei citire_numere
#pentru fisierul text numere.in
#Matricea astfel obtinuta sa se afiseze pe ecran, fara paranteze
#si virgule, iar elementele de pe fiecare linie sa fie
#separate prin cate un spatiu.
def citire_numere(fisier_text):
    with open(fisier_text) as f:
        subliste = []
        for line in f:
            numere = [int(x) for x in line.split()]
            subliste.append(numere)
    return subliste
def prelucrare_lista(lista):
    minLungimeLista = len(lista[0])
    for linie in lista:
            minim = min(linie)
            while minim in linie:
                linie.remove(minim)
            minLungimeLista = min(minLungimeLista, len(linie))
    k=0
    for linie in lista:
        linieNoua = linie[:minLungimeLista]
        lista[k] = linieNoua
        k+=1
    return lista
nume_fisier = "numere.in"
lista_citita =  citire_numere(nume_fisier)
rezultat = prelucrare_lista(lista_citita)
print(rezultat)
#d
#Fie L matricea (memorata ca lista de liste)
# obtinuta in urma apelarii functiei citire_numere
#pentru fisierul text "numere.in". Sa se citeasca de la tastatura
#un numar natural nenul k si apoi sa se scrie in fisierul
#text "cifre.out" elementele matricei L care sunt formate
#din exact k cifre sau mesajul "Imposibil!" daca nu exista niciun
#element cu proprietatea ceruta.Elementele vor fi scrise in
#fisier in ordine descrescatoare si fara duplicate
def citire_numere(fisier_text):
    with open(fisier_text) as f:
        subliste = []
        for line in f:
            numere = [int(x) for x in line.split()]
            subliste.append(numere)
    return subliste
nume_fisier_in = "numere.in"
nume_fisier_out = "cifre.out"
lista_citita =  citire_numere(nume_fisier_in)

k = int(input("Numarul k este: "))
#elementele de lungime k in lista_noua, fara a se repeta
lista_noua =[]
for linie in lista_citita:
    for x in linie:
        if(len(str(x)) == k and x not in lista_noua):
            lista_noua.append(x)
#sortam descrescator acum
lista_noua.sort(key=lambda x: -x) #sortare desc
with open(nume_fisier_out, "w") as file:
    for x in lista_noua:
        file.write(str(x) + " ")
#Exercitiul 2
#a
def citire(nume_fisier):
    with open(nume_fisier, "r") as file:
        program = {}
        program_citit = file.readlines()
        for line in program_citit:
            linie = line.strip().split(sep="%")
            linie_temp = [elem.strip() for elem in linie]
            nume_cinema, nume_film, ore_film = linie_temp[0], linie_temp[1], linie_temp[2]

            if nume_cinema in program:
                program[nume_cinema].append((nume_film, ore_film))
            else:
                program[nume_cinema] = [(nume_film, ore_film)]  # Folosim o listă pentru a memora mai multe filme

    return program

fisier = "cifre.in"
rezultat = citire(fisier)
print(rezultat)
#b
def citire_fiser(nume_fisier):
    program = {}
    with open(nume_fisier, "r") as file:

        lines = file.readlines()
        for line in lines:
            linieDeAdaugat = line.split(sep = "%")
            nume_cinema, nume_film, ore_film = linieDeAdaugat[0].strip(), linieDeAdaugat[1].strip(), linieDeAdaugat[2].strip()
            if nume_cinema in program:
                program[nume_cinema].append((nume_film, ore_film))
            else:
                program[nume_cinema] = [(nume_film, ore_film)]
    return program
def sterge_ore(structura, cinema, film, ore):
    noul_program ={}
    for c in structura:
        for (f, o) in structura[c]:
            if f == film and o in ore:
                pass
            else:
                if cinema in noul_program:
                    noul_program[cinema].append((f, o))
                else:
                    noul_program[cinema] = [(f, o)]
    return noul_program



fisierIn = "cifre.in"
rezultat = citire_fiser(fisierIn)
orar = {"20:00","21:30","22:30"}
print(sterge_ore(rezultat, "Cinema 1", "Minionii 2", orar))

#c

