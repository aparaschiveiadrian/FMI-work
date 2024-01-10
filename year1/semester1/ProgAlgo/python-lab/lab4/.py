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
