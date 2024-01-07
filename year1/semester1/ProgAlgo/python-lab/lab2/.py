#1
s = input("stringul tau:")
X = s[0]
i= 0
while i < len(s):
    if(s[i] == X):
        s = s[:i] + s[i+1:]
    else:
        i+=1
print(f"Dupa stergerea literei '{X}' a fost obtinut stringul {s} de lungime {len(s)}")

#2
t = input("t=")
s = input("s=")
p = s.find(t)
while p != -1:
    print(p, end=" ")
    p = s.find(t, p+1)
print()
try:
    p = s.index(t)
    while p!=-1:
        print(p, end=" ")
        p = s.index(t, p+1)
except:
    pass


#3
s = input("s=")
lungime = len(s)
j = lungime
i = 0
while i < j:
    print(s[i:j].center(lungime))
    i+=1
    j-=1

#4
s = input()
cs=s

greseala = input()
corectare = input()

#a)
s = s.replace(greseala, corectare)
print(s)

#b)
s=cs
k = s.count(greseala)

if k > 2:
    print("textul contine prea multe greseli, doar 2 au fost corectate")

    s = s.replace(greseala, corectare, 2)
    print(s)

#5
p = input("propozitie : ")
s = input("cuvant cautat : ")
t = input ("inlocuire : ")
p = p.split(" ")
for i in range(len(p)):
    if p[i] == s:
        p[i] = t
p=" ".join(p)
print(p)

#6
s = input("s=")
t = ""
numar= 0
for i in range(len(s)):
    while '0'<=s[i]<='9':
        numar = numar*10 + int(s[i])
        i+=1
    if 'a'<=s[i]<='z' or 'A'<=s[i]<='Z':
        t=t+s[i]*numar
        numar= 0
        i+=1
print(t)

#7
s = input("Propozitia este:").split()
sum =0
for i in range(len(s)):
    numar=0
    if '0'<=s[i][0]<='9':
        for j in range(len(s[i])):
            numar = numar *10 + int(s[i][j])
    sum+=numar
print(sum)
#8
s= input("Input:").split()
nume = s[0].split(sep="-")
prenume = s[1].split(sep="-")
if len(nume[0]) <3 or len(prenume[0]) < 3 or len(nume[1]) <3 or len(prenume[1]) < 3:
    print("Gresit")
else:
    if "A"<=nume[0][0]<="Z" or "A"<=nume[1][0]<="Z" or "A"<=prenume[0][0]<="Z" or "A"<=prenume[1][0]<="Z" or "A"<=nume[1][0]<="Z":
        print("Corect")
    else:
        print("Incorrect")


