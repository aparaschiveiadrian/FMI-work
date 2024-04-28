if __name__ == "__main__":
    #numeFisierInput = "input.txt"
    #fisierIn = open(numeFisierInput, "r")
    numarStari = int(input("Numar stari: "))
    stari = [int(num) for num in input().split()]
    numarLitere = int(input("Numar litere: "))
    litere = input("Litere: ").split()
    stareInitiala = int(input("Stare initiala: "))
    numarStariFinale = int(input("Numar stari finale: "))
    stariFinale = [int(num) for num in input().split()]
    numarTranzitii = int(input("Numarul de tranzitii: "))
    tranzitii = []
    cuvinte = []
    rezultate = []
    for i in range(numarTranzitii):
        s = input()
        tranzitii.append(tuple(s.split()))# [0] - stare, [1] - cost, [2] - starea urmatoare
    numarCuvinte = int(input("numarul de cuvinte: "))
    for i in range(numarCuvinte):
        cuv = input("cuvant: ")
        cuvinte.append(cuv)
    for cuvant in cuvinte:
        stareCurenta = stareInitiala
        gasit = False
        for lit in cuvant:
            gasit = False
            for tranzitie in tranzitii:
                if int(tranzitie[0]) == stareCurenta and tranzitie[1] == lit:
                    stareCurenta = int(tranzitie[2])
                    gasit = True
                    break
            if not gasit:
                stareCurenta = -1
                break
        esteFinal = False
        if stareCurenta >= 0:
            if stareCurenta in stariFinale:
                esteFinal = True
                break
        if esteFinal and stareCurenta >= 0:
            rezultate.append("DA")
        else:
            rezultate.append("NU")

    numeFisier = "output.txt"
    with open(numeFisier, "w") as fisier:
        for raspuns in rezultate:
            fisier.write(raspuns + "\n")
