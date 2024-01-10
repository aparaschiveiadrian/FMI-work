# exercitiul 1 a
def citire_din_fisiere_multiple(lista_de_fisiere):
    frecventa = {}
    for fisier in lista_de_fisiere:
        with open(fisier) as file:
            input = file.readlines()
            for linie in input:
                listaCuv = linie.split()
                for cuv in listaCuv:
                    if cuv in frecventa:
                        frecventa[cuv]+=1
                    else:
                        frecventa[cuv] = 1
    return frecventa

fisiere = "cifre.in input.txt"
lista_de_fisiere = [elem for elem in fisiere.split()]
rezultat = citire_din_fisiere_multiple(lista_de_fisiere)
print(rezultat)
#-------------------------------------------------
#exercitiul 1 b
def citire_din_fisiere_multiple(lista_de_fisiere):
    frecventa = {}
    for fisier in lista_de_fisiere:
        with open(fisier) as file:
            input = file.readlines()
            for linie in input:
                listaCuv = linie.split()
                for cuv in listaCuv:
                    if cuv in frecventa:
                        frecventa[cuv]+=1
                    else:
                        frecventa[cuv] = 1
    return frecventa
def cerinta_b(dictionar):
    L = [elem for elem in dictionar.keys()]
    return sorted(L)
fisiere = "cuvinte1.in cuvinte2.in"
lista_de_fisiere = [elem for elem in fisiere.split()]
rezultat_a = citire_din_fisiere_multiple(lista_de_fisiere)
print(cerinta_b(rezultat_a))
#---------------------------------------------------
#exercitiul 1 c
def citire_din_fisiere_multiple(lista_de_fisiere):
    frecventa = {}
    for fisier in lista_de_fisiere:
        with open(fisier) as file:
            input = file.readlines()
            for linie in input:
                listaCuv = linie.split()
                for cuv in listaCuv:
                    if cuv in frecventa:
                        frecventa[cuv]+=1
                    else:
                        frecventa[cuv] = 1
    return frecventa
def cerinta_c(dictionar):
    L = []
    for cheie in dictionar.keys():
        L.append((cheie,dictionar[cheie]))
    L.sort(key = lambda x: -x[1])
    return L
fisiere = "cuvinte1.in"
lista_de_fisiere = [elem for elem in fisiere.split()]
rezultat_a = citire_din_fisiere_multiple(lista_de_fisiere)
print(cerinta_c(rezultat_a))
#---------------------------------------------------
#Exercitiul 1 d
def citire_din_fisiere_multiple(lista_de_fisiere):
    frecventa = {}
    for fisier in lista_de_fisiere:
        with open(fisier) as file:
            input = file.readlines()
            for linie in input:
                listaCuv = linie.split()
                for cuv in listaCuv:
                    if cuv in frecventa:
                        frecventa[cuv]+=1
                    else:
                        frecventa[cuv] = 1
    return frecventa
def cerinta_d(dictionar):
    maxim = max(dictionar.values())
    cheie_maxim = ""
    for cheie in dictionar.keys():
        if dictionar[cheie] == maxim:
            if cheie_maxim == "" or cheie<cheie_maxim:
                cheie_maxim = cheie
    return cheie_maxim

fisiere = "cuvinte2.in"
lista_de_fisiere = [elem for elem in fisiere.split()]
rezultat_a = citire_din_fisiere_multiple(lista_de_fisiere)
print(cerinta_d(rezultat_a))
#---------------------------------------------------
#Exercitiul 2 
def grupuri_rimate(fisier_input, p):
    dictionar = {}
    with open(fisier_input) as f:
        for line in f:
            for cuvant in line.split():
                sufix = cuvant[-p:]  # Obține sufixul de lungime p
                if sufix in dictionar:
                    dictionar[sufix].append(cuvant)
                else:
                    dictionar[sufix] = [cuvant]

    # Sortează grupurile în funcție de numărul de cuvinte și apoi pe fiecare grup lexicografic descrescător
    grupuri_sortate = sorted(dictionar.values(), key=lambda x: (-len(x), sorted(x, reverse=True)))

    with open("rime.txt", "w") as fout:
        for grup in grupuri_sortate:
            fout.write(" ".join(grup) + "\n")

# Citirea valorii lui p de la tastatură
p = int(input("p="))
fisier_input = input("Numele fisierului de intrare: ")
grupuri_rimate(fisier_input, p)


