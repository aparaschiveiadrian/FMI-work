#Subiectul 2
#b
def top_spiridusi(dictionar, *nume_spiridusi, nr_minim):
    L = []
    for spiridus in nume_spiridusi:
        multime = set()
        cantitate = 0
        indeplinesteCriteriu = False # sa aiba macar un elem > nr_minim
        for jucarie in dictionar[spiridus].keys():
            if dictionar[spiridus][jucarie] >= nr_minim:
                cantitate += dictionar[spiridus][jucarie]
                multime.add(jucarie)
                indeplinesteCriteriu = True
        if indeplinesteCriteriu:
            L.append((spiridus, multime, cantitate))
    #sortarea:
    for i in range(len(L)-1):
        for j in range(i+1, len(L)):
            if len(L[i][1]) < len(L[j][1]):
                L[i], L[j] = L[j], L[i]
            elif len(L[i][1]) == len(L[j][1]):
                if L[i][2] < L[j][2]:
                    L[i], L[j] = L[j], L[i]
                elif L[i][2] == L[j][2]:
                    if L[i][0] > L[j][0]:
                        L[i], L[j] = L[j], L[i]
    return L
#c
def adauga_bucati(dictionar, nume_spiridus, nume_jucarie="", nr_bucati=1):
    if nume_jucarie != "":
        if nume_jucarie not in dictionar[nume_spiridus].keys():
            dictionar[nume_spiridus] = {nume_jucarie: nr_bucati}
        else:
            dictionar[nume_spiridus][nume_jucarie] += nr_bucati
    elif nume_jucarie == "":
        for jucarie in dictionar[nume_spiridus].keys():
            dictionar[nume_spiridus][jucarie] += nr_bucati
    if len(dictionar[nume_spiridus])==0:
        return 0
    return len(dictionar[nume_spiridus])
#a
dictionar = {}
fisier_input = "spiridusi.in"
f_input = open(fisier_input, "r")
inputt = f_input.readlines()
f_input.close()
for line in inputt:
    s = line.split(":")
    nume_spiridus = s[0].strip()
    s2 = s[1].split()
    nume_jucarie = " ".join((s2[:-1]))
    numar_bucati = int(s2[-1])
    if nume_spiridus in dictionar.keys():
        if nume_jucarie in dictionar[nume_spiridus].keys():
            dictionar[nume_spiridus][nume_jucarie] += numar_bucati
        else:
            dictionar[nume_spiridus][nume_jucarie] = numar_bucati
    else:
        dictionar[nume_spiridus] = {nume_jucarie:numar_bucati}
#print(top_spiridusi(dictionar,"Spiridus Harnic", "Spiridus Poznas", "Spiridus Jucaus", nr_minim=3))
#c
ss = input("Nume spiridus:")
jj = input("Nume de jucarie")
print(adauga_bucati(dictionar,ss,jj))
print(dictionar)
